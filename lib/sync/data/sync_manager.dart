import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../database/app_database.dart';
import '../../database/database_repository.dart';
import '../../gallery/data/capture_repository.dart';
import '../../models/capture_models.dart';
import '../../models/sync_models.dart';
import '../../settings/data/settings_repository.dart';
import 'apps_script_client.dart';

class SyncManager {
  SyncManager({
    required this.database,
    required this.captureRepository,
    required this.appsScriptClient,
    required this.settingsRepository,
  }) : _databaseRepository = DatabaseRepository(database: database);

  final AppDatabase database;
  final CaptureRepository captureRepository;
  final AppsScriptClient appsScriptClient;
  final SettingsRepository settingsRepository;
  final DatabaseRepository _databaseRepository;
  final Uuid _uuid = const Uuid();

  Future<void> seedDemoQueueIfNeeded() async {
    final existing = await readQueue();
    if (existing.isNotEmpty) {
      return;
    }
    final latestCapture = await captureRepository.readLatestCapture();
    if (latestCapture != null) {
      await enqueueCapture(latestCapture);
    }
  }

  Future<void> enqueueCapture(CaptureRecord capture) async {
    final job = SyncJob(
      id: _uuid.v4(),
      captureId: capture.id,
      status: SyncJobStatus.queued,
      createdAt: DateTime.now(),
      attempts: capture.syncAttempts,
      remoteDriveUrl: capture.remoteDriveUrl,
      remoteSheetRowId: capture.remoteSheetRowId,
    );
    await database.into(database.syncQueueEntries).insertOnConflictUpdate(
          SyncQueueEntriesCompanion.insert(
            id: job.id,
            captureId: job.captureId,
            status: job.status,
            attempts: Value<int>(job.attempts),
            lastError: Value<String?>(job.lastError),
            remoteDriveUrl: Value<String?>(job.remoteDriveUrl),
            remoteSheetRowId: Value<String?>(job.remoteSheetRowId),
            createdAt: job.createdAt.millisecondsSinceEpoch,
            updatedAt: job.createdAt.millisecondsSinceEpoch,
          ),
        );
  }

  Future<List<SyncJob>> readQueue() {
    return database.select(database.syncQueueEntries).get().then((rows) {
      rows.sort((a, b) => b.createdAt.compareTo(a.createdAt));
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

  Future<int> pendingCount() async {
    final jobs = await readQueue();
    return jobs.where((job) => job.status == SyncJobStatus.queued || job.status == SyncJobStatus.failed).length;
  }

  Future<SyncResponse> syncCapture(CaptureRecord capture) async {
    final settings = await settingsRepository.loadSettings();
    final response = await appsScriptClient.uploadCapture(
      payload: AppsScriptUploadPayload(
        endpointUrl: settings.appsScriptSettings.endpointUrl,
        capture: capture,
      ),
    );
    await captureRepository.updateCaptureSyncStatus(
      captureId: capture.id,
      status: response.success ? UploadStatus.uploaded : UploadStatus.failed,
      remoteDriveUrl: response.driveUrl,
      remoteSheetRowId: response.sheetRowId,
      lastError: response.success ? null : response.message,
      syncAttempts: capture.syncAttempts + 1,
    );
    return response;
  }

  Future<void> syncPending() async {
    final jobs = await readQueue();
    for (final job in jobs.where((job) => job.status == SyncJobStatus.queued || job.status == SyncJobStatus.failed)) {
      final capture = await captureRepository.readCaptureById(job.captureId);
      if (capture == null) {
        continue;
      }
      await _databaseRepository.updateSyncQueueStatus(
        jobId: job.id,
        status: SyncJobStatus.running,
        attempts: job.attempts + 1,
      );
      final response = await syncCapture(capture.copyWith(uploadStatus: UploadStatus.uploading));
      await _databaseRepository.updateSyncQueueStatus(
        jobId: job.id,
        status: response.success ? SyncJobStatus.completed : SyncJobStatus.failed,
        attempts: job.attempts + 1,
        lastError: response.success ? null : response.message,
        remoteDriveUrl: response.driveUrl,
        remoteSheetRowId: response.sheetRowId,
      );
    }
  }
}
