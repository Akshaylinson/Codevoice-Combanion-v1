import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as image_lib;

import '../../models/camera_models.dart';
import '../../models/vision_models.dart';
import '../domain/vision_engine.dart';

class MlKitVisionEngine implements VisionEngine {
  @override
  Future<VisionResult> process({
    required String imageId,
    required CameraSource source,
    required String imagePath,
    required List<int> imageBytes,
    required DateTime capturedAt,
  }) async {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) {
      throw UnsupportedError('ML Kit vision is only supported on Android and iOS.');
    }

    final stopwatch = Stopwatch()..start();
    final decodedImage = image_lib.decodeImage(Uint8List.fromList(imageBytes));
    final imageWidth = decodedImage?.width ?? 1;
    final imageHeight = decodedImage?.height ?? 1;
    final inputImage = InputImage.fromFilePath(imagePath);

    final faceStopwatch = Stopwatch()..start();
    final faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
        enableClassification: true,
        enableLandmarks: false,
        enableContours: false,
        enableTracking: false,
        minFaceSize: 0.1,
      ),
    );
    final faces = await faceDetector.processImage(inputImage);
    await faceDetector.close();
    faceStopwatch.stop();

    final objectStopwatch = Stopwatch()..start();
    // The base ObjectDetector has no label vocabulary for common objects like
    // monitors, keyboards, etc. — it only returns generic coarse categories.
    // ImageLabeler uses a 400+ class MobileNet model and correctly identifies
    // specific objects. We use ObjectDetector for bounding boxes only, then
    // pair each box with the best matching ImageLabeler label by confidence.
    final objectDetector = ObjectDetector(
      options: ObjectDetectorOptions(
        mode: DetectionMode.single,
        classifyObjects: false,   // disable — labels from base model are useless
        multipleObjects: true,
      ),
    );
    final objects = await objectDetector.processImage(inputImage);
    await objectDetector.close();
    objectStopwatch.stop();

    final labelStopwatch = Stopwatch()..start();
    final imageLabeler = ImageLabeler(
      options: ImageLabelerOptions(confidenceThreshold: 0.4),
    );
    final imageLabels = await imageLabeler.processImage(inputImage);
    await imageLabeler.close();
    // Sort descending by confidence so the best labels come first.
    final sortedLabels = [...imageLabels]..sort((a, b) => b.confidence.compareTo(a.confidence));
    labelStopwatch.stop();

    final ocrStopwatch = Stopwatch()..start();
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final recognizedText = await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    ocrStopwatch.stop();

    final qrStopwatch = Stopwatch()..start();
    final barcodeScanner = BarcodeScanner(formats: <BarcodeFormat>[BarcodeFormat.qrCode]);
    final barcodes = await barcodeScanner.processImage(inputImage);
    await barcodeScanner.close();
    qrStopwatch.stop();

    stopwatch.stop();

    final visionFaces = faces
        .map(
          (face) => VisionFace(
            boundingBox: _normalizeBoundingBox(face.boundingBox, imageWidth, imageHeight),
            confidence: _clampConfidence(_faceConfidence(face)),
          ),
        )
        .toList();

    // Build VisionObjects: one per detected bounding box, labelled from
    // ImageLabeler. If there are more boxes than labels, cycle through labels.
    // If no boxes were found but labels exist, synthesise one object per label.
    final visionObjects = <VisionObject>[];
    if (objects.isNotEmpty) {
      for (var i = 0; i < objects.length; i++) {
        final labelEntry = sortedLabels.isEmpty ? null : sortedLabels[i % sortedLabels.length];
        visionObjects.add(VisionObject(
          label: labelEntry?.label.trim() ?? 'Object',
          confidence: _clampConfidence(labelEntry?.confidence ?? 0.0),
          boundingBox: _normalizeBoundingBox(objects[i].boundingBox, imageWidth, imageHeight),
        ));
      }
    } else if (sortedLabels.isNotEmpty) {
      // No bounding boxes — surface top labels as full-frame objects.
      for (final label in sortedLabels.take(5)) {
        visionObjects.add(VisionObject(
          label: label.label.trim(),
          confidence: _clampConfidence(label.confidence),
          boundingBox: const VisionBoundingBox(left: 0, top: 0, width: 1, height: 1),
        ));
      }
    }

    final ocrBlocks = recognizedText.blocks
        .map(
          (block) => VisionTextBlock(
            text: block.text.trim(),
            confidence: null,
            language: block.recognizedLanguages.isEmpty ? 'und' : block.recognizedLanguages.first,
          ),
        )
        .where((block) => block.text.isNotEmpty)
        .toList();

    final qrResults = barcodes
        .map(
          (barcode) => VisionQrResult(
            rawValue: (barcode.rawValue ?? barcode.displayValue ?? '').trim(),
            format: barcode.format.name,
            confidence: null,
          ),
        )
        .where((barcode) => barcode.rawValue.isNotEmpty)
        .toList();

    final stages = <VisionPipelineStage>[
      VisionPipelineStage(name: 'Pre-processing', durationMs: faceStopwatch.elapsedMilliseconds, isCompleted: true),
      VisionPipelineStage(name: 'Face Detection', durationMs: faceStopwatch.elapsedMilliseconds, isCompleted: true),
      VisionPipelineStage(name: 'Object Detection', durationMs: objectStopwatch.elapsedMilliseconds, isCompleted: true),
      VisionPipelineStage(name: 'Image Labeling', durationMs: labelStopwatch.elapsedMilliseconds, isCompleted: true),
      VisionPipelineStage(name: 'OCR', durationMs: ocrStopwatch.elapsedMilliseconds, isCompleted: true),
      VisionPipelineStage(name: 'QR Detection', durationMs: qrStopwatch.elapsedMilliseconds, isCompleted: true),
    ];

    final confidences = <double>[
      ...visionFaces.map((face) => face.confidence),
      ...visionObjects.map((object) => object.confidence),
    ];

    return VisionResult(
      imageId: imageId,
      timestamp: capturedAt,
      cameraSource: source,
      faces: visionFaces,
      objects: visionObjects,
      ocrBlocks: ocrBlocks,
      qrResults: qrResults,
      confidence: confidences.isEmpty ? 0.0 : confidences.reduce((a, b) => a + b) / confidences.length,
      processingTimeMs: stopwatch.elapsedMilliseconds,
      stages: stages,
    );
  }

  VisionBoundingBox _normalizeBoundingBox(Rect rect, int imageWidth, int imageHeight) {
    return VisionBoundingBox(
      left: _clampNormalized(rect.left / imageWidth),
      top: _clampNormalized(rect.top / imageHeight),
      width: _clampNormalized(rect.width / imageWidth),
      height: _clampNormalized(rect.height / imageHeight),
    );
  }

  double _faceConfidence(Face face) {
    final classifications = <double?>[
      face.smilingProbability,
      face.leftEyeOpenProbability,
      face.rightEyeOpenProbability,
    ].whereType<double>().toList();
    if (classifications.isEmpty) {
      return 0.0;
    }
    return classifications.reduce((a, b) => a + b) / classifications.length;
  }

  double _clampNormalized(double value) => value.clamp(0.0, 1.0);

  double _clampConfidence(double value) => value.clamp(0.0, 1.0);
}
