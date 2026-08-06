import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/capture_models.dart';

class SyncResponse {
  const SyncResponse({
    required this.success,
    required this.message,
    this.driveUrl,
    this.sheetRowId,
    this.rawResponse,
  });

  final bool success;
  final String message;
  final String? driveUrl;
  final String? sheetRowId;
  final Map<String, dynamic>? rawResponse;
}

class AppsScriptClient {
  Future<SyncResponse> uploadCapture({
    required AppsScriptUploadPayload payload,
  }) async {
    if (payload.endpointUrl.isEmpty) {
      return const SyncResponse(
        success: false,
        message: 'Apps Script endpoint is not configured.',
      );
    }

    final request = http.MultipartRequest('POST', Uri.parse(payload.endpointUrl));
    request.fields.addAll(payload.toFields());
    request.files.add(
      await http.MultipartFile.fromPath('image', payload.capture.imagePath),
    );
    final response = await request.send();
    final body = await response.stream.bytesToString();
    final decoded = body.isEmpty ? <String, dynamic>{} : jsonDecode(body) as Map<String, dynamic>;
    final success = response.statusCode >= 200 && response.statusCode < 300;
    return SyncResponse(
      success: success,
      message: decoded['message']?.toString() ?? (success ? 'Upload completed.' : 'Upload failed.'),
      driveUrl: decoded['driveUrl']?.toString(),
      sheetRowId: decoded['sheetRowId']?.toString(),
      rawResponse: decoded,
    );
  }
}

class AppsScriptUploadPayload {
  const AppsScriptUploadPayload({
    required this.endpointUrl,
    required this.capture,
  });

  final String endpointUrl;
  final CaptureRecord capture;

  Map<String, String> toFields() => <String, String>{
        'imageId': capture.id,
        'timestamp': capture.capturedAt.toIso8601String(),
        'cameraSource': capture.cameraSource.label,
        'cameraSourceId': capture.cameraSource.id,
        'faceCount': capture.visionResult.faceCount.toString(),
        'detectedObjects': capture.visionResult.detectedObjects,
        'ocrResult': capture.visionResult.ocrText,
        'qrResult': capture.visionResult.qrText,
        'processingTimeMs': capture.processingTimeMs.toString(),
        'uploadStatus': capture.uploadStatus.name,
        'latitude': capture.latitude?.toString() ?? '',
        'longitude': capture.longitude?.toString() ?? '',
        'note': capture.note ?? '',
      };
}
