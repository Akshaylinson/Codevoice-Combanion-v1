import 'package:equatable/equatable.dart';

import 'camera_models.dart';
import 'sync_models.dart';
import 'vision_models.dart';

class LocalAssetPaths extends Equatable {
  const LocalAssetPaths({
    required this.imagePath,
    required this.thumbnailPath,
  });

  final String imagePath;
  final String thumbnailPath;

  @override
  List<Object?> get props => <Object?>[imagePath, thumbnailPath];
}

class CaptureRecord extends Equatable {
  const CaptureRecord({
    required this.id,
    required this.cameraSource,
    required this.imagePath,
    required this.thumbnailPath,
    required this.capturedAt,
    required this.mimeType,
    required this.visionResult,
    required this.uploadStatus,
    required this.processingTimeMs,
    this.latitude,
    this.longitude,
    this.note,
    this.remoteDriveUrl,
    this.remoteSheetRowId,
    this.syncAttempts = 0,
    this.lastError,
  });

  final String id;
  final CameraSource cameraSource;
  final String imagePath;
  final String thumbnailPath;
  final DateTime capturedAt;
  final String mimeType;
  final VisionResult visionResult;
  final UploadStatus uploadStatus;
  final int processingTimeMs;
  final double? latitude;
  final double? longitude;
  final String? note;
  final String? remoteDriveUrl;
  final String? remoteSheetRowId;
  final int syncAttempts;
  final String? lastError;

  CaptureRecord copyWith({
    String? id,
    CameraSource? cameraSource,
    String? imagePath,
    String? thumbnailPath,
    DateTime? capturedAt,
    String? mimeType,
    VisionResult? visionResult,
    UploadStatus? uploadStatus,
    int? processingTimeMs,
    double? latitude,
    double? longitude,
    String? note,
    String? remoteDriveUrl,
    String? remoteSheetRowId,
    int? syncAttempts,
    String? lastError,
  }) {
    return CaptureRecord(
      id: id ?? this.id,
      cameraSource: cameraSource ?? this.cameraSource,
      imagePath: imagePath ?? this.imagePath,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      capturedAt: capturedAt ?? this.capturedAt,
      mimeType: mimeType ?? this.mimeType,
      visionResult: visionResult ?? this.visionResult,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      processingTimeMs: processingTimeMs ?? this.processingTimeMs,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      note: note ?? this.note,
      remoteDriveUrl: remoteDriveUrl ?? this.remoteDriveUrl,
      remoteSheetRowId: remoteSheetRowId ?? this.remoteSheetRowId,
      syncAttempts: syncAttempts ?? this.syncAttempts,
      lastError: lastError ?? this.lastError,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        cameraSource,
        imagePath,
        thumbnailPath,
        capturedAt,
        mimeType,
        visionResult,
        uploadStatus,
        processingTimeMs,
        latitude,
        longitude,
        note,
        remoteDriveUrl,
        remoteSheetRowId,
        syncAttempts,
        lastError,
      ];
}
