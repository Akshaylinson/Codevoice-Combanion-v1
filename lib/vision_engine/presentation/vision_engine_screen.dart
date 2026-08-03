import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';
import '../../shared/widgets/section_card.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/status_badge.dart';

class VisionEngineScreen extends ConsumerWidget {
  const VisionEngineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final capturesAsync = ref.watch(captureRecordsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Vision Engine')),
      body: capturesAsync.when(
        data: (captures) {
          final latest = captures.isEmpty ? null : captures.first;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(
                      title: 'AI Vision Pipeline',
                      subtitle: 'Pre-processing, face detection, object detection, OCR, and QR detection run locally.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(title: 'Pipeline Stages', subtitle: 'Extension points remain ready for MediaPipe, YOLOv11n, PaddleOCR, and ML Kit.'),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: const [
                        StatusBadge(label: 'Pre-processing'),
                        StatusBadge(label: 'Face Detection'),
                        StatusBadge(label: 'Object Detection'),
                        StatusBadge(label: 'OCR'),
                        StatusBadge(label: 'QR Detection'),
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
                    const SectionHeader(title: 'Latest Result', subtitle: 'The unified VisionResult becomes the source of truth for the rest of the app.'),
                    const SizedBox(height: 16),
                    if (latest == null)
                      const Text('No vision results yet.')
                    else ...[
                      Text('Image ID: ${latest.id}'),
                      Text('Camera: ${latest.cameraSource.label}'),
                      Text('Captured: ${latest.capturedAt}'),
                      Text('Faces: ${latest.visionResult.faceCount}'),
                      Text('Objects: ${latest.visionResult.detectedObjects}'),
                      Text('OCR: ${latest.visionResult.ocrText}'),
                      Text('QR: ${latest.visionResult.qrText}'),
                      Text('Confidence: ${(latest.visionResult.confidence * 100).toStringAsFixed(1)}%'),
                      Text('Processing: ${latest.processingTimeMs} ms'),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(title: 'History', subtitle: 'Recent processed images with full structured output.'),
                    const SizedBox(height: 12),
                    if (captures.isEmpty)
                      const Text('No processed captures available.')
                    else
                      ...captures.take(5).map(
                        (capture) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(capture.cameraSource.label),
                            subtitle: Text('${capture.visionResult.faceCount} faces | ${capture.visionResult.detectedObjects}'),
                            trailing: StatusBadge(label: capture.uploadStatus.name),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Vision engine unavailable: $error')),
      ),
    );
  }
}
