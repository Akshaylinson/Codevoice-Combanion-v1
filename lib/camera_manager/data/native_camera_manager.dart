import 'package:camera/camera.dart';

import '../../models/camera_models.dart';
import '../domain/camera_manager.dart';

class NativeCameraManager implements CameraManager {
  final Map<String, CameraController> _controllers = {};
  List<CameraDescription>? _cameras;

  Future<List<CameraDescription>> _getCameras() async {
    _cameras ??= await availableCameras();
    return _cameras!;
  }

  CameraDescription? _descriptionFor(String sourceId) {
    if (_cameras == null) return null;
    if (sourceId == 'phone_front') {
      return _cameras!.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras!.first,
      );
    }
    return _cameras!.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
      orElse: () => _cameras!.first,
    );
  }

  CameraController? controllerFor(String sourceId) => _controllers[sourceId];

  @override
  Future<List<CameraSource>> discoverSources() async {
    final cameras = await _getCameras();
    return cameras.map((c) {
      final isRear = c.lensDirection == CameraLensDirection.back;
      return CameraSource(
        id: isRear ? 'phone_rear' : 'phone_front',
        label: isRear ? 'Phone Rear Camera' : 'Phone Front Camera',
        type: isRear ? CameraSourceType.phoneRear : CameraSourceType.phoneFront,
        isAvailable: true,
        manufacturer: 'Android',
        model: c.name,
        connectionHint: 'Native device camera',
      );
    }).toList();
  }

  @override
  Future<void> connect(String sourceId) async {
    await startPreview(sourceId);
  }

  @override
  Future<void> disconnect(String sourceId) async {
    await stopPreview(sourceId);
  }

  @override
  Future<void> startPreview(String sourceId) async {
    if (_controllers.containsKey(sourceId)) return;
    await _getCameras();
    final desc = _descriptionFor(sourceId);
    if (desc == null) return;
    final controller = CameraController(desc, ResolutionPreset.high, enableAudio: false);
    await controller.initialize();
    _controllers[sourceId] = controller;
  }

  @override
  Future<void> stopPreview(String sourceId) async {
    final controller = _controllers.remove(sourceId);
    await controller?.dispose();
  }

  @override
  Future<CameraCapture> capture(String sourceId) async {
    await startPreview(sourceId);
    final controller = _controllers[sourceId]!;
    final xFile = await controller.takePicture();
    final bytes = await xFile.readAsBytes();
    final settings = await settingsFor(sourceId);
    final info = await deviceInfo(sourceId);
    final sources = await discoverSources();
    final source = sources.firstWhere(
      (s) => s.id == sourceId,
      orElse: () => sources.first,
    );
    return CameraCapture(
      source: source,
      imageBytes: bytes,
      previewBytes: bytes,
      capturedAt: DateTime.now(),
      deviceInfo: info,
      settings: settings,
    );
  }

  @override
  Future<void> updateSettings(String sourceId, CameraSettings settings) async {}

  @override
  Future<CameraSettings> settingsFor(String sourceId) async => CameraSettings.defaultValue();

  @override
  Future<CameraDeviceInfo> deviceInfo(String sourceId) async {
    return CameraDeviceInfo(
      sourceId: sourceId,
      resolutionWidth: 1920,
      resolutionHeight: 1080,
      fps: 30,
      orientation: 0,
      imageQuality: 90,
      firmwareVersion: 'native',
      supportsFlash: sourceId == 'phone_rear',
      supportsZoom: true,
      supportsFocus: true,
      isMirrored: sourceId == 'phone_front',
    );
  }
}
