import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';
import '../../models/camera_models.dart';
import '../../shared/widgets/metric_tile.dart';
import '../../shared/widgets/section_card.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/status_badge.dart';

class CameraManagerScreen extends ConsumerStatefulWidget {
  const CameraManagerScreen({super.key});

  @override
  ConsumerState<CameraManagerScreen> createState() => _CameraManagerScreenState();
}

class _CameraManagerScreenState extends ConsumerState<CameraManagerScreen> {
  String? _selectedCameraId;
  bool _capturing = false;

  @override
  Widget build(BuildContext context) {
    final sourcesAsync = ref.watch(cameraSourcesProvider);
    final lastCaptureAsync = ref.watch(captureRecordsProvider);
    final cameraManager = ref.watch(cameraManagerProvider);
    final settings = ref.watch(appSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Manager'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: () {
              ref.invalidate(cameraSourcesProvider);
              ref.invalidate(captureRecordsProvider);
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: sourcesAsync.when(
        data: (sources) {
          final settingsValue = settings.valueOrNull;
          _selectedCameraId ??= (settingsValue != null && settingsValue.defaultCameraSourceId.isNotEmpty)
              ? settingsValue.defaultCameraSourceId
              : (sources.isNotEmpty ? sources.first.id : null);
          final selectedSource = sources.firstWhere(
            (source) => source.id == _selectedCameraId,
            orElse: () => sources.first,
          );

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(
                      title: 'Discover and connect camera sources',
                      subtitle: 'The app never depends on a single camera implementation.',
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        for (final source in sources)
                          ChoiceChip(
                            label: Text(source.label),
                            selected: source.id == selectedSource.id,
                            onSelected: (_) async {
                              setState(() => _selectedCameraId = source.id);
                              await cameraManager.connect(source.id);
                              ref.invalidate(captureRecordsProvider);
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        StatusBadge(label: selectedSource.type.name),
                        StatusBadge(label: selectedSource.isAvailable ? 'Available' : 'Unavailable'),
                        StatusBadge(label: selectedSource.connectionHint ?? 'No hint'),
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
                  MetricTile(label: 'Resolution', value: '${selectedSource.type == CameraSourceType.usb ? '1920x1080' : '1920x1080'}', icon: Icons.aspect_ratio_rounded),
                  MetricTile(label: 'FPS', value: '30', icon: Icons.speed_rounded),
                  MetricTile(label: 'Flash', value: selectedSource.type == CameraSourceType.phoneRear ? 'Supported' : 'No', icon: Icons.flash_on_rounded),
                  MetricTile(label: 'Preview', value: 'Live Ready', icon: Icons.play_circle_rounded),
                ],
              ),
              const SizedBox(height: 20),
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(
                      title: 'Capture',
                      subtitle: 'Capture once, store locally, analyze on-device, then queue sync separately.',
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _capturing
                          ? null
                          : () async {
                              setState(() => _capturing = true);
                              try {
                                final workflow = ref.read(captureWorkflowServiceProvider);
                                final record = await workflow.captureAndStore(selectedSource.id);
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Captured ${record.id.substring(0, 8)} from ${selectedSource.label}')),
                                );
                                ref.invalidate(captureRecordsProvider);
                                ref.invalidate(dashboardStatsProvider);
                                ref.invalidate(syncQueueProvider);
                                ref.invalidate(visionEngineProvider);
                              } finally {
                                if (mounted) {
                                  setState(() => _capturing = false);
                                }
                              }
                            },
                      icon: _capturing
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.camera_alt_rounded),
                      label: Text(_capturing ? 'Capturing...' : 'Capture Image'),
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
                      title: 'Recent Captures',
                      subtitle: 'Latest local records from the full capture pipeline.',
                    ),
                    const SizedBox(height: 16),
                    lastCaptureAsync.when(
                      data: (captures) => captures.isEmpty
                          ? const Text('No captures yet.')
                          : Column(
                              children: [
                                for (final capture in captures.take(3))
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: Image.file(
                                          File(capture.thumbnailPath),
                                          width: 64,
                                          height: 64,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      title: Text(capture.cameraSource.label),
                                      subtitle: Text('${capture.visionResult.faceCount} faces, ${capture.visionResult.detectedObjects}'),
                                      trailing: Text('${capture.processingTimeMs} ms'),
                                    ),
                                  ),
                              ],
                            ),
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stackTrace) => Text('Recent captures unavailable: $error'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Camera manager unavailable: $error')),
      ),
    );
  }
}
