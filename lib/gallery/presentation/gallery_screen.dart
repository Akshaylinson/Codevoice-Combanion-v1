import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/di/providers.dart';
import '../../models/capture_models.dart';
import '../../shared/widgets/section_card.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/status_badge.dart';
import 'capture_image_viewer_screen.dart';

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
              child: SectionHeader(
                title: 'Local Gallery',
                subtitle: 'Images, metadata, vision results, upload status, camera used, and timestamps live here first.',
              ),
            ),
            const SizedBox(height: 20),
            if (captures.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Text('No captures stored yet.'),
                ),
              )
            else
              for (final capture in captures)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _CaptureRow(capture: capture),
                ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Gallery unavailable: $error')),
      ),
    );
  }
}

class _CaptureRow extends StatelessWidget {
  const _CaptureRow({required this.capture});
  final CaptureRecord capture;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => CaptureImageViewerScreen(capture: capture)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: capture.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(capture.thumbnailPath),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(capture.cameraSource.label, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('MMM d, yyyy  HH:mm').format(capture.capturedAt),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 6),
                  Text('Objects: ${capture.visionResult.detectedObjects.isEmpty ? 'None' : capture.visionResult.detectedObjects}'),
                  if (capture.visionResult.ocrText.isNotEmpty)
                    Text('OCR: ${capture.visionResult.ocrText}', maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      StatusBadge(label: capture.uploadStatus.name),
                      StatusBadge(label: '${capture.processingTimeMs} ms'),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

