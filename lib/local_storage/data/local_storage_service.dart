import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:image/image.dart' as image_lib;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../database/app_database.dart';
import '../../models/capture_models.dart';

class LocalStorageService {
  LocalStorageService({required this.database});

  final AppDatabase database;
  final Uuid _uuid = const Uuid();
  Directory? _root;

  Future<void> initialize() async {
    _root = await getApplicationDocumentsDirectory();
    await _ensureFolders();
  }

  Future<Directory> get rootDirectory async {
    _root ??= await getApplicationDocumentsDirectory();
    return _root!;
  }

  Future<Directory> get imagesDirectory async => Directory(p.join((await rootDirectory).path, 'captures'));
  Future<Directory> get thumbnailsDirectory async => Directory(p.join((await rootDirectory).path, 'thumbnails'));
  Future<Directory> get exportsDirectory async => Directory(p.join((await rootDirectory).path, 'exports'));

  Future<void> _ensureFolders() async {
    for (final directory in <Directory>[
      await imagesDirectory,
      await thumbnailsDirectory,
      await exportsDirectory,
    ]) {
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
    }
  }

  Future<LocalAssetPaths> saveCaptureBytes({
    required String captureId,
    required List<int> imageBytes,
    required List<int> thumbnailBytes,
  }) async {
    await _ensureFolders();
    final imagePath = p.join((await imagesDirectory).path, '$captureId.jpg');
    final thumbnailPath = p.join((await thumbnailsDirectory).path, '$captureId.thumb.jpg');
    await File(imagePath).writeAsBytes(imageBytes, flush: true);
    await File(thumbnailPath).writeAsBytes(thumbnailBytes, flush: true);
    return LocalAssetPaths(imagePath: imagePath, thumbnailPath: thumbnailPath);
  }

  Future<List<int>> buildThumbnail({
    required List<int> imageBytes,
    required int width,
    required int height,
  }) async {
    final decoded = image_lib.decodeJpg(Uint8List.fromList(imageBytes));
    if (decoded == null) {
      return _buildFallbackThumbnail(width: width, height: height);
    }
    final thumbnailWidth = min(width, 320);
    final thumbnailHeight = max(180, (thumbnailWidth * decoded.height / decoded.width).round());
    final thumbnail = image_lib.copyResize(
      decoded,
      width: thumbnailWidth,
      height: thumbnailHeight,
    );
    return image_lib.encodeJpg(thumbnail, quality: 82);
  }

  Future<List<int>> _buildFallbackThumbnail({
    required int width,
    required int height,
  }) async {
    final image = image_lib.Image(width: width, height: height, numChannels: 3);
    for (var y = 0; y < height; y++) {
      final yFactor = y / max(1, height - 1);
      for (var x = 0; x < width; x++) {
        final xFactor = x / max(1, width - 1);
        image.setPixelRgb(
          x,
          y,
          (44 + 70 * xFactor).round(),
          (60 + 90 * yFactor).round(),
          (80 + 50 * (1 - xFactor)).round(),
        );
      }
    }
    return image_lib.encodeJpg(image, quality: 78);
  }

  Future<File> writeTextSnapshot(String name, String content) async {
    await _ensureFolders();
    final file = File(p.join((await exportsDirectory).path, name));
    await file.writeAsString(content, flush: true);
    return file;
  }

  String createCaptureId() => _uuid.v4();
}
