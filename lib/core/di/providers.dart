import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../camera_manager/domain/camera_manager.dart';
import '../../database/app_database.dart';
import '../../gallery/data/capture_repository.dart';
import '../../models/capture_models.dart';
import '../../local_storage/data/local_storage_service.dart';
import '../../local_storage/data/capture_workflow_service.dart';
import '../../settings/data/settings_repository.dart';
import '../../sync/data/apps_script_client.dart';
import '../../sync/data/sync_manager.dart';
import '../../vision_engine/domain/vision_engine.dart';
import 'service_locator.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => getIt<AppDatabase>());
final localStorageServiceProvider = Provider<LocalStorageService>((ref) => getIt<LocalStorageService>());
final cameraManagerProvider = Provider<CameraManager>((ref) => getIt<CameraManager>());
final visionEngineProvider = Provider<VisionEngine>((ref) => getIt<VisionEngine>());
final appsScriptClientProvider = Provider<AppsScriptClient>((ref) => getIt<AppsScriptClient>());
final captureRepositoryProvider = Provider<CaptureRepository>((ref) => getIt<CaptureRepository>());
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) => getIt<SettingsRepository>());
final syncManagerProvider = Provider<SyncManager>((ref) => getIt<SyncManager>());
final captureWorkflowServiceProvider = Provider<CaptureWorkflowService>((ref) {
  return CaptureWorkflowService(
    cameraManager: ref.watch(cameraManagerProvider),
    visionEngine: ref.watch(visionEngineProvider),
    localStorageService: ref.watch(localStorageServiceProvider),
    captureRepository: ref.watch(captureRepositoryProvider),
    syncManager: ref.watch(syncManagerProvider),
    settingsRepository: ref.watch(settingsRepositoryProvider),
  );
});

final cameraSourcesProvider = FutureProvider((ref) async {
  final repository = ref.watch(captureRepositoryProvider);
  return repository.readCameraSources();
});

final captureRecordsProvider = FutureProvider((ref) async {
  final repository = ref.watch(captureRepositoryProvider);
  return repository.readCaptures();
});

final syncQueueProvider = FutureProvider((ref) async {
  final manager = ref.watch(syncManagerProvider);
  return manager.readQueue();
});

final appSettingsProvider = FutureProvider((ref) async {
  final repository = ref.watch(settingsRepositoryProvider);
  return repository.loadSettings();
});

final dashboardStatsProvider = FutureProvider((ref) async {
  final repository = ref.watch(captureRepositoryProvider);
  final syncManager = ref.watch(syncManagerProvider);
  final totalCaptures = await repository.countCaptures();
  final pendingUploads = await syncManager.pendingCount();
  final latest = await repository.readCaptures(limit: 1);
  return DashboardStats(
    totalCaptures: totalCaptures,
    pendingUploads: pendingUploads,
    lastCapture: latest.isEmpty ? null : latest.first,
  );
});

class DashboardStats {
  const DashboardStats({
    required this.totalCaptures,
    required this.pendingUploads,
    required this.lastCapture,
  });

  final int totalCaptures;
  final int pendingUploads;
  final CaptureRecord? lastCapture;
}
