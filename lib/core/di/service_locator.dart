import 'package:get_it/get_it.dart';

import '../../camera_manager/data/virtual_camera_manager.dart';
import '../../camera_manager/domain/camera_manager.dart';
import '../../database/app_database.dart';
import '../../gallery/data/capture_repository.dart';
import '../../local_storage/data/local_storage_service.dart';
import '../../settings/data/settings_repository.dart';
import '../../sync/data/apps_script_client.dart';
import '../../sync/data/sync_manager.dart';
import '../../vision_engine/data/mock_vision_engine.dart';
import '../../vision_engine/domain/vision_engine.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  if (getIt.isRegistered<AppDatabase>()) {
    return;
  }

  final database = AppDatabase();
  final localStorage = LocalStorageService(database: database);
  final cameraManager = VirtualCameraManager();
  final visionEngine = MockVisionEngine();
  final appsScriptClient = AppsScriptClient();
  final captureRepository = CaptureRepository(database: database);
  final settingsRepository = SettingsRepository(database: database);
  final syncManager = SyncManager(
    database: database,
    captureRepository: captureRepository,
    appsScriptClient: appsScriptClient,
    settingsRepository: settingsRepository,
  );

  getIt.registerSingleton<AppDatabase>(database);
  getIt.registerSingleton<LocalStorageService>(localStorage);
  getIt.registerSingleton<CameraManager>(cameraManager);
  getIt.registerSingleton<VisionEngine>(visionEngine);
  getIt.registerSingleton<AppsScriptClient>(appsScriptClient);
  getIt.registerSingleton<CaptureRepository>(captureRepository);
  getIt.registerSingleton<SettingsRepository>(settingsRepository);
  getIt.registerSingleton<SyncManager>(syncManager);

  await localStorage.initialize();
  await captureRepository.seedDefaultCameraSources();
  await settingsRepository.seedDefaults();
  await syncManager.seedDemoQueueIfNeeded();
}
