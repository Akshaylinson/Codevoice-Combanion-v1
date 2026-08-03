import 'dart:convert';

import 'package:drift/drift.dart';

import '../models/camera_models.dart';
import '../models/capture_models.dart';
import '../models/sync_models.dart';
import '../models/vision_models.dart';
import 'app_database.dart';

class DatabaseRepository {
  DatabaseRepository({required this.database});

  final AppDatabase database;

  Future<void> insertCameraSources(List<CameraSource> sources) async {
    await database.batch((batch) {
      batch.insertAllOnConflictUpdate(
        database.cameraSourceEntries,
        sources
            .map(
              (source) => CameraSourceEntriesCompanion.insert(
                id: source.id,
                label: source.label,
                type: source.type,
                isAvailable: Value<bool>(source.isAvailable),
                manufacturer: Value<String?>(source.manufacturer),
                model: Value<String?>(source.model),
                connectionHint: Value<String?>(source.connectionHint),
                createdAt: DateTime.now().millisecondsSinceEpoch,
                lastSeenAt: Value<int?>(source.lastSeenAt?.millisecondsSinceEpoch),
              ),
            )
            .toList(),
      );
    });
  }

  Future<List<CameraSource>> readCameraSources() async {
    final rows = await database.select(database.cameraSourceEntries).get();
    return rows
        .map(
          (row) => CameraSource(
            id: row.id,
            label: row.label,
            type: row.type,
            isAvailable: row.isAvailable,
            manufacturer: row.manufacturer,
            model: row.model,
            connectionHint: row.connectionHint,
            lastSeenAt: row.lastSeenAt == null ? null : DateTime.fromMillisecondsSinceEpoch(row.lastSeenAt!),
          ),
        )
        .toList();
  }

  Future<void> upsertCapture(CaptureRecord record) async {
    await database.into(database.captureEntries).insertOnConflictUpdate(
          CaptureEntriesCompanion.insert(
            id: record.id,
            cameraSourceId: record.cameraSource.id,
            imagePath: record.imagePath,
            thumbnailPath: record.thumbnailPath,
            mimeType: Value<String>(record.mimeType),
            capturedAt: record.capturedAt.millisecondsSinceEpoch,
            latitude: Value<double?>(record.latitude),
            longitude: Value<double?>(record.longitude),
            note: Value<String?>(record.note),
            processingTimeMs: record.processingTimeMs,
            confidence: record.visionResult.confidence,
            faceCount: record.visionResult.faceCount,
            detectedObjectsJson: jsonEncode(
              record.visionResult.objects.map((object) => object.toMap()).toList(),
            ),
            ocrText: record.visionResult.ocrText,
            qrText: record.visionResult.qrText,
            uploadStatus: record.uploadStatus,
            visionJson: jsonEncode(record.visionResult.toMap()),
            remoteDriveUrl: Value<String?>(record.remoteDriveUrl),
            remoteSheetRowId: Value<String?>(record.remoteSheetRowId),
            syncAttempts: Value<int>(record.syncAttempts),
            lastError: Value<String?>(record.lastError),
            createdAt: record.capturedAt.millisecondsSinceEpoch,
            updatedAt: DateTime.now().millisecondsSinceEpoch,
          ),
        );
  }

  Future<List<CaptureRecord>> readCaptures({int limit = 100}) async {
    final rows = await database.select(database.captureEntries).get();
    final sources = await readCameraSources();
    final sourceLookup = <String, CameraSource>{
      for (final source in sources) source.id: source,
    };
    rows.sort((a, b) => b.capturedAt.compareTo(a.capturedAt));
    return rows.take(limit).map((row) => _toCaptureRecord(row, sourceLookup[row.cameraSourceId])).toList();
  }

  Stream<List<CaptureRecord>> watchCaptures({int limit = 100}) {
    return database.select(database.captureEntries).watch().asyncMap((rows) async {
      final sources = await readCameraSources();
      final sourceLookup = <String, CameraSource>{
        for (final source in sources) source.id: source,
      };
      rows.sort((a, b) => b.capturedAt.compareTo(a.capturedAt));
      return rows.take(limit).map((row) => _toCaptureRecord(row, sourceLookup[row.cameraSourceId])).toList();
    });
  }

  Future<void> enqueueSync(SyncJob job) async {
    await database.into(database.syncQueueEntries).insertOnConflictUpdate(
          SyncQueueEntriesCompanion.insert(
            id: job.id,
            captureId: job.captureId,
            status: job.status,
            attempts: Value<int>(job.attempts),
            lastError: Value<String?>(job.lastError),
            remoteDriveUrl: Value<String?>(job.remoteDriveUrl),
            remoteSheetRowId: Value<String?>(job.remoteSheetRowId),
            nextRetryAt: Value<int?>(job.nextRetryAt?.millisecondsSinceEpoch),
            createdAt: job.createdAt.millisecondsSinceEpoch,
            updatedAt: (job.updatedAt ?? DateTime.now()).millisecondsSinceEpoch,
          ),
        );
  }

