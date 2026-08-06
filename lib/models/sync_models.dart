import 'package:equatable/equatable.dart';

enum UploadStatus { pending, queued, uploading, uploaded, failed, skipped }

enum SyncJobStatus { queued, running, completed, failed }

class AppsScriptSettings extends Equatable {
  const AppsScriptSettings({
    required this.endpointUrl,
  });

  factory AppsScriptSettings.defaults() {
    return const AppsScriptSettings(endpointUrl: '');
  }

  final String endpointUrl;

  AppsScriptSettings copyWith({String? endpointUrl}) {
    return AppsScriptSettings(endpointUrl: endpointUrl ?? this.endpointUrl);
  }

  @override
  List<Object?> get props => <Object?>[endpointUrl];
}

class SyncJob extends Equatable {
  const SyncJob({
    required this.id,
    required this.captureId,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.nextRetryAt,
    this.attempts = 0,
    this.lastError,
    this.remoteDriveUrl,
    this.remoteSheetRowId,
  });

  final String id;
  final String captureId;
  final SyncJobStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? nextRetryAt;
  final int attempts;
  final String? lastError;
  final String? remoteDriveUrl;
  final String? remoteSheetRowId;

  SyncJob copyWith({
    String? id,
    String? captureId,
    SyncJobStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? nextRetryAt,
    int? attempts,
    String? lastError,
    String? remoteDriveUrl,
    String? remoteSheetRowId,
  }) {
    return SyncJob(
      id: id ?? this.id,
      captureId: captureId ?? this.captureId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      nextRetryAt: nextRetryAt ?? this.nextRetryAt,
      attempts: attempts ?? this.attempts,
      lastError: lastError ?? this.lastError,
      remoteDriveUrl: remoteDriveUrl ?? this.remoteDriveUrl,
      remoteSheetRowId: remoteSheetRowId ?? this.remoteSheetRowId,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        captureId,
        status,
        createdAt,
        updatedAt,
        nextRetryAt,
        attempts,
        lastError,
        remoteDriveUrl,
        remoteSheetRowId,
      ];
}

