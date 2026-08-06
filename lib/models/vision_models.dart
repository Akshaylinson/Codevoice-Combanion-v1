import 'package:equatable/equatable.dart';

import 'camera_models.dart';

class VisionBoundingBox extends Equatable {
  const VisionBoundingBox({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  });

  final double left;
  final double top;
  final double width;
  final double height;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'left': left,
        'top': top,
        'width': width,
        'height': height,
      };

  factory VisionBoundingBox.fromMap(Map<String, dynamic> map) {
    return VisionBoundingBox(
      left: (map['left'] as num).toDouble(),
      top: (map['top'] as num).toDouble(),
      width: (map['width'] as num).toDouble(),
      height: (map['height'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => <Object?>[left, top, width, height];
}

class VisionFace extends Equatable {
  const VisionFace({
    required this.boundingBox,
    required this.confidence,
  });

  final VisionBoundingBox boundingBox;
  final double confidence;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'boundingBox': boundingBox.toMap(),
        'confidence': confidence,
      };

  factory VisionFace.fromMap(Map<String, dynamic> map) {
    return VisionFace(
      boundingBox: VisionBoundingBox.fromMap(Map<String, dynamic>.from(map['boundingBox'] as Map)),
      confidence: (map['confidence'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => <Object?>[boundingBox, confidence];
}

class VisionObject extends Equatable {
  const VisionObject({
    required this.label,
    required this.confidence,
    required this.boundingBox,
  });

  final String label;
  final double confidence;
  final VisionBoundingBox boundingBox;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'label': label,
        'confidence': confidence,
        'boundingBox': boundingBox.toMap(),
      };

  factory VisionObject.fromMap(Map<String, dynamic> map) {
    return VisionObject(
      label: map['label'] as String,
      confidence: (map['confidence'] as num).toDouble(),
      boundingBox: VisionBoundingBox.fromMap(Map<String, dynamic>.from(map['boundingBox'] as Map)),
    );
  }

  @override
  List<Object?> get props => <Object?>[label, confidence, boundingBox];
}

class VisionTextBlock extends Equatable {
  const VisionTextBlock({
    required this.text,
    this.confidence,
    required this.language,
  });

  final String text;
  final double? confidence;
  final String language;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'text': text,
        'language': language,
        if (confidence != null) 'confidence': confidence,
      };

  factory VisionTextBlock.fromMap(Map<String, dynamic> map) {
    return VisionTextBlock(
      text: map['text'] as String,
      confidence: map['confidence'] == null ? null : (map['confidence'] as num).toDouble(),
      language: map['language'] as String,
    );
  }

  @override
  List<Object?> get props => <Object?>[text, confidence, language];
}

class VisionQrResult extends Equatable {
  const VisionQrResult({
    required this.rawValue,
    required this.format,
    this.confidence,
  });

  final String rawValue;
  final String format;
  final double? confidence;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'rawValue': rawValue,
        'format': format,
        if (confidence != null) 'confidence': confidence,
      };

  factory VisionQrResult.fromMap(Map<String, dynamic> map) {
    return VisionQrResult(
      rawValue: map['rawValue'] as String,
      format: map['format'] as String,
      confidence: map['confidence'] == null ? null : (map['confidence'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => <Object?>[rawValue, format, confidence];
}

class VisionPipelineStage extends Equatable {
  const VisionPipelineStage({
    required this.name,
    required this.durationMs,
    required this.isCompleted,
  });

  final String name;
  final int durationMs;
  final bool isCompleted;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
        'durationMs': durationMs,
        'isCompleted': isCompleted,
      };

  factory VisionPipelineStage.fromMap(Map<String, dynamic> map) {
    return VisionPipelineStage(
      name: map['name'] as String,
      durationMs: map['durationMs'] as int,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  @override
  List<Object?> get props => <Object?>[name, durationMs, isCompleted];
}

class VisionResult extends Equatable {
  const VisionResult({
    required this.imageId,
    required this.timestamp,
    required this.cameraSource,
    required this.faces,
    required this.objects,
    required this.ocrBlocks,
    required this.qrResults,
    required this.confidence,
    required this.processingTimeMs,
    required this.stages,
  });

  final String imageId;
  final DateTime timestamp;
  final CameraSource cameraSource;
  final List<VisionFace> faces;
  final List<VisionObject> objects;
  final List<VisionTextBlock> ocrBlocks;
  final List<VisionQrResult> qrResults;
  final double confidence;
  final int processingTimeMs;
  final List<VisionPipelineStage> stages;

  int get faceCount => faces.length;
  String get ocrText => ocrBlocks.map((block) => block.text).join('\n').trim();
  String get qrText => qrResults.map((qr) => qr.rawValue).join(', ').trim();
  String get detectedObjects => objects.map((object) => object.label).join(', ');

  Map<String, dynamic> toMap() => <String, dynamic>{
        'imageId': imageId,
        'timestamp': timestamp.toIso8601String(),
        'cameraSource': cameraSource.toMap(),
        'faces': faces.map((face) => face.toMap()).toList(),
        'objects': objects.map((object) => object.toMap()).toList(),
        'ocrBlocks': ocrBlocks.map((block) => block.toMap()).toList(),
        'qrResults': qrResults.map((qr) => qr.toMap()).toList(),
        'confidence': confidence,
        'processingTimeMs': processingTimeMs,
        'stages': stages.map((stage) => stage.toMap()).toList(),
      };

  factory VisionResult.fromMap(Map<String, dynamic> map) {
    return VisionResult(
      imageId: map['imageId'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
      cameraSource: CameraSource.fromMap(Map<String, dynamic>.from(map['cameraSource'] as Map)),
      faces: (map['faces'] as List<dynamic>? ?? const <dynamic>[])
          .map((dynamic face) => VisionFace.fromMap(Map<String, dynamic>.from(face as Map)))
          .toList(),
      objects: (map['objects'] as List<dynamic>? ?? const <dynamic>[])
          .map((dynamic object) => VisionObject.fromMap(Map<String, dynamic>.from(object as Map)))
          .toList(),
      ocrBlocks: (map['ocrBlocks'] as List<dynamic>? ?? const <dynamic>[])
          .map((dynamic block) => VisionTextBlock.fromMap(Map<String, dynamic>.from(block as Map)))
          .toList(),
      qrResults: (map['qrResults'] as List<dynamic>? ?? const <dynamic>[])
          .map((dynamic qr) => VisionQrResult.fromMap(Map<String, dynamic>.from(qr as Map)))
          .toList(),
      confidence: (map['confidence'] as num).toDouble(),
      processingTimeMs: map['processingTimeMs'] as int,
      stages: (map['stages'] as List<dynamic>? ?? const <dynamic>[])
          .map((dynamic stage) => VisionPipelineStage.fromMap(Map<String, dynamic>.from(stage as Map)))
          .toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[
        imageId,
        timestamp,
        cameraSource,
        faces,
        objects,
        ocrBlocks,
        qrResults,
        confidence,
        processingTimeMs,
        stages,
      ];
}
