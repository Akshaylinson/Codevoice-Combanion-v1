import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../camera_manager/data/native_camera_manager.dart';
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
  bool _previewActive = false;
  bool _permissionDenied = false;

  Future<void> _startPreview(String sourceId) async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      setState(() => _permissionDenied = true);
      return;
    }
    setState(() => _permissionDenied = false);
    final manager = ref.read(cameraManagerProvider) as NativeCameraManager;
    await manager.startPreview(sourceId);
    if (mounted) setState(() => _previewActive = true);
  }

  Future<void> _stopPreview(String sourceId) async {
    final manager = ref.read(cameraManagerProvider) as NativeCameraManager;
    await manager.stopPreview(sourceId);
    if (mounted) setState(() => _previewActive = false);
  }

  @override
  void dispose() {
    if (_selectedCameraId != null) {
      final manager = ref.read(cameraManagerProvider) as NativeCameraManager;
      manager.stopPreview(_selectedCameraId!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sourcesAsync = ref.watch(cameraSourcesProvider);
    final lastCaptureAsync = ref.watch(captureRecordsProvider);
    final cameraManager = ref.watch(cameraManagerProvider) as NativeCameraManager;
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
          if (sources.isEmpty) {
            return const Center(child: Text('No cameras found on this device.'));
          }
          final settingsValue = settings.valueOrNull;
          _selectedCameraId ??= (settingsValue != null && settingsValue.defaultCameraSourceId.isNotEmpty)
              ? settingsValue.defaultCameraSourceId
              : sources.first.id;
          final selectedSource = sources.firstWhere(
            (source) => source.id == _selectedCameraId,
            orElse: () => sources.first,
          );

          final controller = cameraManager.controllerFor(selectedSource.id);

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
                              if (_previewActive) await _stopPreview(selectedSource.id);
                              setState(() => _selectedCameraId = source.id);
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
                  MetricTile(label: 'Resolution', value: '1920x1080', icon: Icons.aspect_ratio_rounded),
                  MetricTile(label: 'FPS', value: '30', icon: Icons.speed_rounded),
                  MetricTile(label: 'Flash', value: selectedSource.type == CameraSourceType.phoneRear ? 'Supported' : 'No', icon: Icons.flash_on_rounded),
                  MetricTile(label: 'Preview', value: _previewActive ? 'Live' : 'Off', icon: Icons.play_circle_rounded),
                ],
              ),
              const SizedBox(height: 20),
              // Live camera preview
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(
                      title: 'Camera Preview',
                      subtitle: 'Start the preview to see what the camera sees before capturing.',
                    ),
                    const SizedBox(height: 16),
                    if (_permissionDenied)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          'Camera permission denied. Please grant it in app settings.',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    if (_previewActive && controller != null && controller.value.isInitialized)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: CameraPreview(controller),
                        ),
                      )
                    else
                      Container(
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(child: Text('Preview not started')),
                      ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _previewActive
                              ? () => _stopPreview(selectedSource.id)
                              : () => _startPreview(selectedSource.id),
                          icon: Icon(_previewActive ? Icons.stop_rounded : Icons.videocam_rounded),
                          label: Text(_previewActive ? 'Stop Preview' : 'Start Preview'),
                        ),
                      ],
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
                      title: 'Capture',
                      subtitle: 'Capture once, store locally, analyze on-device, then queue sync separately.',
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _capturing
                          ? null
                          : () async {
                              final sourceId = selectedSource.id;
                              final sourceLabel = selectedSource.label;
                              final messenger = ScaffoldMessenger.of(context);
                              if (!_previewActive) await _startPreview(sourceId);
                              setState(() => _capturing = true);
                              try {
                                final workflow = ref.read(captureWorkflowServiceProvider);
                                final record = await workflow.captureAndStore(sourceId);
                                if (!mounted) return;
                                messenger.showSnackBar(
                                  SnackBar(content: Text('Captured ${record.id.substring(0, 8)} from $sourceLabel')),
                                );
                                ref.invalidate(captureRecordsProvider);
                                ref.invalidate(dashboardStatsProvider);
                                ref.invalidate(syncQueueProvider);
                                ref.invalidate(visionEngineProvider);
                              } finally {
                                if (mounted) setState(() => _capturing = false);
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
