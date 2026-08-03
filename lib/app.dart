import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'camera_manager/presentation/camera_manager_screen.dart';
import 'core/theme/app_theme.dart';
import 'database/presentation/database_screen.dart';
import 'device_manager/presentation/device_manager_screen.dart';
import 'gallery/presentation/gallery_screen.dart';
import 'settings/presentation/settings_screen.dart';
import 'shared/widgets/app_scaffold.dart';
import 'sync/presentation/sync_manager_screen.dart';
import 'vision_engine/presentation/vision_engine_screen.dart';
import 'home/presentation/dashboard_screen.dart';

class CodeVoiceVisionApp extends ConsumerWidget {
  const CodeVoiceVisionApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CodeVoice Vision',
      theme: AppTheme.dark(),
      home: AppScaffold(
        pages: [
          DashboardScreen(),
          CameraManagerScreen(),
          VisionEngineScreen(),
          GalleryScreen(),
          DatabaseScreen(),
          SyncManagerScreen(),
          DeviceManagerScreen(),
          SettingsScreen(),
        ],
        labels: [
          'Dashboard',
          'Camera',
          'Vision',
          'Gallery',
          'Database',
          'Sync',
          'Device',
          'Settings',
        ],
        icons: [
          Icons.dashboard_rounded,
          Icons.camera_alt_rounded,
          Icons.visibility_rounded,
          Icons.photo_library_rounded,
          Icons.storage_rounded,
          Icons.sync_rounded,
          Icons.devices_rounded,
          Icons.tune_rounded,
        ],
      ),
    );
  }
}
