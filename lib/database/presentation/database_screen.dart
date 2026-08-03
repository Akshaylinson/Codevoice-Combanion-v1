import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';
import '../../shared/widgets/metric_tile.dart';
import '../../shared/widgets/section_card.dart';
import '../../shared/widgets/section_header.dart';

class DatabaseScreen extends ConsumerWidget {
  const DatabaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final capturesAsync = ref.watch(captureRecordsProvider);
    final syncQueueAsync = ref.watch(syncQueueProvider);
    final cameraSourcesAsync = ref.watch(cameraSourcesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Local Database')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(
                  title: 'Drift Storage',
                  subtitle: 'Camera sources, captures, queue items, and settings are stored locally first.',
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
              MetricTile(label: 'Camera Sources', value: '${cameraSourcesAsync.value?.length ?? 0}', icon: Icons.camera_alt_rounded),
              MetricTile(label: 'Captures', value: '${capturesAsync.value?.length ?? 0}', icon: Icons.photo_library_rounded),
              MetricTile(label: 'Sync Queue', value: '${syncQueueAsync.value?.length ?? 0}', icon: Icons.sync_rounded),
              MetricTile(label: 'Settings Rows', value: 'Stored', icon: Icons.settings_rounded),
            ],
          ),
          const SizedBox(height: 20),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: 'Schema Overview', subtitle: 'Four tables are enough for V1 while staying extensible.'),
                const SizedBox(height: 12),
                const Text('CameraSourceEntries, CaptureEntries, SyncQueueEntries, SettingEntries'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
