import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';
import '../../shared/widgets/section_card.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/status_badge.dart';

class GalleryScreen extends ConsumerWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final capturesAsync = ref.watch(captureRecordsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        actions: [
          IconButton(
            onPressed: () => ref.invalidate(captureRecordsProvider),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: capturesAsync.when(
        data: (captures) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(
                    title: 'Local Gallery',
                    subtitle: 'Images, metadata, vision results, upload status, camera used, and timestamps live here first.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (captures.isEmpty)
              const Center(child: Padding(padding: EdgeInsets.all(40), child: Text('No captures stored yet.')))
            else
              for (final capture in captures)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SectionCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            File(capture.thumbnailPath),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(capture.cameraSource.label, style: Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 6),
                              Text('Captured: ${capture.capturedAt}'),
                              Text('Faces: ${capture.visionResult.faceCount}'),
                              Text('Objects: ${capture.visionResult.detectedObjects}'),
                              Text('OCR: ${capture.visionResult.ocrText}'),
                              Text('QR: ${capture.visionResult.qrText}'),
                              if (capture.note != null && capture.note!.isNotEmpty) ...[
                                const SizedBox(height: 6),
                                Text('Note: ${capture.note}'),
                              ],
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  StatusBadge(label: capture.uploadStatus.name),
                                  StatusBadge(label: '${capture.processingTimeMs} ms'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Gallery unavailable: $error')),
      ),
    );
  }
}
