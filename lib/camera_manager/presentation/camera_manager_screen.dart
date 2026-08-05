import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../camera_manager/data/native_camera_manager.dart';
import '../../core/di/providers.dart';
import '../../gallery/presentation/capture_image_viewer_screen.dart';
import '../../models/capture_models.dart';

class CameraManagerScreen extends ConsumerStatefulWidget {
  const CameraManagerScreen({super.key});

  @override
  ConsumerState<CameraManagerScreen> createState() => _CameraManagerScreenState();
}

class _CameraManagerScreenState extends ConsumerState<CameraManagerScreen> {
  String _selectedCameraId = 'phone_rear';
  bool _capturing = false;
  bool _initialized = false;
  bool _permissionDenied = false;
  CaptureRecord? _lastCaptured;

  @override
  void initState() {
    super.initState();
    _lockPortrait();
    _init();
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

  Future<void> _init() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      if (mounted) setState(() => _permissionDenied = true);
      return;
    }
    final manager = ref.read(cameraManagerProvider) as NativeCameraManager;
    await manager.startPreview(_selectedCameraId);
    if (mounted) setState(() => _initialized = true);
  }

  Future<void> _switchCamera() async {
    final manager = ref.read(cameraManagerProvider) as NativeCameraManager;
    await manager.stopPreview(_selectedCameraId);
    setState(() {
      _selectedCameraId = _selectedCameraId == 'phone_rear' ? 'phone_front' : 'phone_rear';
      _initialized = false;
    });
    await manager.startPreview(_selectedCameraId);
    if (mounted) setState(() => _initialized = true);
  }

  Future<void> _capture() async {
    if (_capturing || !_initialized) return;
    setState(() => _capturing = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final workflow = ref.read(captureWorkflowServiceProvider);
      final record = await workflow.captureAndStore(_selectedCameraId);
      if (!mounted) return;
      setState(() => _lastCaptured = record);
      messenger.showSnackBar(
        SnackBar(content: Text('Saved ${record.id.substring(0, 8)}')),
      );
      ref.invalidate(captureRecordsProvider);
      ref.invalidate(dashboardStatsProvider);
      ref.invalidate(syncQueueProvider);
      ref.invalidate(visionEngineProvider);
    } finally {
      if (mounted) setState(() => _capturing = false);
    }
  }

  @override
  void dispose() {
    final manager = ref.read(cameraManagerProvider) as NativeCameraManager;
    manager.stopPreview(_selectedCameraId);
    _restoreOrientation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final manager = ref.watch(cameraManagerProvider) as NativeCameraManager;
    final controller = manager.controllerFor(_selectedCameraId);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: _permissionDenied ? _buildPermissionDenied() : _buildCameraBody(context, controller),
    );
  }

  Widget _buildPermissionDenied() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.no_photography_rounded, size: 64, color: Colors.white54),
            SizedBox(height: 16),
            Text(
              'Camera permission is required.\nPlease grant it in app settings.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraBody(BuildContext context, CameraController? controller) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: 9 / 16,
            child: ClipRect(
              child: _initialized && controller != null && controller.value.isInitialized
                  ? CameraPreview(controller)
                  : const ColoredBox(
                      color: Colors.black,
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white54),
                      ),
                    ),
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [Colors.black87, Colors.transparent],
                ),
              ),
            ),
          ),
        ),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 8, 0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Live Capture',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Preview, shutter, and recent capture stay on one 9:16 screen',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.flip_camera_android_rounded, color: Colors.white),
                  tooltip: 'Switch camera',
                  onPressed: _initialized ? _switchCamera : null,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black87, Colors.transparent],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _lastCaptured != null
                      ? () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CaptureImageViewerScreen(capture: _lastCaptured!),
                            ),
                          )
                      : null,
                  child: AnimatedOpacity(
                    opacity: _lastCaptured == null ? 0.35 : 1,
                    duration: const Duration(milliseconds: 180),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: _lastCaptured != null
                              ? Hero(
                                  tag: _lastCaptured!.id,
                                  child: Image.file(
                                    File(_lastCaptured!.thumbnailPath),
                                    width: 58,
                                    height: 58,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  width: 58,
                                  height: 58,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white30),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                        ),
                        if (_lastCaptured != null)
                          Positioned(
                            right: -2,
                            bottom: -2,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.black87,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.zoom_out_map_rounded, color: Colors.white, size: 12),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _capture,
                  child: Container(
                    width: 78,
                    height: 78,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      color: _capturing ? Colors.white54 : Colors.white24,
                    ),
                    child: _capturing
                        ? const Padding(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
                const SizedBox(width: 58),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
