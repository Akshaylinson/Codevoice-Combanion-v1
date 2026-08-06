import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../models/capture_models.dart';
import '../../shared/widgets/status_badge.dart';

class CaptureImageViewerScreen extends StatefulWidget {
  const CaptureImageViewerScreen({super.key, required this.capture});

  final CaptureRecord capture;

  @override
  State<CaptureImageViewerScreen> createState() => _CaptureImageViewerScreenState();
}

class _CaptureImageViewerScreenState extends State<CaptureImageViewerScreen> {
  @override
  void initState() {
    super.initState();
    _lockPortrait();
  }

  Future<void> _lockPortrait() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<void> _restoreOrientation() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void dispose() {
    _restoreOrientation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final capture = widget.capture;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Text(
          DateFormat('MMM d, yyyy  HH:mm').format(capture.capturedAt),
          style: const TextStyle(fontSize: 14),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: Hero(
                  tag: capture.id,
                  child: ClipRect(
                    child: InteractiveViewer(
                      minScale: 1,
                      maxScale: 4,
                      child: Image.file(
                        File(capture.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  capture.cameraSource.label,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text('Objects: ${capture.visionResult.detectedObjects.isEmpty ? 'None detected' : capture.visionResult.detectedObjects}', style: const TextStyle(color: Colors.white70)),
                if (capture.visionResult.ocrBlocks.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  const Text('OCR:', style: TextStyle(color: Colors.white70)),
                  ...capture.visionResult.ocrBlocks.map(
                    (block) => Text('  ${block.text}', style: const TextStyle(color: Colors.white60, fontSize: 12)),
                  ),
                ],
                if (capture.visionResult.qrText.isNotEmpty)
                  Text('QR: ${capture.visionResult.qrText}', style: const TextStyle(color: Colors.white70)),
                if (capture.note != null && capture.note!.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text('Note: ${capture.note}', style: const TextStyle(color: Colors.white70)),
                ],
                const SizedBox(height: 12),
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
        ],
      ),
    );
  }
}
