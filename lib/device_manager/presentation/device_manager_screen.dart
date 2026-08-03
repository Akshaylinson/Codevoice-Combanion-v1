import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';
import '../../shared/widgets/section_card.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/status_badge.dart';

class DeviceManagerScreen extends ConsumerWidget {
  const DeviceManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraSourcesAsync = ref.watch(cameraSourcesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Device Manager')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(
                  title: 'Device and camera inventory',
                  subtitle: 'A future adapter layer can map native capabilities here without changing the app structure.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: 'Runtime', subtitle: 'Basic host information for the current device.'),
                const SizedBox(height: 12),
                Text('Platform: ${Platform.operatingSystem}'),
                Text('Version: ${Platform.operatingSystemVersion}'),
                Text('Executable: ${Platform.resolvedExecutable}'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          cameraSourcesAsync.when(
            data: (sources) => SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'Sources', subtitle: 'All camera sources are treated as peers.'),
                  const SizedBox(height: 12),
                  for (final source in sources)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text(source.label)),
                          StatusBadge(label: source.type.name),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Text('Device inventory unavailable: $error'),
          ),
        ],
      ),
    );
  }
}
