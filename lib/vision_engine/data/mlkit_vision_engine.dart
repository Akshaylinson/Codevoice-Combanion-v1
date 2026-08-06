import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../models/camera_models.dart';
import '../../models/vision_models.dart';
import '../domain/vision_engine.dart';

class MlKitVisionEngine implements VisionEngine {
  static const _modelAsset = 'assets/models/efficientdet_lite0.tflite';
  static const _minConfidence = 0.45;

  // Copy the bundled TFLite model to a local file path that ML Kit can open.
  Future<String> _modelPath() async {
    final dir = await getApplicationDocumentsDirectory();
    final dest = File(p.join(dir.path, 'efficientdet_lite0.tflite'));
    if (!dest.existsSync()) {
      final bytes = await rootBundle.load(_modelAsset);
      await dest.writeAsBytes(bytes.buffer.asUint8List());
    }
    return dest.path;
  }

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
    final inputImage = InputImage.fromFilePath(imagePath);

    // --- Object detection with EfficientDet-Lite0 (COCO 80 classes) ---
    // This model knows: bottle, keyboard, mouse, laptop, car, person,
    // chair, cell phone, monitor, book, cup, and 70+ more specific classes.
    final objectStopwatch = Stopwatch()..start();
    final modelPath = await _modelPath();
    final objectDetector = ObjectDetector(
      options: LocalObjectDetectorOptions(
        modelPath: modelPath,
        classifyObjects: true,
        multipleObjects: true,
        mode: DetectionMode.single,
        confidenceThreshold: _minConfidence,
      ),
    );
    final detectedObjects = await objectDetector.processImage(inputImage);
    await objectDetector.close();
    objectStopwatch.stop();

    // --- OCR: every line from every block ---
    final ocrStopwatch = Stopwatch()..start();
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final recognizedText = await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    ocrStopwatch.stop();

    // --- QR / barcode ---
    final qrStopwatch = Stopwatch()..start();
    final barcodeScanner = BarcodeScanner(formats: [BarcodeFormat.qrCode]);
    final barcodes = await barcodeScanner.processImage(inputImage);
    await barcodeScanner.close();
    qrStopwatch.stop();

    stopwatch.stop();

    // Build VisionObjects — each detected object with its specific label.
    final visionObjects = detectedObjects.map((obj) {
      final topLabel = obj.labels.isEmpty ? null : obj.labels.first;
      return VisionObject(
        label: topLabel?.text.trim() ?? 'Object',
        confidence: _clamp(topLabel?.confidence ?? 0.0),
        boundingBox: const VisionBoundingBox(left: 0, top: 0, width: 1, height: 1),
      );
    }).toList();

    // Collect every line so small text is not lost.
    final ocrBlocks = <VisionTextBlock>[];
    for (final block in recognizedText.blocks) {
      for (final line in block.lines) {
        final text = line.text.trim();
        if (text.isNotEmpty) {
          ocrBlocks.add(VisionTextBlock(
            text: text,
            confidence: null,
            language: block.recognizedLanguages.isEmpty ? 'und' : block.recognizedLanguages.first,
          ));
        }
      }
    }

    final qrResults = barcodes
        .map((b) => VisionQrResult(
              rawValue: (b.rawValue ?? b.displayValue ?? '').trim(),
              format: b.format.name,
              confidence: null,
            ))
        .where((b) => b.rawValue.isNotEmpty)
        .toList();

    final stages = [
      VisionPipelineStage(name: 'Object Detection (EfficientDet)', durationMs: objectStopwatch.elapsedMilliseconds, isCompleted: true),
      VisionPipelineStage(name: 'OCR', durationMs: ocrStopwatch.elapsedMilliseconds, isCompleted: true),
      VisionPipelineStage(name: 'QR Detection', durationMs: qrStopwatch.elapsedMilliseconds, isCompleted: true),
    ];

    final avgConfidence = visionObjects.isEmpty
        ? 0.0
        : visionObjects.map((o) => o.confidence).reduce((a, b) => a + b) / visionObjects.length;

    return VisionResult(
      imageId: imageId,
      timestamp: capturedAt,
      cameraSource: source,
      faces: const [],
      objects: visionObjects,
      ocrBlocks: ocrBlocks,
      qrResults: qrResults,
      confidence: _clamp(avgConfidence),
      processingTimeMs: stopwatch.elapsedMilliseconds,
      stages: stages,
    );
  }

  double _clamp(double value) => value.clamp(0.0, 1.0);
}
