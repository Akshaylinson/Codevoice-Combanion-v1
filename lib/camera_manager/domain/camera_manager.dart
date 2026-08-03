import '../../models/camera_models.dart';

class CameraCapture {
  const CameraCapture({
    required this.source,
    required this.imageBytes,
    required this.previewBytes,
    required this.capturedAt,
    required this.deviceInfo,
    required this.settings,
  });

  final CameraSource source;
  final List<int> imageBytes;
  final List<int> previewBytes;
  final DateTime capturedAt;
  final CameraDeviceInfo deviceInfo;
  final CameraSettings settings;
}

abstract class CameraManager {
  Future<List<CameraSource>> discoverSources();
  Future<void> connect(String sourceId);
  Future<void> disconnect(String sourceId);
  Future<void> startPreview(String sourceId);
  Future<void> stopPreview(String sourceId);
  Future<CameraCapture> capture(String sourceId);
  Future<void> updateSettings(String sourceId, CameraSettings settings);
  Future<CameraDeviceInfo> deviceInfo(String sourceId);
  Future<CameraSettings> settingsFor(String sourceId);
}
