import 'dart:math';

import 'package:image/image.dart' as image_lib;

import '../../models/camera_models.dart';
import '../domain/camera_manager.dart';

class VirtualCameraManager implements CameraManager {
  VirtualCameraManager();

  final Map<String, CameraSettings> _settings = <String, CameraSettings>{};
  final Set<String> _connected = <String>{};

  @override
  Future<List<CameraSource>> discoverSources() async {
    return <CameraSource>[
      const CameraSource(
        id: 'phone_rear',
        label: 'Phone Rear Camera',
        type: CameraSourceType.phoneRear,
        isAvailable: true,
        manufacturer: 'Android',
        model: 'Rear Sensor',
        connectionHint: 'Native device camera',
      ),
      const CameraSource(
        id: 'phone_front',
        label: 'Phone Front Camera',
        type: CameraSourceType.phoneFront,
        isAvailable: true,
        manufacturer: 'Android',
        model: 'Front Sensor',
        connectionHint: 'Native device camera',
      ),
      const CameraSource(
        id: 'esp32_camera',
        label: 'ESP32 Camera',
        type: CameraSourceType.esp32,
        isAvailable: true,
        manufacturer: 'ESP32',
        model: 'AI Thinker',
        connectionHint: 'Wi-Fi stream adapter',
      ),
      const CameraSource(
        id: 'usb_camera',
        label: 'USB Camera',
        type: CameraSourceType.usb,
        isAvailable: true,
        manufacturer: 'USB UVC',
        model: 'External camera',
        connectionHint: 'USB host adapter',
      ),
    ];
  }

  @override
  Future<void> connect(String sourceId) async {
    _connected.add(sourceId);
    _settings[sourceId] = _settings[sourceId] ?? CameraSettings.defaultValue();
  }

  @override
  Future<void> disconnect(String sourceId) async {
    _connected.remove(sourceId);
  }

  @override
  Future<void> startPreview(String sourceId) async {
    await connect(sourceId);
  }

  @override
  Future<void> stopPreview(String sourceId) async {}

  @override
  Future<void> updateSettings(String sourceId, CameraSettings settings) async {
    _settings[sourceId] = settings;
  }

  @override
  Future<CameraSettings> settingsFor(String sourceId) async {
    return _settings[sourceId] ?? CameraSettings.defaultValue();
  }

  @override
  Future<CameraDeviceInfo> deviceInfo(String sourceId) async {
    final settings = await settingsFor(sourceId);
    return CameraDeviceInfo(
      sourceId: sourceId,
      resolutionWidth: settings.resolutionWidth,
      resolutionHeight: settings.resolutionHeight,
      fps: settings.fps,
      orientation: settings.orientation,
      imageQuality: settings.imageQuality,
      firmwareVersion: 'virtual-1.0',
      supportsFlash: sourceId == 'phone_rear',
      supportsZoom: true,
      supportsFocus: true,
      isMirrored: sourceId == 'phone_front',
    );
  }

  @override
  Future<CameraCapture> capture(String sourceId) async {
    final source = (await discoverSources()).firstWhere(
      (item) => item.id == sourceId,
      orElse: () => const CameraSource(
        id: 'unknown',
        label: 'Unknown Camera',
        type: CameraSourceType.unknown,
        isAvailable: false,
      ),
    );
    final settings = await settingsFor(sourceId);
    final cameraDeviceInfo = await deviceInfo(sourceId);
    final bytes = _generateCaptureBytes(source, settings, highResolution: true);
    final previewBytes = _generateCaptureBytes(source, settings, highResolution: false);
    return CameraCapture(
      source: source,
      imageBytes: bytes,
      previewBytes: previewBytes,
      capturedAt: DateTime.now(),
      deviceInfo: cameraDeviceInfo,
      settings: settings,
    );
  }

  List<int> _generateCaptureBytes(
    CameraSource source,
    CameraSettings settings, {
    required bool highResolution,
  }) {
    final width = highResolution ? settings.resolutionWidth : 640;
    final height = highResolution ? settings.resolutionHeight : 360;
    final image = image_lib.Image(width: width, height: height, numChannels: 3);
    final rng = Random(source.id.hashCode ^ width ^ height);

    for (var y = 0; y < height; y++) {
      final progress = y / max(1, height - 1);
      for (var x = 0; x < width; x++) {
        final horizontal = x / max(1, width - 1);
        final baseRed = (30 + 60 * horizontal + 30 * progress).round();
        final baseGreen = (40 + 120 * progress).round();
        final baseBlue = (50 + 80 * (1 - horizontal)).round();
        final jitter = rng.nextInt(8);
        image.setPixelRgb(
          x,
          y,
          (baseRed + jitter).clamp(0, 255),
          (baseGreen + jitter).clamp(0, 255),
          (baseBlue + jitter).clamp(0, 255),
        );
      }
    }

    final barColor = switch (source.type) {
      CameraSourceType.phoneRear => const <int>[123, 224, 177],
      CameraSourceType.phoneFront => const <int>[255, 200, 87],
      CameraSourceType.esp32 => const <int>[114, 137, 255],
      CameraSourceType.usb => const <int>[255, 132, 102],
      _ => const <int>[255, 255, 255],
    };

    final barHeight = (height * 0.14).round();
    for (var y = 0; y < barHeight; y++) {
      for (var x = 0; x < width; x++) {
        image.setPixelRgb(x, y, barColor[0], barColor[1], barColor[2]);
      }
    }

    final pad = (width * 0.08).round();
    final innerHeight = (height * 0.42).round();
    for (var y = barHeight + 24; y < barHeight + 24 + innerHeight && y < height; y++) {
      for (var x = pad; x < width - pad; x++) {
        if (x == pad || x == width - pad - 1 || y == barHeight + 24 || y == barHeight + 24 + innerHeight - 1) {
          image.setPixelRgb(x, y, 255, 255, 255);
        }
      }
    }

    final encoded = image_lib.encodeJpg(image, quality: settings.imageQuality);
    return encoded;
  }
}