  Future<List<SyncJob>> readSyncQueue() async {
    final rows = await database.select(database.syncQueueEntries).get();
    return rows
        .map(
          (row) => SyncJob(
            id: row.id,
            captureId: row.captureId,
            status: row.status,
            createdAt: DateTime.fromMillisecondsSinceEpoch(row.createdAt),
            updatedAt: DateTime.fromMillisecondsSinceEpoch(row.updatedAt),
            nextRetryAt: row.nextRetryAt == null ? null : DateTime.fromMillisecondsSinceEpoch(row.nextRetryAt!),
            attempts: row.attempts,
            lastError: row.lastError,
            remoteDriveUrl: row.remoteDriveUrl,
            remoteSheetRowId: row.remoteSheetRowId,
          ),
        )
        .toList();
  }

  Stream<List<SyncJob>> watchSyncQueue() {
    return database.select(database.syncQueueEntries).watch().asyncMap((rows) async {
      return rows
          .map(
            (row) => SyncJob(
              id: row.id,
              captureId: row.captureId,
              status: row.status,
              createdAt: DateTime.fromMillisecondsSinceEpoch(row.createdAt),
              updatedAt: DateTime.fromMillisecondsSinceEpoch(row.updatedAt),
              nextRetryAt: row.nextRetryAt == null ? null : DateTime.fromMillisecondsSinceEpoch(row.nextRetryAt!),
              attempts: row.attempts,
              lastError: row.lastError,
              remoteDriveUrl: row.remoteDriveUrl,
              remoteSheetRowId: row.remoteSheetRowId,
            ),
          )
          .toList();
    });
  }

  Future<int> countCaptures() async {
    return (await database.select(database.captureEntries).get()).length;
  }

  Future<int> countPendingSyncJobs() async {
    final rows = await database.select(database.syncQueueEntries).get();
    return rows.where((row) => row.status == SyncJobStatus.queued || row.status == SyncJobStatus.failed).length;
  }

  Future<void> updateCaptureSyncStatus({
    required String captureId,
    required UploadStatus status,
    String? remoteDriveUrl,
    String? remoteSheetRowId,
    String? lastError,
    int? syncAttempts,
  }) async {
    final companion = CaptureEntriesCompanion(
      uploadStatus: Value<UploadStatus>(status),
      remoteDriveUrl: Value<String?>(remoteDriveUrl),
      remoteSheetRowId: Value<String?>(remoteSheetRowId),
      lastError: Value<String?>(lastError),
      syncAttempts: syncAttempts == null ? const Value.absent() : Value<int>(syncAttempts),
      updatedAt: Value<int>(DateTime.now().millisecondsSinceEpoch),
    );
    await (database.update(database.captureEntries)..where((tbl) => tbl.id.equals(captureId))).write(companion);
  }

  Future<void> updateSyncQueueStatus({
    required String jobId,
    required SyncJobStatus status,
    int? attempts,
    String? lastError,
    String? remoteDriveUrl,
    String? remoteSheetRowId,
  }) async {
    final companion = SyncQueueEntriesCompanion(
      status: Value<SyncJobStatus>(status),
      attempts: attempts == null ? const Value.absent() : Value<int>(attempts),
      lastError: Value<String?>(lastError),
      remoteDriveUrl: Value<String?>(remoteDriveUrl),
      remoteSheetRowId: Value<String?>(remoteSheetRowId),
      updatedAt: Value<int>(DateTime.now().millisecondsSinceEpoch),
    );
    await (database.update(database.syncQueueEntries)..where((tbl) => tbl.id.equals(jobId))).write(companion);
  }

  Future<void> setSetting(String key, String value) async {
    await database.into(database.settingEntries).insertOnConflictUpdate(
          SettingEntriesCompanion.insert(
            key: key,
            value: value,
            updatedAt: DateTime.now().millisecondsSinceEpoch,
          ),
        );
  }

  Future<String?> getSetting(String key) async {
    final row = await (database.select(database.settingEntries)..where((tbl) => tbl.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  Future<Map<String, String>> getAllSettings() async {
    final rows = await database.select(database.settingEntries).get();
    return <String, String>{
      for (final row in rows) row.key: row.value,
    };
  }

  CaptureRecord _toCaptureRecord(CaptureEntry row, CameraSource? source) {
    final visionMap = jsonDecode(row.visionJson) as Map<String, dynamic>;
    return CaptureRecord(
      id: row.id,
      cameraSource: source ??
          CameraSource(
            id: row.cameraSourceId,
            label: row.cameraSourceId,
            type: CameraSourceType.unknown,
            isAvailable: true,
          ),
      imagePath: row.imagePath,
      thumbnailPath: row.thumbnailPath,
      capturedAt: DateTime.fromMillisecondsSinceEpoch(row.capturedAt),
      mimeType: row.mimeType,
      visionResult: VisionResult.fromMap(visionMap),
      uploadStatus: row.uploadStatus,
      processingTimeMs: row.processingTimeMs,
      latitude: row.latitude,
      longitude: row.longitude,
      note: row.note,
      remoteDriveUrl: row.remoteDriveUrl,
      remoteSheetRowId: row.remoteSheetRowId,
      syncAttempts: row.syncAttempts,
      lastError: row.lastError,
    );
  }
}
