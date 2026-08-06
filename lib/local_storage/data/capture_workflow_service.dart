import 'package:uuid/uuid.dart';

import '../../camera_manager/domain/camera_manager.dart';
import '../../gallery/data/capture_repository.dart';
import '../../models/capture_models.dart';
import '../../models/sync_models.dart';
import '../../settings/data/settings_repository.dart';
import '../../sync/data/sync_manager.dart';
import '../../vision_engine/domain/vision_engine.dart';
import 'local_storage_service.dart';

class CaptureWorkflowService {
  CaptureWorkflowService({
    required this.cameraManager,
    required this.visionEngine,
    required this.localStorageService,
    required this.captureRepository,
    required this.syncManager,
    required this.settingsRepository,
  });

  final CameraManager cameraManager;
  final VisionEngine visionEngine;
  final LocalStorageService localStorageService;
  final CaptureRepository captureRepository;
  final SyncManager syncManager;
  final SettingsRepository settingsRepository;
  final Uuid _uuid = const Uuid();

  Future<CaptureRecord> captureAndStore(String cameraSourceId) async {
    final settings = await settingsRepository.loadSettings();
    final capture = await cameraManager.capture(cameraSourceId);
    final imageId = _uuid.v4();
    final thumbnailBytes = await localStorageService.buildThumbnail(
      imageBytes: capture.imageBytes,
      width: 320,
      height: 180,
    );
    final assetPaths = await localStorageService.saveCaptureBytes(
      captureId: imageId,
      imageBytes: capture.imageBytes,
      thumbnailBytes: thumbnailBytes,
    );
    final visionResult = await visionEngine.process(
      imageId: imageId,
      source: capture.source,
      imagePath: assetPaths.imagePath,
      imageBytes: capture.imageBytes,
      capturedAt: capture.capturedAt,
    );
    final record = CaptureRecord(
      id: imageId,
      cameraSource: capture.source,
      imagePath: assetPaths.imagePath,
      thumbnailPath: assetPaths.thumbnailPath,
      capturedAt: capture.capturedAt,
      mimeType: 'image/jpeg',
      visionResult: visionResult,
      uploadStatus: UploadStatus.queued,
      processingTimeMs: visionResult.processingTimeMs,
      note: settings.captureNoteTemplate.trim().isEmpty ? null : settings.captureNoteTemplate.trim(),
    );
    await captureRepository.saveCapture(record);
    if (settings.autoSyncEnabled) {
      await syncManager.syncCapture(record);
    } else {
      await syncManager.enqueueCapture(record);
    }
    return record;
  }
}

