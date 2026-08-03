import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';
import '../../models/app_settings.dart';
import '../../shared/widgets/section_card.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/status_badge.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _endpointController = TextEditingController();
  final _noteTemplateController = TextEditingController();
  bool? _demoMode;
  bool? _autoSync;
  AppThemeModeSetting? _themeMode;
  String? _defaultCameraSourceId;

  @override
  void dispose() {
    _endpointController.dispose();
    _noteTemplateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(appSettingsProvider);
    final cameraSourcesAsync = ref.watch(cameraSourcesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: settingsAsync.when(
        data: (settings) {
          _endpointController.text = _endpointController.text.isEmpty ? settings.appsScriptSettings.endpointUrl : _endpointController.text;
          _noteTemplateController.text =
              _noteTemplateController.text.isEmpty ? settings.captureNoteTemplate : _noteTemplateController.text;
          _demoMode ??= settings.demoMode;
          _autoSync ??= settings.autoSyncEnabled;
          _themeMode ??= settings.themeMode;
          _defaultCameraSourceId ??= settings.defaultCameraSourceId;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(
                      title: 'App Configuration',
                      subtitle: 'Store everything locally first, keep sync optional, and preserve future extensibility.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(title: 'Sync', subtitle: 'Google Apps Script stays isolated behind this configuration.'),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _endpointController,
                      decoration: const InputDecoration(labelText: 'Apps Script Endpoint URL'),
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: _demoMode ?? false,
                      onChanged: (value) => setState(() => _demoMode = value),
                      title: const Text('Demo Mode'),
                      subtitle: const Text('Return local mock sync responses without making network calls.'),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: _autoSync ?? false,
                      onChanged: (value) => setState(() => _autoSync = value),
                      title: const Text('Auto Sync'),
                      subtitle: const Text('Queue captures for sync automatically.'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(title: 'Appearance', subtitle: 'Theme is kept simple and ready for future expansion.'),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<AppThemeModeSetting>(
                      value: _themeMode,
                      items: AppThemeModeSetting.values
                          .map(
                            (mode) => DropdownMenuItem(
                              value: mode,
                              child: Text(mode.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() => _themeMode = value),
                      decoration: const InputDecoration(labelText: 'Theme mode'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _noteTemplateController,
                      decoration: const InputDecoration(labelText: 'Capture note template'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              cameraSourcesAsync.when(
                data: (sources) => SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeader(title: 'Default Camera', subtitle: 'Choose which source should be selected first.'),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _defaultCameraSourceId,
                        items: sources
                            .map(
                              (source) => DropdownMenuItem(
                                value: source.id,
                                child: Text(source.label),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => setState(() => _defaultCameraSourceId = value),
                        decoration: const InputDecoration(labelText: 'Default source'),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        children: [
                          StatusBadge(label: settings.appsScriptSettings.demoMode ? 'Demo Sync On' : 'Real Sync'),
                          StatusBadge(label: settings.demoMode ? 'Demo App On' : 'Demo App Off'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final updated = settings.copyWith(
                            themeMode: _themeMode,
                            demoMode: _demoMode,
                            appsScriptSettings: settings.appsScriptSettings.copyWith(
                              endpointUrl: _endpointController.text.trim(),
                              demoMode: _demoMode ?? false,
                            ),
                            defaultCameraSourceId: _defaultCameraSourceId,
                            autoSyncEnabled: _autoSync,
                            captureNoteTemplate: _noteTemplateController.text.trim(),
                          );
                          await ref.read(settingsRepositoryProvider).saveSettings(updated);
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Settings saved')),
                          );
                          ref.invalidate(appSettingsProvider);
                        },
                        icon: const Icon(Icons.save_rounded),
                        label: const Text('Save Settings'),
                      ),
                    ],
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Text('Settings unavailable: $error'),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Settings unavailable: $error')),
      ),
    );
  }
}
