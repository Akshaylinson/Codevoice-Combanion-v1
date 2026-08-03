import '../../core/config/app_constants.dart';
import '../../database/app_database.dart';
import '../../database/database_repository.dart';
import '../../models/app_settings.dart';
import '../../models/sync_models.dart';

class SettingsRepository {
  SettingsRepository({required this.database}) : _repository = DatabaseRepository(database: database);

  final AppDatabase database;
  final DatabaseRepository _repository;

  Future<void> seedDefaults() async {
    final existing = await _repository.getAllSettings();
    if (existing.isNotEmpty) {
      return;
    }
    final settings = AppSettings.defaults();
    await saveSettings(settings);
  }

  Future<AppSettings> loadSettings() async {
    final values = await _repository.getAllSettings();
    if (values.isEmpty) {
      return AppSettings.defaults();
    }
    return AppSettings(
      themeMode: AppThemeModeSetting.values.firstWhere(
        (mode) => mode.name == values[AppConstants.defaultThemeKey],
        orElse: () => AppThemeModeSetting.dark,
      ),
      demoMode: values[AppConstants.defaultDemoModeKey] != 'false',
      appsScriptSettings: AppsScriptSettings(
        endpointUrl: values[AppConstants.defaultSyncEndpointKey] ?? '',
        demoMode: values['settings.sync.demoMode'] != 'false',
      ),
      defaultCameraSourceId: values['settings.defaultCameraSourceId'] ?? 'phone_rear',
      autoSyncEnabled: values['settings.autoSyncEnabled'] == 'true',
      captureNoteTemplate: values['settings.captureNoteTemplate'] ?? 'Captured from CodeVoice Vision',
    );
  }

  Future<void> saveSettings(AppSettings settings) async {
    await _repository.setSetting(AppConstants.defaultThemeKey, settings.themeMode.name);
    await _repository.setSetting(AppConstants.defaultDemoModeKey, settings.demoMode.toString());
    await _repository.setSetting(AppConstants.defaultSyncEndpointKey, settings.appsScriptSettings.endpointUrl);
    await _repository.setSetting('settings.sync.demoMode', settings.appsScriptSettings.demoMode.toString());
    await _repository.setSetting('settings.defaultCameraSourceId', settings.defaultCameraSourceId);
    await _repository.setSetting('settings.autoSyncEnabled', settings.autoSyncEnabled.toString());
    await _repository.setSetting('settings.captureNoteTemplate', settings.captureNoteTemplate);
  }

  Future<void> updateSetting(String key, String value) => _repository.setSetting(key, value);

  Future<String?> getSetting(String key) => _repository.getSetting(key);
}
