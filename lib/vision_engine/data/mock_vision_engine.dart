import 'dart:math';

import '../../models/camera_models.dart';
import '../../models/vision_models.dart';
import '../domain/vision_engine.dart';

class MockVisionEngine implements VisionEngine {
  @override
  Future<VisionResult> process({
    required String imageId,
    required CameraSource source,
    required List<int> imageBytes,
    required DateTime capturedAt,
  }) async {
    final stopwatch = Stopwatch()..start();
    final seed = imageBytes.fold<int>(source.id.hashCode, (previous, value) => previous + value);
    final rng = Random(seed);
    final faceCount = 1 + rng.nextInt(3);
    final faces = List<VisionFace>.generate(faceCount, (index) {
      final left = 0.12 + (index * 0.18) + rng.nextDouble() * 0.06;
      final top = 0.18 + rng.nextDouble() * 0.18;
      return VisionFace(
        boundingBox: VisionBoundingBox(
          left: left.clamp(0.05, 0.75),
          top: top.clamp(0.05, 0.75),
          width: 0.18 + rng.nextDouble() * 0.12,
          height: 0.18 + rng.nextDouble() * 0.12,
        ),
        confidence: 0.72 + rng.nextDouble() * 0.24,
      );
    });

    final labels = <String>[
      'Laptop',
      'Bottle',
      'Notebook',
      'Tablet',
      'Keyboard',
      'Desk Lamp',
      'Phone',
      'Chair',
    ];
    final objectCount = 2 + rng.nextInt(4);
    final objects = List<VisionObject>.generate(objectCount, (index) {
      final label = labels[(seed + index) % labels.length];
      return VisionObject(
        label: label,
        confidence: 0.65 + rng.nextDouble() * 0.3,
        boundingBox: VisionBoundingBox(
          left: 0.08 + rng.nextDouble() * 0.7,
          top: 0.1 + rng.nextDouble() * 0.65,
          width: 0.12 + rng.nextDouble() * 0.18,
          height: 0.12 + rng.nextDouble() * 0.18,
        ),
      );
    });

    final ocrBlocks = <VisionTextBlock>[
      VisionTextBlock(
        text: 'Image ID ${imageId.substring(0, 8).toUpperCase()}',
        confidence: 0.94,
        language: 'en',
      ),
      VisionTextBlock(
        text: 'Camera ${source.label}',
        confidence: 0.91,
        language: 'en',
      ),
    ];
    final qrResults = <VisionQrResult>[
      VisionQrResult(
        rawValue: 'codevoice://capture/$imageId',
        format: 'QR_CODE',
        confidence: 0.88,
      ),
    ];
    stopwatch.stop();
    final stages = <VisionPipelineStage>[
      const VisionPipelineStage(name: 'Pre-processing', durationMs: 9, isCompleted: true),
      const VisionPipelineStage(name: 'Face Detection', durationMs: 14, isCompleted: true),
      const VisionPipelineStage(name: 'Object Detection', durationMs: 18, isCompleted: true),
      const VisionPipelineStage(name: 'OCR', durationMs: 11, isCompleted: true),
      const VisionPipelineStage(name: 'QR Detection', durationMs: 6, isCompleted: true),
    ];
    return VisionResult(
      imageId: imageId,
      timestamp: capturedAt,
      cameraSource: source,
      faces: faces,
      objects: objects,
      ocrBlocks: ocrBlocks,
      qrResults: qrResults,
      confidence: 0.76 + rng.nextDouble() * 0.18,
      processingTimeMs: stopwatch.elapsedMilliseconds == 0 ? 58 : stopwatch.elapsedMilliseconds,
      stages: stages,
    );
  }
}
