import '../../models/camera_models.dart';
import '../../models/vision_models.dart';

abstract class VisionEngine {
  Future<VisionResult> process({
    required String imageId,
    required CameraSource source,
    required List<int> imageBytes,
    required DateTime capturedAt,
  });
}
