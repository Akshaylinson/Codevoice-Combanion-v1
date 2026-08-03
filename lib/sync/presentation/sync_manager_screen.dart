import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';
import '../../models/sync_models.dart';
import '../../shared/widgets/section_card.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/status_badge.dart';

class SyncManagerScreen extends ConsumerWidget {
  const SyncManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncQueueAsync = ref.watch(syncQueueProvider);
    final syncManager = ref.watch(syncManagerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sync Manager'),
        actions: [
          IconButton(
            onPressed: () => ref.invalidate(syncQueueProvider),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: syncQueueAsync.when(
        data: (jobs) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(
                    title: 'Isolated Cloud Sync',
                    subtitle: 'Only this manager talks to Google Apps Script, Google Drive, and Google Sheets.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (jobs.isEmpty)
              const Text('No sync jobs in the queue yet.')
            else
              for (final job in jobs)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SectionCard(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Capture ${job.captureId.substring(0, 8)}', style: Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 6),
                              Text('Attempts: ${job.attempts}'),
                              Text('Status: ${job.status.name}'),
                              if (job.lastError != null) Text('Last error: ${job.lastError}'),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            StatusBadge(label: job.status.name),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: job.status == SyncJobStatus.running
                                  ? null
                                  : () async {
                                      final captures = await ref.read(captureRepositoryProvider).readCaptures();
                                      final capture = captures.firstWhere((item) => item.id == job.captureId);
                                      final response = await syncManager.syncCapture(capture);
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(response.message)),
                                      );
                                    },
                              child: const Text('Sync now'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Sync manager unavailable: $error')),
      ),
    );
  }
}
