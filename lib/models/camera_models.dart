import 'package:equatable/equatable.dart';

enum CameraSourceType { phoneRear, phoneFront, esp32, usb, ip, smartGlass, wearable, unknown }

class CameraSource extends Equatable {
  const CameraSource({
    required this.id,
    required this.label,
    required this.type,
    required this.isAvailable,
    this.manufacturer,
    this.model,
    this.connectionHint,
    this.lastSeenAt,
  });

  final String id;
  final String label;
  final CameraSourceType type;
  final bool isAvailable;
  final String? manufacturer;
  final String? model;
  final String? connectionHint;
  final DateTime? lastSeenAt;

  CameraSource copyWith({
    String? id,
    String? label,
    CameraSourceType? type,
    bool? isAvailable,
    String? manufacturer,
    String? model,
    String? connectionHint,
    DateTime? lastSeenAt,
  }) {
    return CameraSource(
      id: id ?? this.id,
      label: label ?? this.label,
      type: type ?? this.type,
      isAvailable: isAvailable ?? this.isAvailable,
      manufacturer: manufacturer ?? this.manufacturer,
      model: model ?? this.model,
      connectionHint: connectionHint ?? this.connectionHint,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'label': label,
        'type': type.name,
        'isAvailable': isAvailable,
        'manufacturer': manufacturer,
        'model': model,
        'connectionHint': connectionHint,
        'lastSeenAt': lastSeenAt?.toIso8601String(),
      };

  factory CameraSource.fromMap(Map<String, dynamic> map) {
    return CameraSource(
      id: map['id'] as String,
      label: map['label'] as String,
      type: CameraSourceType.values.firstWhere(
        (value) => value.name == map['type'],
        orElse: () => CameraSourceType.unknown,
      ),
      isAvailable: map['isAvailable'] as bool? ?? true,
      manufacturer: map['manufacturer'] as String?,
      model: map['model'] as String?,
      connectionHint: map['connectionHint'] as String?,
      lastSeenAt: map['lastSeenAt'] == null ? null : DateTime.tryParse(map['lastSeenAt'] as String),
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        label,
        type,
        isAvailable,
        manufacturer,
        model,
        connectionHint,
        lastSeenAt,
      ];
}

class CameraDeviceInfo extends Equatable {
  const CameraDeviceInfo({
    required this.sourceId,
    required this.resolutionWidth,
    required this.resolutionHeight,
    required this.fps,
    required this.orientation,
    required this.imageQuality,
    this.firmwareVersion,
    this.supportsFlash = false,
    this.supportsZoom = false,
    this.supportsFocus = false,
    this.isMirrored = false,
  });

  final String sourceId;
  final int resolutionWidth;
  final int resolutionHeight;
  final int fps;
  final int orientation;
  final int imageQuality;
  final String? firmwareVersion;
  final bool supportsFlash;
  final bool supportsZoom;
  final bool supportsFocus;
  final bool isMirrored;

  @override
  List<Object?> get props => <Object?>[
        sourceId,
        resolutionWidth,
        resolutionHeight,
        fps,
        orientation,
        imageQuality,
        firmwareVersion,
        supportsFlash,
        supportsZoom,
        supportsFocus,
        isMirrored,
      ];
}

class CameraSettings extends Equatable {
  const CameraSettings({
    required this.resolutionWidth,
    required this.resolutionHeight,
    required this.fps,
    required this.orientation,
    required this.imageQuality,
    required this.flashEnabled,
    required this.zoom,
    required this.focusMode,
    required this.mirror,
    required this.rotationDegrees,
  });

  factory CameraSettings.defaultValue() {
    return const CameraSettings(
      resolutionWidth: 1920,
      resolutionHeight: 1080,
      fps: 30,
      orientation: 0,
      imageQuality: 92,
      flashEnabled: false,
      zoom: 1.0,
      focusMode: 'auto',
      mirror: false,
      rotationDegrees: 0,
    );
  }

  final int resolutionWidth;
  final int resolutionHeight;
  final int fps;
  final int orientation;
  final int imageQuality;
  final bool flashEnabled;
  final double zoom;
  final String focusMode;
  final bool mirror;
  final int rotationDegrees;

  CameraSettings copyWith({
    int? resolutionWidth,
    int? resolutionHeight,
    int? fps,
    int? orientation,
    int? imageQuality,
    bool? flashEnabled,
    double? zoom,
    String? focusMode,
    bool? mirror,
    int? rotationDegrees,
  }) {
    return CameraSettings(
      resolutionWidth: resolutionWidth ?? this.resolutionWidth,
      resolutionHeight: resolutionHeight ?? this.resolutionHeight,
      fps: fps ?? this.fps,
      orientation: orientation ?? this.orientation,
      imageQuality: imageQuality ?? this.imageQuality,
      flashEnabled: flashEnabled ?? this.flashEnabled,
      zoom: zoom ?? this.zoom,
      focusMode: focusMode ?? this.focusMode,
      mirror: mirror ?? this.mirror,
      rotationDegrees: rotationDegrees ?? this.rotationDegrees,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        resolutionWidth,
        resolutionHeight,
        fps,
        orientation,
        imageQuality,
        flashEnabled,
        zoom,
        focusMode,
        mirror,
        rotationDegrees,
      ];
}
