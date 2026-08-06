import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';
import '../../shared/widgets/metric_tile.dart';
import '../../shared/widgets/section_card.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/status_badge.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);
    final cameraSourcesAsync = ref.watch(cameraSourcesProvider);
    final settingsAsync = ref.watch(appSettingsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CodeVoice Vision'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: StatusBadge(label: 'Version 1 | Vision Platform'),
          ),
        ],
      ),
      body: statsAsync.when(
        data: (stats) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF102532), Color(0xFF0A1218), Color(0xFF132B22)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: Colors.white.withOpacity(0.06)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Local-first vision capture for every camera source', style: theme.textTheme.headlineMedium),
                    const SizedBox(height: 12),
                    Text(
                      'Capture, analyze, store, and sync images through a modular Android architecture that can grow into the future CodeVoice ecosystem.',
                      style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: const [
                        StatusBadge(label: 'Camera Manager'),
                        StatusBadge(label: 'Vision Engine'),
                        StatusBadge(label: 'Drift Local DB'),
                        StatusBadge(label: 'Apps Script Sync'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 700 ? 4 : 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.15,
                children: [
                  MetricTile(label: 'Captures Stored', value: '${stats.totalCaptures}', icon: Icons.photo_library_rounded),
                  MetricTile(label: 'Pending Sync Jobs', value: '${stats.pendingUploads}', icon: Icons.sync_rounded),
                  MetricTile(label: 'Camera Sources', value: '${cameraSourcesAsync.value?.length ?? 0}', icon: Icons.camera_alt_rounded),
                  MetricTile(
                    label: 'Sync Status',
                    value: settingsAsync.value?.appsScriptSettings.endpointUrl.isNotEmpty == true ? 'Configured' : 'Not Set',
                    icon: Icons.cloud_done_rounded,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(
                      title: 'System Overview',
                      subtitle: 'Everything is kept modular so future modules can plug in without changing the core flow.',
                    ),
                    const SizedBox(height: 16),
                    cameraSourcesAsync.when(
                      data: (sources) => Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [for (final source in sources) StatusBadge(label: source.label)],
                      ),
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stackTrace) => Text('Camera sources unavailable: $error'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(
                      title: 'Latest Capture',
                      subtitle: 'Local capture stays authoritative until the Sync Manager pushes it outward.',
                    ),
                    const SizedBox(height: 16),
                    if (stats.lastCapture == null)
                      const Text('No captures yet. Use the Camera tab to create the first record.')
                    else
                      Builder(
                        builder: (context) {
                          final capture = stats.lastCapture!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (capture.visionResult.ocrText.isNotEmpty)
                                Text(capture.visionResult.ocrText, style: theme.textTheme.titleMedium),
                              const SizedBox(height: 8),
                              Text('Objects: ${capture.visionResult.detectedObjects.isEmpty ? 'None' : capture.visionResult.detectedObjects}'),
                              Text('Camera: ${capture.cameraSource.label}'),
                              Text('Processing: ${capture.processingTimeMs} ms'),
                              if (capture.note != null && capture.note!.isNotEmpty) ...[
                                const SizedBox(height: 6),
                                Text('Note: ${capture.note}'),
                              ],
                            ],
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Dashboard unavailable: $error')),
      ),
    );
  }
}
