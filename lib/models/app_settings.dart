import 'package:equatable/equatable.dart';

import 'sync_models.dart';

enum AppThemeModeSetting { dark, light, system }

class AppSettings extends Equatable {
  const AppSettings({
    required this.themeMode,
    required this.demoMode,
    required this.appsScriptSettings,
    required this.defaultCameraSourceId,
    required this.autoSyncEnabled,
    required this.captureNoteTemplate,
  });

  factory AppSettings.defaults() {
    return AppSettings(
      themeMode: AppThemeModeSetting.dark,
      demoMode: true,
      appsScriptSettings: AppsScriptSettings.defaults(),
      defaultCameraSourceId: 'phone_rear',
      autoSyncEnabled: false,
      captureNoteTemplate: 'Captured from CodeVoice Vision',
    );
  }

  final AppThemeModeSetting themeMode;
  final bool demoMode;
  final AppsScriptSettings appsScriptSettings;
  final String defaultCameraSourceId;
  final bool autoSyncEnabled;
  final String captureNoteTemplate;

  AppSettings copyWith({
    AppThemeModeSetting? themeMode,
    bool? demoMode,
    AppsScriptSettings? appsScriptSettings,
    String? defaultCameraSourceId,
    bool? autoSyncEnabled,
    String? captureNoteTemplate,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      demoMode: demoMode ?? this.demoMode,
      appsScriptSettings: appsScriptSettings ?? this.appsScriptSettings,
      defaultCameraSourceId: defaultCameraSourceId ?? this.defaultCameraSourceId,
      autoSyncEnabled: autoSyncEnabled ?? this.autoSyncEnabled,
      captureNoteTemplate: captureNoteTemplate ?? this.captureNoteTemplate,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        themeMode,
        demoMode,
        appsScriptSettings,
        defaultCameraSourceId,
        autoSyncEnabled,
        captureNoteTemplate,
      ];
}
