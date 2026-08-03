import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/camera_models.dart';
import '../models/sync_models.dart';

part 'app_database.g.dart';

class CameraSourceEntries extends Table {
  TextColumn get id => text()();
  TextColumn get label => text()();
  TextColumn get type => textEnum<CameraSourceType>()();
  BoolColumn get isAvailable => boolean().withDefault(const Constant(true))();
  TextColumn get manufacturer => text().nullable()();
  TextColumn get model => text().nullable()();
  TextColumn get connectionHint => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get lastSeenAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

class CaptureEntries extends Table {
  TextColumn get id => text()();
  TextColumn get cameraSourceId => text()();
  TextColumn get imagePath => text()();
  TextColumn get thumbnailPath => text()();
  TextColumn get mimeType => text().withDefault(const Constant('image/jpeg'))();
  IntColumn get capturedAt => integer()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get note => text().nullable()();
  IntColumn get processingTimeMs => integer()();
  RealColumn get confidence => real()();
  IntColumn get faceCount => integer()();
  TextColumn get detectedObjectsJson => text()();
  TextColumn get ocrText => text()();
  TextColumn get qrText => text()();
  TextColumn get uploadStatus => textEnum<UploadStatus>()();
  TextColumn get visionJson => text()();
  TextColumn get remoteDriveUrl => text().nullable()();
  TextColumn get remoteSheetRowId => text().nullable()();
  IntColumn get syncAttempts => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

class SyncQueueEntries extends Table {
  TextColumn get id => text()();
  TextColumn get captureId => text()();
  TextColumn get status => textEnum<SyncJobStatus>()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  TextColumn get remoteDriveUrl => text().nullable()();
  TextColumn get remoteSheetRowId => text().nullable()();
  IntColumn get nextRetryAt => integer().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

class SettingEntries extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{key};
}

@DriftDatabase(
  tables: <Type>[
    CameraSourceEntries,
    CaptureEntries,
    SyncQueueEntries,
    SettingEntries,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File(p.join(directory.path, 'codevoice_vision.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
