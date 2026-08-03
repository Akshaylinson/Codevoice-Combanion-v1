import '../../database/app_database.dart';
import '../../database/database_repository.dart';
import '../../models/camera_models.dart';
import '../../models/capture_models.dart';
import '../../models/sync_models.dart';

class CaptureRepository {
  CaptureRepository({required this.database}) : _repository = DatabaseRepository(database: database);

  final AppDatabase database;
  final DatabaseRepository _repository;

  Future<void> seedDefaultCameraSources() async {
    final sources = <CameraSource>[
      const CameraSource(
        id: 'phone_rear',
        label: 'Phone Rear Camera',
        type: CameraSourceType.phoneRear,
        isAvailable: true,
        manufacturer: 'Android',
        model: 'Rear Sensor',
        connectionHint: 'Native device camera',
      ),
      const CameraSource(
        id: 'phone_front',
        label: 'Phone Front Camera',
        type: CameraSourceType.phoneFront,
        isAvailable: true,
        manufacturer: 'Android',
        model: 'Front Sensor',
        connectionHint: 'Native device camera',
      ),
      const CameraSource(
        id: 'esp32_camera',
        label: 'ESP32 Camera',
        type: CameraSourceType.esp32,
        isAvailable: true,
        manufacturer: 'ESP32',
        model: 'AI Thinker',
        connectionHint: 'Wi-Fi stream adapter',
      ),
      const CameraSource(
        id: 'usb_camera',
        label: 'USB Camera',
        type: CameraSourceType.usb,
        isAvailable: true,
        manufacturer: 'USB UVC',
        model: 'External camera',
        connectionHint: 'USB host adapter',
      ),
    ];
    await _repository.insertCameraSources(sources);
  }

  Future<List<CameraSource>> readCameraSources() => _repository.readCameraSources();

  Future<void> saveCapture(CaptureRecord record) => _repository.upsertCapture(record);

  Future<void> updateCaptureSyncStatus({
    required String captureId,
    required UploadStatus status,
    String? remoteDriveUrl,
    String? remoteSheetRowId,
    String? lastError,
    int? syncAttempts,
  }) =>
      _repository.updateCaptureSyncStatus(
        captureId: captureId,
        status: status,
        remoteDriveUrl: remoteDriveUrl,
        remoteSheetRowId: remoteSheetRowId,
        lastError: lastError,
        syncAttempts: syncAttempts,
      );

  Future<List<CaptureRecord>> readCaptures({int limit = 100}) => _repository.readCaptures(limit: limit);

  Stream<List<CaptureRecord>> watchCaptures({int limit = 100}) => _repository.watchCaptures(limit: limit);

  Future<int> countCaptures() => _repository.countCaptures();

  Future<CaptureRecord?> readCaptureById(String id) async {
    final captures = await readCaptures(limit: 500);
    for (final capture in captures) {
      if (capture.id == id) {
        return capture;
      }
    }
    return null;
  }

  Future<CaptureRecord?> readLatestCapture() async {
    final captures = await readCaptures(limit: 1);
    return captures.isEmpty ? null : captures.first;
  }
}
