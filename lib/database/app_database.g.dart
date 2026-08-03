// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CameraSourceEntriesTable extends CameraSourceEntries
    with TableInfo<$CameraSourceEntriesTable, CameraSourceEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CameraSourceEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CameraSourceType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CameraSourceType>(
        $CameraSourceEntriesTable.$convertertype,
      );
  static const VerificationMeta _isAvailableMeta = const VerificationMeta(
    'isAvailable',
  );
  @override
  late final GeneratedColumn<bool> isAvailable = GeneratedColumn<bool>(
    'is_available',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_available" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _manufacturerMeta = const VerificationMeta(
    'manufacturer',
  );
  @override
  late final GeneratedColumn<String> manufacturer = GeneratedColumn<String>(
    'manufacturer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _connectionHintMeta = const VerificationMeta(
    'connectionHint',
  );
  @override
  late final GeneratedColumn<String> connectionHint = GeneratedColumn<String>(
    'connection_hint',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSeenAtMeta = const VerificationMeta(
    'lastSeenAt',
  );
  @override
  late final GeneratedColumn<int> lastSeenAt = GeneratedColumn<int>(
    'last_seen_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    label,
    type,
    isAvailable,
    manufacturer,
    model,
    connectionHint,
    createdAt,
    lastSeenAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'camera_source_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CameraSourceEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('is_available')) {
      context.handle(
        _isAvailableMeta,
        isAvailable.isAcceptableOrUnknown(
          data['is_available']!,
          _isAvailableMeta,
        ),
      );
    }
    if (data.containsKey('manufacturer')) {
      context.handle(
        _manufacturerMeta,
        manufacturer.isAcceptableOrUnknown(
          data['manufacturer']!,
          _manufacturerMeta,
        ),
      );
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    }
    if (data.containsKey('connection_hint')) {
      context.handle(
        _connectionHintMeta,
        connectionHint.isAcceptableOrUnknown(
          data['connection_hint']!,
          _connectionHintMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_seen_at')) {
      context.handle(
        _lastSeenAtMeta,
        lastSeenAt.isAcceptableOrUnknown(
          data['last_seen_at']!,
          _lastSeenAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CameraSourceEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CameraSourceEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      type: $CameraSourceEntriesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      isAvailable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_available'],
      )!,
      manufacturer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manufacturer'],
      ),
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      ),
      connectionHint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}connection_hint'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      lastSeenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_seen_at'],
      ),
    );
  }

  @override
  $CameraSourceEntriesTable createAlias(String alias) {
    return $CameraSourceEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CameraSourceType, String, String> $convertertype =
      const EnumNameConverter<CameraSourceType>(CameraSourceType.values);
}

class CameraSourceEntry extends DataClass
    implements Insertable<CameraSourceEntry> {
  final String id;
  final String label;
  final CameraSourceType type;
  final bool isAvailable;
  final String? manufacturer;
  final String? model;
  final String? connectionHint;
  final int createdAt;
  final int? lastSeenAt;
  const CameraSourceEntry({
    required this.id,
    required this.label,
    required this.type,
    required this.isAvailable,
    this.manufacturer,
    this.model,
    this.connectionHint,
    required this.createdAt,
    this.lastSeenAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['label'] = Variable<String>(label);
    {
      map['type'] = Variable<String>(
        $CameraSourceEntriesTable.$convertertype.toSql(type),
      );
    }
    map['is_available'] = Variable<bool>(isAvailable);
    if (!nullToAbsent || manufacturer != null) {
      map['manufacturer'] = Variable<String>(manufacturer);
    }
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    if (!nullToAbsent || connectionHint != null) {
      map['connection_hint'] = Variable<String>(connectionHint);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || lastSeenAt != null) {
      map['last_seen_at'] = Variable<int>(lastSeenAt);
    }
    return map;
  }

  CameraSourceEntriesCompanion toCompanion(bool nullToAbsent) {
    return CameraSourceEntriesCompanion(
      id: Value(id),
      label: Value(label),
      type: Value(type),
      isAvailable: Value(isAvailable),
      manufacturer: manufacturer == null && nullToAbsent
          ? const Value.absent()
          : Value(manufacturer),
      model: model == null && nullToAbsent
          ? const Value.absent()
          : Value(model),
      connectionHint: connectionHint == null && nullToAbsent
          ? const Value.absent()
          : Value(connectionHint),
      createdAt: Value(createdAt),
      lastSeenAt: lastSeenAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSeenAt),
    );
  }

  factory CameraSourceEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CameraSourceEntry(
      id: serializer.fromJson<String>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      type: $CameraSourceEntriesTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      isAvailable: serializer.fromJson<bool>(json['isAvailable']),
      manufacturer: serializer.fromJson<String?>(json['manufacturer']),
      model: serializer.fromJson<String?>(json['model']),
      connectionHint: serializer.fromJson<String?>(json['connectionHint']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      lastSeenAt: serializer.fromJson<int?>(json['lastSeenAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'label': serializer.toJson<String>(label),
      'type': serializer.toJson<String>(
        $CameraSourceEntriesTable.$convertertype.toJson(type),
      ),
      'isAvailable': serializer.toJson<bool>(isAvailable),
      'manufacturer': serializer.toJson<String?>(manufacturer),
      'model': serializer.toJson<String?>(model),
      'connectionHint': serializer.toJson<String?>(connectionHint),
      'createdAt': serializer.toJson<int>(createdAt),
      'lastSeenAt': serializer.toJson<int?>(lastSeenAt),
    };
  }

  CameraSourceEntry copyWith({
    String? id,
    String? label,
    CameraSourceType? type,
    bool? isAvailable,
    Value<String?> manufacturer = const Value.absent(),
    Value<String?> model = const Value.absent(),
    Value<String?> connectionHint = const Value.absent(),
    int? createdAt,
    Value<int?> lastSeenAt = const Value.absent(),
  }) => CameraSourceEntry(
    id: id ?? this.id,
    label: label ?? this.label,
    type: type ?? this.type,
    isAvailable: isAvailable ?? this.isAvailable,
    manufacturer: manufacturer.present ? manufacturer.value : this.manufacturer,
    model: model.present ? model.value : this.model,
    connectionHint: connectionHint.present
        ? connectionHint.value
        : this.connectionHint,
    createdAt: createdAt ?? this.createdAt,
    lastSeenAt: lastSeenAt.present ? lastSeenAt.value : this.lastSeenAt,
  );
  CameraSourceEntry copyWithCompanion(CameraSourceEntriesCompanion data) {
    return CameraSourceEntry(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      type: data.type.present ? data.type.value : this.type,
      isAvailable: data.isAvailable.present
          ? data.isAvailable.value
          : this.isAvailable,
      manufacturer: data.manufacturer.present
          ? data.manufacturer.value
          : this.manufacturer,
      model: data.model.present ? data.model.value : this.model,
      connectionHint: data.connectionHint.present
          ? data.connectionHint.value
          : this.connectionHint,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastSeenAt: data.lastSeenAt.present
          ? data.lastSeenAt.value
          : this.lastSeenAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CameraSourceEntry(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('type: $type, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('connectionHint: $connectionHint, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastSeenAt: $lastSeenAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    label,
    type,
    isAvailable,
    manufacturer,
    model,
    connectionHint,
    createdAt,
    lastSeenAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CameraSourceEntry &&
          other.id == this.id &&
          other.label == this.label &&
          other.type == this.type &&
          other.isAvailable == this.isAvailable &&
          other.manufacturer == this.manufacturer &&
          other.model == this.model &&
          other.connectionHint == this.connectionHint &&
          other.createdAt == this.createdAt &&
          other.lastSeenAt == this.lastSeenAt);
}

class CameraSourceEntriesCompanion extends UpdateCompanion<CameraSourceEntry> {
  final Value<String> id;
  final Value<String> label;
  final Value<CameraSourceType> type;
  final Value<bool> isAvailable;
  final Value<String?> manufacturer;
  final Value<String?> model;
  final Value<String?> connectionHint;
  final Value<int> createdAt;
  final Value<int?> lastSeenAt;
  final Value<int> rowid;
  const CameraSourceEntriesCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.type = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.model = const Value.absent(),
    this.connectionHint = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CameraSourceEntriesCompanion.insert({
    required String id,
    required String label,
    required CameraSourceType type,
    this.isAvailable = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.model = const Value.absent(),
    this.connectionHint = const Value.absent(),
    required int createdAt,
    this.lastSeenAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       label = Value(label),
       type = Value(type),
       createdAt = Value(createdAt);
  static Insertable<CameraSourceEntry> custom({
    Expression<String>? id,
    Expression<String>? label,
    Expression<String>? type,
    Expression<bool>? isAvailable,
    Expression<String>? manufacturer,
    Expression<String>? model,
    Expression<String>? connectionHint,
    Expression<int>? createdAt,
    Expression<int>? lastSeenAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (type != null) 'type': type,
      if (isAvailable != null) 'is_available': isAvailable,
      if (manufacturer != null) 'manufacturer': manufacturer,
      if (model != null) 'model': model,
      if (connectionHint != null) 'connection_hint': connectionHint,
      if (createdAt != null) 'created_at': createdAt,
      if (lastSeenAt != null) 'last_seen_at': lastSeenAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CameraSourceEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? label,
    Value<CameraSourceType>? type,
    Value<bool>? isAvailable,
    Value<String?>? manufacturer,
    Value<String?>? model,
    Value<String?>? connectionHint,
    Value<int>? createdAt,
    Value<int?>? lastSeenAt,
    Value<int>? rowid,
  }) {
    return CameraSourceEntriesCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      type: type ?? this.type,
      isAvailable: isAvailable ?? this.isAvailable,
      manufacturer: manufacturer ?? this.manufacturer,
      model: model ?? this.model,
      connectionHint: connectionHint ?? this.connectionHint,
      createdAt: createdAt ?? this.createdAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $CameraSourceEntriesTable.$convertertype.toSql(type.value),
      );
    }
    if (isAvailable.present) {
      map['is_available'] = Variable<bool>(isAvailable.value);
    }
    if (manufacturer.present) {
      map['manufacturer'] = Variable<String>(manufacturer.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (connectionHint.present) {
      map['connection_hint'] = Variable<String>(connectionHint.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (lastSeenAt.present) {
      map['last_seen_at'] = Variable<int>(lastSeenAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CameraSourceEntriesCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('type: $type, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('connectionHint: $connectionHint, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastSeenAt: $lastSeenAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CaptureEntriesTable extends CaptureEntries
    with TableInfo<$CaptureEntriesTable, CaptureEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CaptureEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cameraSourceIdMeta = const VerificationMeta(
    'cameraSourceId',
  );
  @override
  late final GeneratedColumn<String> cameraSourceId = GeneratedColumn<String>(
    'camera_source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbnailPathMeta = const VerificationMeta(
    'thumbnailPath',
  );
  @override
  late final GeneratedColumn<String> thumbnailPath = GeneratedColumn<String>(
    'thumbnail_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('image/jpeg'),
  );
  static const VerificationMeta _capturedAtMeta = const VerificationMeta(
    'capturedAt',
  );
  @override
  late final GeneratedColumn<int> capturedAt = GeneratedColumn<int>(
    'captured_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _processingTimeMsMeta = const VerificationMeta(
    'processingTimeMs',
  );
  @override
  late final GeneratedColumn<int> processingTimeMs = GeneratedColumn<int>(
    'processing_time_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _faceCountMeta = const VerificationMeta(
    'faceCount',
  );
  @override
  late final GeneratedColumn<int> faceCount = GeneratedColumn<int>(
    'face_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detectedObjectsJsonMeta =
      const VerificationMeta('detectedObjectsJson');
  @override
  late final GeneratedColumn<String> detectedObjectsJson =
      GeneratedColumn<String>(
        'detected_objects_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _ocrTextMeta = const VerificationMeta(
    'ocrText',
  );
  @override
  late final GeneratedColumn<String> ocrText = GeneratedColumn<String>(
    'ocr_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qrTextMeta = const VerificationMeta('qrText');
  @override
  late final GeneratedColumn<String> qrText = GeneratedColumn<String>(
    'qr_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<UploadStatus, String>
  uploadStatus = GeneratedColumn<String>(
    'upload_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<UploadStatus>($CaptureEntriesTable.$converteruploadStatus);
  static const VerificationMeta _visionJsonMeta = const VerificationMeta(
    'visionJson',
  );
  @override
  late final GeneratedColumn<String> visionJson = GeneratedColumn<String>(
    'vision_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteDriveUrlMeta = const VerificationMeta(
    'remoteDriveUrl',
  );
  @override
  late final GeneratedColumn<String> remoteDriveUrl = GeneratedColumn<String>(
    'remote_drive_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remoteSheetRowIdMeta = const VerificationMeta(
    'remoteSheetRowId',
  );
  @override
  late final GeneratedColumn<String> remoteSheetRowId = GeneratedColumn<String>(
    'remote_sheet_row_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncAttemptsMeta = const VerificationMeta(
    'syncAttempts',
  );
  @override
  late final GeneratedColumn<int> syncAttempts = GeneratedColumn<int>(
    'sync_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cameraSourceId,
    imagePath,
    thumbnailPath,
    mimeType,
    capturedAt,
    latitude,
    longitude,
    note,
    processingTimeMs,
    confidence,
    faceCount,
    detectedObjectsJson,
    ocrText,
    qrText,
    uploadStatus,
    visionJson,
    remoteDriveUrl,
    remoteSheetRowId,
    syncAttempts,
    lastError,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'capture_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CaptureEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('camera_source_id')) {
      context.handle(
        _cameraSourceIdMeta,
        cameraSourceId.isAcceptableOrUnknown(
          data['camera_source_id']!,
          _cameraSourceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cameraSourceIdMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('thumbnail_path')) {
      context.handle(
        _thumbnailPathMeta,
        thumbnailPath.isAcceptableOrUnknown(
          data['thumbnail_path']!,
          _thumbnailPathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_thumbnailPathMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    }
    if (data.containsKey('captured_at')) {
      context.handle(
        _capturedAtMeta,
        capturedAt.isAcceptableOrUnknown(data['captured_at']!, _capturedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_capturedAtMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('processing_time_ms')) {
      context.handle(
        _processingTimeMsMeta,
        processingTimeMs.isAcceptableOrUnknown(
          data['processing_time_ms']!,
          _processingTimeMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_processingTimeMsMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('face_count')) {
      context.handle(
        _faceCountMeta,
        faceCount.isAcceptableOrUnknown(data['face_count']!, _faceCountMeta),
      );
    } else if (isInserting) {
      context.missing(_faceCountMeta);
    }
    if (data.containsKey('detected_objects_json')) {
      context.handle(
        _detectedObjectsJsonMeta,
        detectedObjectsJson.isAcceptableOrUnknown(
          data['detected_objects_json']!,
          _detectedObjectsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_detectedObjectsJsonMeta);
    }
    if (data.containsKey('ocr_text')) {
      context.handle(
        _ocrTextMeta,
        ocrText.isAcceptableOrUnknown(data['ocr_text']!, _ocrTextMeta),
      );
    } else if (isInserting) {
      context.missing(_ocrTextMeta);
    }
    if (data.containsKey('qr_text')) {
      context.handle(
        _qrTextMeta,
        qrText.isAcceptableOrUnknown(data['qr_text']!, _qrTextMeta),
      );
    } else if (isInserting) {
      context.missing(_qrTextMeta);
    }
    if (data.containsKey('vision_json')) {
      context.handle(
        _visionJsonMeta,
        visionJson.isAcceptableOrUnknown(data['vision_json']!, _visionJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_visionJsonMeta);
    }
    if (data.containsKey('remote_drive_url')) {
      context.handle(
        _remoteDriveUrlMeta,
        remoteDriveUrl.isAcceptableOrUnknown(
          data['remote_drive_url']!,
          _remoteDriveUrlMeta,
        ),
      );
    }
    if (data.containsKey('remote_sheet_row_id')) {
      context.handle(
        _remoteSheetRowIdMeta,
        remoteSheetRowId.isAcceptableOrUnknown(
          data['remote_sheet_row_id']!,
          _remoteSheetRowIdMeta,
        ),
      );
    }
    if (data.containsKey('sync_attempts')) {
      context.handle(
        _syncAttemptsMeta,
        syncAttempts.isAcceptableOrUnknown(
          data['sync_attempts']!,
          _syncAttemptsMeta,
        ),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CaptureEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CaptureEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      cameraSourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}camera_source_id'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
      thumbnailPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_path'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      )!,
      capturedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}captured_at'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      processingTimeMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}processing_time_ms'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      faceCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}face_count'],
      )!,
      detectedObjectsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detected_objects_json'],
      )!,
      ocrText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ocr_text'],
      )!,
      qrText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qr_text'],
      )!,
      uploadStatus: $CaptureEntriesTable.$converteruploadStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}upload_status'],
        )!,
      ),
      visionJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vision_json'],
      )!,
      remoteDriveUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_drive_url'],
      ),
      remoteSheetRowId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_sheet_row_id'],
      ),
      syncAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_attempts'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CaptureEntriesTable createAlias(String alias) {
    return $CaptureEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<UploadStatus, String, String>
  $converteruploadStatus = const EnumNameConverter<UploadStatus>(
    UploadStatus.values,
  );
}

class CaptureEntry extends DataClass implements Insertable<CaptureEntry> {
  final String id;
  final String cameraSourceId;
  final String imagePath;
  final String thumbnailPath;
  final String mimeType;
  final int capturedAt;
  final double? latitude;
  final double? longitude;
  final String? note;
  final int processingTimeMs;
  final double confidence;
  final int faceCount;
  final String detectedObjectsJson;
  final String ocrText;
  final String qrText;
  final UploadStatus uploadStatus;
  final String visionJson;
  final String? remoteDriveUrl;
  final String? remoteSheetRowId;
  final int syncAttempts;
  final String? lastError;
  final int createdAt;
  final int updatedAt;
  const CaptureEntry({
    required this.id,
    required this.cameraSourceId,
    required this.imagePath,
    required this.thumbnailPath,
    required this.mimeType,
    required this.capturedAt,
    this.latitude,
    this.longitude,
    this.note,
    required this.processingTimeMs,
    required this.confidence,
    required this.faceCount,
    required this.detectedObjectsJson,
    required this.ocrText,
    required this.qrText,
    required this.uploadStatus,
    required this.visionJson,
    this.remoteDriveUrl,
    this.remoteSheetRowId,
    required this.syncAttempts,
    this.lastError,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['camera_source_id'] = Variable<String>(cameraSourceId);
    map['image_path'] = Variable<String>(imagePath);
    map['thumbnail_path'] = Variable<String>(thumbnailPath);
    map['mime_type'] = Variable<String>(mimeType);
    map['captured_at'] = Variable<int>(capturedAt);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['processing_time_ms'] = Variable<int>(processingTimeMs);
    map['confidence'] = Variable<double>(confidence);
    map['face_count'] = Variable<int>(faceCount);
    map['detected_objects_json'] = Variable<String>(detectedObjectsJson);
    map['ocr_text'] = Variable<String>(ocrText);
    map['qr_text'] = Variable<String>(qrText);
    {
      map['upload_status'] = Variable<String>(
        $CaptureEntriesTable.$converteruploadStatus.toSql(uploadStatus),
      );
    }
    map['vision_json'] = Variable<String>(visionJson);
    if (!nullToAbsent || remoteDriveUrl != null) {
      map['remote_drive_url'] = Variable<String>(remoteDriveUrl);
    }
    if (!nullToAbsent || remoteSheetRowId != null) {
      map['remote_sheet_row_id'] = Variable<String>(remoteSheetRowId);
    }
    map['sync_attempts'] = Variable<int>(syncAttempts);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  CaptureEntriesCompanion toCompanion(bool nullToAbsent) {
    return CaptureEntriesCompanion(
      id: Value(id),
      cameraSourceId: Value(cameraSourceId),
      imagePath: Value(imagePath),
      thumbnailPath: Value(thumbnailPath),
      mimeType: Value(mimeType),
      capturedAt: Value(capturedAt),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      processingTimeMs: Value(processingTimeMs),
      confidence: Value(confidence),
      faceCount: Value(faceCount),
      detectedObjectsJson: Value(detectedObjectsJson),
      ocrText: Value(ocrText),
      qrText: Value(qrText),
      uploadStatus: Value(uploadStatus),
      visionJson: Value(visionJson),
      remoteDriveUrl: remoteDriveUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteDriveUrl),
      remoteSheetRowId: remoteSheetRowId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteSheetRowId),
      syncAttempts: Value(syncAttempts),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CaptureEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CaptureEntry(
      id: serializer.fromJson<String>(json['id']),
      cameraSourceId: serializer.fromJson<String>(json['cameraSourceId']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      thumbnailPath: serializer.fromJson<String>(json['thumbnailPath']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      capturedAt: serializer.fromJson<int>(json['capturedAt']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      note: serializer.fromJson<String?>(json['note']),
      processingTimeMs: serializer.fromJson<int>(json['processingTimeMs']),
      confidence: serializer.fromJson<double>(json['confidence']),
      faceCount: serializer.fromJson<int>(json['faceCount']),
      detectedObjectsJson: serializer.fromJson<String>(
        json['detectedObjectsJson'],
      ),
      ocrText: serializer.fromJson<String>(json['ocrText']),
      qrText: serializer.fromJson<String>(json['qrText']),
      uploadStatus: $CaptureEntriesTable.$converteruploadStatus.fromJson(
        serializer.fromJson<String>(json['uploadStatus']),
      ),
      visionJson: serializer.fromJson<String>(json['visionJson']),
      remoteDriveUrl: serializer.fromJson<String?>(json['remoteDriveUrl']),
      remoteSheetRowId: serializer.fromJson<String?>(json['remoteSheetRowId']),
      syncAttempts: serializer.fromJson<int>(json['syncAttempts']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'cameraSourceId': serializer.toJson<String>(cameraSourceId),
      'imagePath': serializer.toJson<String>(imagePath),
      'thumbnailPath': serializer.toJson<String>(thumbnailPath),
      'mimeType': serializer.toJson<String>(mimeType),
      'capturedAt': serializer.toJson<int>(capturedAt),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'note': serializer.toJson<String?>(note),
      'processingTimeMs': serializer.toJson<int>(processingTimeMs),
      'confidence': serializer.toJson<double>(confidence),
      'faceCount': serializer.toJson<int>(faceCount),
      'detectedObjectsJson': serializer.toJson<String>(detectedObjectsJson),
      'ocrText': serializer.toJson<String>(ocrText),
      'qrText': serializer.toJson<String>(qrText),
      'uploadStatus': serializer.toJson<String>(
        $CaptureEntriesTable.$converteruploadStatus.toJson(uploadStatus),
      ),
      'visionJson': serializer.toJson<String>(visionJson),
      'remoteDriveUrl': serializer.toJson<String?>(remoteDriveUrl),
      'remoteSheetRowId': serializer.toJson<String?>(remoteSheetRowId),
      'syncAttempts': serializer.toJson<int>(syncAttempts),
      'lastError': serializer.toJson<String?>(lastError),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  CaptureEntry copyWith({
    String? id,
    String? cameraSourceId,
    String? imagePath,
    String? thumbnailPath,
    String? mimeType,
    int? capturedAt,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<String?> note = const Value.absent(),
    int? processingTimeMs,
    double? confidence,
    int? faceCount,
    String? detectedObjectsJson,
    String? ocrText,
    String? qrText,
    UploadStatus? uploadStatus,
    String? visionJson,
    Value<String?> remoteDriveUrl = const Value.absent(),
    Value<String?> remoteSheetRowId = const Value.absent(),
    int? syncAttempts,
    Value<String?> lastError = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => CaptureEntry(
    id: id ?? this.id,
    cameraSourceId: cameraSourceId ?? this.cameraSourceId,
    imagePath: imagePath ?? this.imagePath,
    thumbnailPath: thumbnailPath ?? this.thumbnailPath,
    mimeType: mimeType ?? this.mimeType,
    capturedAt: capturedAt ?? this.capturedAt,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    note: note.present ? note.value : this.note,
    processingTimeMs: processingTimeMs ?? this.processingTimeMs,
    confidence: confidence ?? this.confidence,
    faceCount: faceCount ?? this.faceCount,
    detectedObjectsJson: detectedObjectsJson ?? this.detectedObjectsJson,
    ocrText: ocrText ?? this.ocrText,
    qrText: qrText ?? this.qrText,
    uploadStatus: uploadStatus ?? this.uploadStatus,
    visionJson: visionJson ?? this.visionJson,
    remoteDriveUrl: remoteDriveUrl.present
        ? remoteDriveUrl.value
        : this.remoteDriveUrl,
    remoteSheetRowId: remoteSheetRowId.present
        ? remoteSheetRowId.value
        : this.remoteSheetRowId,
    syncAttempts: syncAttempts ?? this.syncAttempts,
    lastError: lastError.present ? lastError.value : this.lastError,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CaptureEntry copyWithCompanion(CaptureEntriesCompanion data) {
    return CaptureEntry(
      id: data.id.present ? data.id.value : this.id,
      cameraSourceId: data.cameraSourceId.present
          ? data.cameraSourceId.value
          : this.cameraSourceId,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      thumbnailPath: data.thumbnailPath.present
          ? data.thumbnailPath.value
          : this.thumbnailPath,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      capturedAt: data.capturedAt.present
          ? data.capturedAt.value
          : this.capturedAt,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      note: data.note.present ? data.note.value : this.note,
      processingTimeMs: data.processingTimeMs.present
          ? data.processingTimeMs.value
          : this.processingTimeMs,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      faceCount: data.faceCount.present ? data.faceCount.value : this.faceCount,
      detectedObjectsJson: data.detectedObjectsJson.present
          ? data.detectedObjectsJson.value
          : this.detectedObjectsJson,
      ocrText: data.ocrText.present ? data.ocrText.value : this.ocrText,
      qrText: data.qrText.present ? data.qrText.value : this.qrText,
      uploadStatus: data.uploadStatus.present
          ? data.uploadStatus.value
          : this.uploadStatus,
      visionJson: data.visionJson.present
          ? data.visionJson.value
          : this.visionJson,
      remoteDriveUrl: data.remoteDriveUrl.present
          ? data.remoteDriveUrl.value
          : this.remoteDriveUrl,
      remoteSheetRowId: data.remoteSheetRowId.present
          ? data.remoteSheetRowId.value
          : this.remoteSheetRowId,
      syncAttempts: data.syncAttempts.present
          ? data.syncAttempts.value
          : this.syncAttempts,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CaptureEntry(')
          ..write('id: $id, ')
          ..write('cameraSourceId: $cameraSourceId, ')
          ..write('imagePath: $imagePath, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('mimeType: $mimeType, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('note: $note, ')
          ..write('processingTimeMs: $processingTimeMs, ')
          ..write('confidence: $confidence, ')
          ..write('faceCount: $faceCount, ')
          ..write('detectedObjectsJson: $detectedObjectsJson, ')
          ..write('ocrText: $ocrText, ')
          ..write('qrText: $qrText, ')
          ..write('uploadStatus: $uploadStatus, ')
          ..write('visionJson: $visionJson, ')
          ..write('remoteDriveUrl: $remoteDriveUrl, ')
          ..write('remoteSheetRowId: $remoteSheetRowId, ')
          ..write('syncAttempts: $syncAttempts, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    cameraSourceId,
    imagePath,
    thumbnailPath,
    mimeType,
    capturedAt,
    latitude,
    longitude,
    note,
    processingTimeMs,
    confidence,
    faceCount,
    detectedObjectsJson,
    ocrText,
    qrText,
    uploadStatus,
    visionJson,
    remoteDriveUrl,
    remoteSheetRowId,
    syncAttempts,
    lastError,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CaptureEntry &&
          other.id == this.id &&
          other.cameraSourceId == this.cameraSourceId &&
          other.imagePath == this.imagePath &&
          other.thumbnailPath == this.thumbnailPath &&
          other.mimeType == this.mimeType &&
          other.capturedAt == this.capturedAt &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.note == this.note &&
          other.processingTimeMs == this.processingTimeMs &&
          other.confidence == this.confidence &&
          other.faceCount == this.faceCount &&
          other.detectedObjectsJson == this.detectedObjectsJson &&
          other.ocrText == this.ocrText &&
          other.qrText == this.qrText &&
          other.uploadStatus == this.uploadStatus &&
          other.visionJson == this.visionJson &&
          other.remoteDriveUrl == this.remoteDriveUrl &&
          other.remoteSheetRowId == this.remoteSheetRowId &&
          other.syncAttempts == this.syncAttempts &&
          other.lastError == this.lastError &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CaptureEntriesCompanion extends UpdateCompanion<CaptureEntry> {
  final Value<String> id;
  final Value<String> cameraSourceId;
  final Value<String> imagePath;
  final Value<String> thumbnailPath;
  final Value<String> mimeType;
  final Value<int> capturedAt;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> note;
  final Value<int> processingTimeMs;
  final Value<double> confidence;
  final Value<int> faceCount;
  final Value<String> detectedObjectsJson;
  final Value<String> ocrText;
  final Value<String> qrText;
  final Value<UploadStatus> uploadStatus;
  final Value<String> visionJson;
  final Value<String?> remoteDriveUrl;
  final Value<String?> remoteSheetRowId;
  final Value<int> syncAttempts;
  final Value<String?> lastError;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const CaptureEntriesCompanion({
    this.id = const Value.absent(),
    this.cameraSourceId = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.thumbnailPath = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.capturedAt = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.note = const Value.absent(),
    this.processingTimeMs = const Value.absent(),
    this.confidence = const Value.absent(),
    this.faceCount = const Value.absent(),
    this.detectedObjectsJson = const Value.absent(),
    this.ocrText = const Value.absent(),
    this.qrText = const Value.absent(),
    this.uploadStatus = const Value.absent(),
    this.visionJson = const Value.absent(),
    this.remoteDriveUrl = const Value.absent(),
    this.remoteSheetRowId = const Value.absent(),
    this.syncAttempts = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CaptureEntriesCompanion.insert({
    required String id,
    required String cameraSourceId,
    required String imagePath,
    required String thumbnailPath,
    this.mimeType = const Value.absent(),
    required int capturedAt,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.note = const Value.absent(),
    required int processingTimeMs,
    required double confidence,
    required int faceCount,
    required String detectedObjectsJson,
    required String ocrText,
    required String qrText,
    required UploadStatus uploadStatus,
    required String visionJson,
    this.remoteDriveUrl = const Value.absent(),
    this.remoteSheetRowId = const Value.absent(),
    this.syncAttempts = const Value.absent(),
    this.lastError = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       cameraSourceId = Value(cameraSourceId),
       imagePath = Value(imagePath),
       thumbnailPath = Value(thumbnailPath),
       capturedAt = Value(capturedAt),
       processingTimeMs = Value(processingTimeMs),
       confidence = Value(confidence),
       faceCount = Value(faceCount),
       detectedObjectsJson = Value(detectedObjectsJson),
       ocrText = Value(ocrText),
       qrText = Value(qrText),
       uploadStatus = Value(uploadStatus),
       visionJson = Value(visionJson),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CaptureEntry> custom({
    Expression<String>? id,
    Expression<String>? cameraSourceId,
    Expression<String>? imagePath,
    Expression<String>? thumbnailPath,
    Expression<String>? mimeType,
    Expression<int>? capturedAt,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? note,
    Expression<int>? processingTimeMs,
    Expression<double>? confidence,
    Expression<int>? faceCount,
    Expression<String>? detectedObjectsJson,
    Expression<String>? ocrText,
    Expression<String>? qrText,
    Expression<String>? uploadStatus,
    Expression<String>? visionJson,
    Expression<String>? remoteDriveUrl,
    Expression<String>? remoteSheetRowId,
    Expression<int>? syncAttempts,
    Expression<String>? lastError,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cameraSourceId != null) 'camera_source_id': cameraSourceId,
      if (imagePath != null) 'image_path': imagePath,
      if (thumbnailPath != null) 'thumbnail_path': thumbnailPath,
      if (mimeType != null) 'mime_type': mimeType,
      if (capturedAt != null) 'captured_at': capturedAt,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (note != null) 'note': note,
      if (processingTimeMs != null) 'processing_time_ms': processingTimeMs,
      if (confidence != null) 'confidence': confidence,
      if (faceCount != null) 'face_count': faceCount,
      if (detectedObjectsJson != null)
        'detected_objects_json': detectedObjectsJson,
      if (ocrText != null) 'ocr_text': ocrText,
      if (qrText != null) 'qr_text': qrText,
      if (uploadStatus != null) 'upload_status': uploadStatus,
      if (visionJson != null) 'vision_json': visionJson,
      if (remoteDriveUrl != null) 'remote_drive_url': remoteDriveUrl,
      if (remoteSheetRowId != null) 'remote_sheet_row_id': remoteSheetRowId,
      if (syncAttempts != null) 'sync_attempts': syncAttempts,
      if (lastError != null) 'last_error': lastError,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CaptureEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? cameraSourceId,
    Value<String>? imagePath,
    Value<String>? thumbnailPath,
    Value<String>? mimeType,
    Value<int>? capturedAt,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? note,
    Value<int>? processingTimeMs,
    Value<double>? confidence,
    Value<int>? faceCount,
    Value<String>? detectedObjectsJson,
    Value<String>? ocrText,
    Value<String>? qrText,
    Value<UploadStatus>? uploadStatus,
    Value<String>? visionJson,
    Value<String?>? remoteDriveUrl,
    Value<String?>? remoteSheetRowId,
    Value<int>? syncAttempts,
    Value<String?>? lastError,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return CaptureEntriesCompanion(
      id: id ?? this.id,
      cameraSourceId: cameraSourceId ?? this.cameraSourceId,
      imagePath: imagePath ?? this.imagePath,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      mimeType: mimeType ?? this.mimeType,
      capturedAt: capturedAt ?? this.capturedAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      note: note ?? this.note,
      processingTimeMs: processingTimeMs ?? this.processingTimeMs,
      confidence: confidence ?? this.confidence,
      faceCount: faceCount ?? this.faceCount,
      detectedObjectsJson: detectedObjectsJson ?? this.detectedObjectsJson,
      ocrText: ocrText ?? this.ocrText,
      qrText: qrText ?? this.qrText,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      visionJson: visionJson ?? this.visionJson,
      remoteDriveUrl: remoteDriveUrl ?? this.remoteDriveUrl,
      remoteSheetRowId: remoteSheetRowId ?? this.remoteSheetRowId,
      syncAttempts: syncAttempts ?? this.syncAttempts,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (cameraSourceId.present) {
      map['camera_source_id'] = Variable<String>(cameraSourceId.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (thumbnailPath.present) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (capturedAt.present) {
      map['captured_at'] = Variable<int>(capturedAt.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (processingTimeMs.present) {
      map['processing_time_ms'] = Variable<int>(processingTimeMs.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (faceCount.present) {
      map['face_count'] = Variable<int>(faceCount.value);
    }
    if (detectedObjectsJson.present) {
      map['detected_objects_json'] = Variable<String>(
        detectedObjectsJson.value,
      );
    }
    if (ocrText.present) {
      map['ocr_text'] = Variable<String>(ocrText.value);
    }
    if (qrText.present) {
      map['qr_text'] = Variable<String>(qrText.value);
    }
    if (uploadStatus.present) {
      map['upload_status'] = Variable<String>(
        $CaptureEntriesTable.$converteruploadStatus.toSql(uploadStatus.value),
      );
    }
    if (visionJson.present) {
      map['vision_json'] = Variable<String>(visionJson.value);
    }
    if (remoteDriveUrl.present) {
      map['remote_drive_url'] = Variable<String>(remoteDriveUrl.value);
    }
    if (remoteSheetRowId.present) {
      map['remote_sheet_row_id'] = Variable<String>(remoteSheetRowId.value);
    }
    if (syncAttempts.present) {
      map['sync_attempts'] = Variable<int>(syncAttempts.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CaptureEntriesCompanion(')
          ..write('id: $id, ')
          ..write('cameraSourceId: $cameraSourceId, ')
          ..write('imagePath: $imagePath, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('mimeType: $mimeType, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('note: $note, ')
          ..write('processingTimeMs: $processingTimeMs, ')
          ..write('confidence: $confidence, ')
          ..write('faceCount: $faceCount, ')
          ..write('detectedObjectsJson: $detectedObjectsJson, ')
          ..write('ocrText: $ocrText, ')
          ..write('qrText: $qrText, ')
          ..write('uploadStatus: $uploadStatus, ')
          ..write('visionJson: $visionJson, ')
          ..write('remoteDriveUrl: $remoteDriveUrl, ')
          ..write('remoteSheetRowId: $remoteSheetRowId, ')
          ..write('syncAttempts: $syncAttempts, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueEntriesTable extends SyncQueueEntries
    with TableInfo<$SyncQueueEntriesTable, SyncQueueEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _captureIdMeta = const VerificationMeta(
    'captureId',
  );
  @override
  late final GeneratedColumn<String> captureId = GeneratedColumn<String>(
    'capture_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncJobStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SyncJobStatus>($SyncQueueEntriesTable.$converterstatus);
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remoteDriveUrlMeta = const VerificationMeta(
    'remoteDriveUrl',
  );
  @override
  late final GeneratedColumn<String> remoteDriveUrl = GeneratedColumn<String>(
    'remote_drive_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remoteSheetRowIdMeta = const VerificationMeta(
    'remoteSheetRowId',
  );
  @override
  late final GeneratedColumn<String> remoteSheetRowId = GeneratedColumn<String>(
    'remote_sheet_row_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextRetryAtMeta = const VerificationMeta(
    'nextRetryAt',
  );
  @override
  late final GeneratedColumn<int> nextRetryAt = GeneratedColumn<int>(
    'next_retry_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    captureId,
    status,
    attempts,
    lastError,
    remoteDriveUrl,
    remoteSheetRowId,
    nextRetryAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('capture_id')) {
      context.handle(
        _captureIdMeta,
        captureId.isAcceptableOrUnknown(data['capture_id']!, _captureIdMeta),
      );
    } else if (isInserting) {
      context.missing(_captureIdMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('remote_drive_url')) {
      context.handle(
        _remoteDriveUrlMeta,
        remoteDriveUrl.isAcceptableOrUnknown(
          data['remote_drive_url']!,
          _remoteDriveUrlMeta,
        ),
      );
    }
    if (data.containsKey('remote_sheet_row_id')) {
      context.handle(
        _remoteSheetRowIdMeta,
        remoteSheetRowId.isAcceptableOrUnknown(
          data['remote_sheet_row_id']!,
          _remoteSheetRowIdMeta,
        ),
      );
    }
    if (data.containsKey('next_retry_at')) {
      context.handle(
        _nextRetryAtMeta,
        nextRetryAt.isAcceptableOrUnknown(
          data['next_retry_at']!,
          _nextRetryAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      captureId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}capture_id'],
      )!,
      status: $SyncQueueEntriesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      remoteDriveUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_drive_url'],
      ),
      remoteSheetRowId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_sheet_row_id'],
      ),
      nextRetryAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_retry_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SyncQueueEntriesTable createAlias(String alias) {
    return $SyncQueueEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncJobStatus, String, String> $converterstatus =
      const EnumNameConverter<SyncJobStatus>(SyncJobStatus.values);
}

class SyncQueueEntry extends DataClass implements Insertable<SyncQueueEntry> {
  final String id;
  final String captureId;
  final SyncJobStatus status;
  final int attempts;
  final String? lastError;
  final String? remoteDriveUrl;
  final String? remoteSheetRowId;
  final int? nextRetryAt;
  final int createdAt;
  final int updatedAt;
  const SyncQueueEntry({
    required this.id,
    required this.captureId,
    required this.status,
    required this.attempts,
    this.lastError,
    this.remoteDriveUrl,
    this.remoteSheetRowId,
    this.nextRetryAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['capture_id'] = Variable<String>(captureId);
    {
      map['status'] = Variable<String>(
        $SyncQueueEntriesTable.$converterstatus.toSql(status),
      );
    }
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    if (!nullToAbsent || remoteDriveUrl != null) {
      map['remote_drive_url'] = Variable<String>(remoteDriveUrl);
    }
    if (!nullToAbsent || remoteSheetRowId != null) {
      map['remote_sheet_row_id'] = Variable<String>(remoteSheetRowId);
    }
    if (!nullToAbsent || nextRetryAt != null) {
      map['next_retry_at'] = Variable<int>(nextRetryAt);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  SyncQueueEntriesCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueEntriesCompanion(
      id: Value(id),
      captureId: Value(captureId),
      status: Value(status),
      attempts: Value(attempts),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      remoteDriveUrl: remoteDriveUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteDriveUrl),
      remoteSheetRowId: remoteSheetRowId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteSheetRowId),
      nextRetryAt: nextRetryAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextRetryAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SyncQueueEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueEntry(
      id: serializer.fromJson<String>(json['id']),
      captureId: serializer.fromJson<String>(json['captureId']),
      status: $SyncQueueEntriesTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      attempts: serializer.fromJson<int>(json['attempts']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      remoteDriveUrl: serializer.fromJson<String?>(json['remoteDriveUrl']),
      remoteSheetRowId: serializer.fromJson<String?>(json['remoteSheetRowId']),
      nextRetryAt: serializer.fromJson<int?>(json['nextRetryAt']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'captureId': serializer.toJson<String>(captureId),
      'status': serializer.toJson<String>(
        $SyncQueueEntriesTable.$converterstatus.toJson(status),
      ),
      'attempts': serializer.toJson<int>(attempts),
      'lastError': serializer.toJson<String?>(lastError),
      'remoteDriveUrl': serializer.toJson<String?>(remoteDriveUrl),
      'remoteSheetRowId': serializer.toJson<String?>(remoteSheetRowId),
      'nextRetryAt': serializer.toJson<int?>(nextRetryAt),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  SyncQueueEntry copyWith({
    String? id,
    String? captureId,
    SyncJobStatus? status,
    int? attempts,
    Value<String?> lastError = const Value.absent(),
    Value<String?> remoteDriveUrl = const Value.absent(),
    Value<String?> remoteSheetRowId = const Value.absent(),
    Value<int?> nextRetryAt = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => SyncQueueEntry(
    id: id ?? this.id,
    captureId: captureId ?? this.captureId,
    status: status ?? this.status,
    attempts: attempts ?? this.attempts,
    lastError: lastError.present ? lastError.value : this.lastError,
    remoteDriveUrl: remoteDriveUrl.present
        ? remoteDriveUrl.value
        : this.remoteDriveUrl,
    remoteSheetRowId: remoteSheetRowId.present
        ? remoteSheetRowId.value
        : this.remoteSheetRowId,
    nextRetryAt: nextRetryAt.present ? nextRetryAt.value : this.nextRetryAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SyncQueueEntry copyWithCompanion(SyncQueueEntriesCompanion data) {
    return SyncQueueEntry(
      id: data.id.present ? data.id.value : this.id,
      captureId: data.captureId.present ? data.captureId.value : this.captureId,
      status: data.status.present ? data.status.value : this.status,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      remoteDriveUrl: data.remoteDriveUrl.present
          ? data.remoteDriveUrl.value
          : this.remoteDriveUrl,
      remoteSheetRowId: data.remoteSheetRowId.present
          ? data.remoteSheetRowId.value
          : this.remoteSheetRowId,
      nextRetryAt: data.nextRetryAt.present
          ? data.nextRetryAt.value
          : this.nextRetryAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueEntry(')
          ..write('id: $id, ')
          ..write('captureId: $captureId, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError, ')
          ..write('remoteDriveUrl: $remoteDriveUrl, ')
          ..write('remoteSheetRowId: $remoteSheetRowId, ')
          ..write('nextRetryAt: $nextRetryAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    captureId,
    status,
    attempts,
    lastError,
    remoteDriveUrl,
    remoteSheetRowId,
    nextRetryAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueEntry &&
          other.id == this.id &&
          other.captureId == this.captureId &&
          other.status == this.status &&
          other.attempts == this.attempts &&
          other.lastError == this.lastError &&
          other.remoteDriveUrl == this.remoteDriveUrl &&
          other.remoteSheetRowId == this.remoteSheetRowId &&
          other.nextRetryAt == this.nextRetryAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SyncQueueEntriesCompanion extends UpdateCompanion<SyncQueueEntry> {
  final Value<String> id;
  final Value<String> captureId;
  final Value<SyncJobStatus> status;
  final Value<int> attempts;
  final Value<String?> lastError;
  final Value<String?> remoteDriveUrl;
  final Value<String?> remoteSheetRowId;
  final Value<int?> nextRetryAt;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const SyncQueueEntriesCompanion({
    this.id = const Value.absent(),
    this.captureId = const Value.absent(),
    this.status = const Value.absent(),
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
    this.remoteDriveUrl = const Value.absent(),
    this.remoteSheetRowId = const Value.absent(),
    this.nextRetryAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueEntriesCompanion.insert({
    required String id,
    required String captureId,
    required SyncJobStatus status,
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
    this.remoteDriveUrl = const Value.absent(),
    this.remoteSheetRowId = const Value.absent(),
    this.nextRetryAt = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       captureId = Value(captureId),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SyncQueueEntry> custom({
    Expression<String>? id,
    Expression<String>? captureId,
    Expression<String>? status,
    Expression<int>? attempts,
    Expression<String>? lastError,
    Expression<String>? remoteDriveUrl,
    Expression<String>? remoteSheetRowId,
    Expression<int>? nextRetryAt,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (captureId != null) 'capture_id': captureId,
      if (status != null) 'status': status,
      if (attempts != null) 'attempts': attempts,
      if (lastError != null) 'last_error': lastError,
      if (remoteDriveUrl != null) 'remote_drive_url': remoteDriveUrl,
      if (remoteSheetRowId != null) 'remote_sheet_row_id': remoteSheetRowId,
      if (nextRetryAt != null) 'next_retry_at': nextRetryAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? captureId,
    Value<SyncJobStatus>? status,
    Value<int>? attempts,
    Value<String?>? lastError,
    Value<String?>? remoteDriveUrl,
    Value<String?>? remoteSheetRowId,
    Value<int?>? nextRetryAt,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return SyncQueueEntriesCompanion(
      id: id ?? this.id,
      captureId: captureId ?? this.captureId,
      status: status ?? this.status,
      attempts: attempts ?? this.attempts,
      lastError: lastError ?? this.lastError,
      remoteDriveUrl: remoteDriveUrl ?? this.remoteDriveUrl,
      remoteSheetRowId: remoteSheetRowId ?? this.remoteSheetRowId,
      nextRetryAt: nextRetryAt ?? this.nextRetryAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (captureId.present) {
      map['capture_id'] = Variable<String>(captureId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $SyncQueueEntriesTable.$converterstatus.toSql(status.value),
      );
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (remoteDriveUrl.present) {
      map['remote_drive_url'] = Variable<String>(remoteDriveUrl.value);
    }
    if (remoteSheetRowId.present) {
      map['remote_sheet_row_id'] = Variable<String>(remoteSheetRowId.value);
    }
    if (nextRetryAt.present) {
      map['next_retry_at'] = Variable<int>(nextRetryAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueEntriesCompanion(')
          ..write('id: $id, ')
          ..write('captureId: $captureId, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError, ')
          ..write('remoteDriveUrl: $remoteDriveUrl, ')
          ..write('remoteSheetRowId: $remoteSheetRowId, ')
          ..write('nextRetryAt: $nextRetryAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingEntriesTable extends SettingEntries
    with TableInfo<$SettingEntriesTable, SettingEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'setting_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SettingEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingEntry(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SettingEntriesTable createAlias(String alias) {
    return $SettingEntriesTable(attachedDatabase, alias);
  }
}

class SettingEntry extends DataClass implements Insertable<SettingEntry> {
  final String key;
  final String value;
  final int updatedAt;
  const SettingEntry({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  SettingEntriesCompanion toCompanion(bool nullToAbsent) {
    return SettingEntriesCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory SettingEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingEntry(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  SettingEntry copyWith({String? key, String? value, int? updatedAt}) =>
      SettingEntry(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  SettingEntry copyWithCompanion(SettingEntriesCompanion data) {
    return SettingEntry(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingEntry(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingEntry &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class SettingEntriesCompanion extends UpdateCompanion<SettingEntry> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const SettingEntriesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingEntriesCompanion.insert({
    required String key,
    required String value,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       updatedAt = Value(updatedAt);
  static Insertable<SettingEntry> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingEntriesCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return SettingEntriesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingEntriesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CameraSourceEntriesTable cameraSourceEntries =
      $CameraSourceEntriesTable(this);
  late final $CaptureEntriesTable captureEntries = $CaptureEntriesTable(this);
  late final $SyncQueueEntriesTable syncQueueEntries = $SyncQueueEntriesTable(
    this,
  );
  late final $SettingEntriesTable settingEntries = $SettingEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cameraSourceEntries,
    captureEntries,
    syncQueueEntries,
    settingEntries,
  ];
}

typedef $$CameraSourceEntriesTableCreateCompanionBuilder =
    CameraSourceEntriesCompanion Function({
      required String id,
      required String label,
      required CameraSourceType type,
      Value<bool> isAvailable,
      Value<String?> manufacturer,
      Value<String?> model,
      Value<String?> connectionHint,
      required int createdAt,
      Value<int?> lastSeenAt,
      Value<int> rowid,
    });
typedef $$CameraSourceEntriesTableUpdateCompanionBuilder =
    CameraSourceEntriesCompanion Function({
      Value<String> id,
      Value<String> label,
      Value<CameraSourceType> type,
      Value<bool> isAvailable,
      Value<String?> manufacturer,
      Value<String?> model,
      Value<String?> connectionHint,
      Value<int> createdAt,
      Value<int?> lastSeenAt,
      Value<int> rowid,
    });

class $$CameraSourceEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $CameraSourceEntriesTable> {
  $$CameraSourceEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CameraSourceType, CameraSourceType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get connectionHint => $composableBuilder(
    column: $table.connectionHint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CameraSourceEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CameraSourceEntriesTable> {
  $$CameraSourceEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get connectionHint => $composableBuilder(
    column: $table.connectionHint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CameraSourceEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CameraSourceEntriesTable> {
  $$CameraSourceEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CameraSourceType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => column,
  );

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get connectionHint => $composableBuilder(
    column: $table.connectionHint,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => column,
  );
}

class $$CameraSourceEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CameraSourceEntriesTable,
          CameraSourceEntry,
          $$CameraSourceEntriesTableFilterComposer,
          $$CameraSourceEntriesTableOrderingComposer,
          $$CameraSourceEntriesTableAnnotationComposer,
          $$CameraSourceEntriesTableCreateCompanionBuilder,
          $$CameraSourceEntriesTableUpdateCompanionBuilder,
          (
            CameraSourceEntry,
            BaseReferences<
              _$AppDatabase,
              $CameraSourceEntriesTable,
              CameraSourceEntry
            >,
          ),
          CameraSourceEntry,
          PrefetchHooks Function()
        > {
  $$CameraSourceEntriesTableTableManager(
    _$AppDatabase db,
    $CameraSourceEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CameraSourceEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CameraSourceEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CameraSourceEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<CameraSourceType> type = const Value.absent(),
                Value<bool> isAvailable = const Value.absent(),
                Value<String?> manufacturer = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> connectionHint = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int?> lastSeenAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CameraSourceEntriesCompanion(
                id: id,
                label: label,
                type: type,
                isAvailable: isAvailable,
                manufacturer: manufacturer,
                model: model,
                connectionHint: connectionHint,
                createdAt: createdAt,
                lastSeenAt: lastSeenAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String label,
                required CameraSourceType type,
                Value<bool> isAvailable = const Value.absent(),
                Value<String?> manufacturer = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> connectionHint = const Value.absent(),
                required int createdAt,
                Value<int?> lastSeenAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CameraSourceEntriesCompanion.insert(
                id: id,
                label: label,
                type: type,
                isAvailable: isAvailable,
                manufacturer: manufacturer,
                model: model,
                connectionHint: connectionHint,
                createdAt: createdAt,
                lastSeenAt: lastSeenAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CameraSourceEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CameraSourceEntriesTable,
      CameraSourceEntry,
      $$CameraSourceEntriesTableFilterComposer,
      $$CameraSourceEntriesTableOrderingComposer,
      $$CameraSourceEntriesTableAnnotationComposer,
      $$CameraSourceEntriesTableCreateCompanionBuilder,
      $$CameraSourceEntriesTableUpdateCompanionBuilder,
      (
        CameraSourceEntry,
        BaseReferences<
          _$AppDatabase,
          $CameraSourceEntriesTable,
          CameraSourceEntry
        >,
      ),
      CameraSourceEntry,
      PrefetchHooks Function()
    >;
typedef $$CaptureEntriesTableCreateCompanionBuilder =
    CaptureEntriesCompanion Function({
      required String id,
      required String cameraSourceId,
      required String imagePath,
      required String thumbnailPath,
      Value<String> mimeType,
      required int capturedAt,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> note,
      required int processingTimeMs,
      required double confidence,
      required int faceCount,
      required String detectedObjectsJson,
      required String ocrText,
      required String qrText,
      required UploadStatus uploadStatus,
      required String visionJson,
      Value<String?> remoteDriveUrl,
      Value<String?> remoteSheetRowId,
      Value<int> syncAttempts,
      Value<String?> lastError,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$CaptureEntriesTableUpdateCompanionBuilder =
    CaptureEntriesCompanion Function({
      Value<String> id,
      Value<String> cameraSourceId,
      Value<String> imagePath,
      Value<String> thumbnailPath,
      Value<String> mimeType,
      Value<int> capturedAt,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> note,
      Value<int> processingTimeMs,
      Value<double> confidence,
      Value<int> faceCount,
      Value<String> detectedObjectsJson,
      Value<String> ocrText,
      Value<String> qrText,
      Value<UploadStatus> uploadStatus,
      Value<String> visionJson,
      Value<String?> remoteDriveUrl,
      Value<String?> remoteSheetRowId,
      Value<int> syncAttempts,
      Value<String?> lastError,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$CaptureEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $CaptureEntriesTable> {
  $$CaptureEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cameraSourceId => $composableBuilder(
    column: $table.cameraSourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get processingTimeMs => $composableBuilder(
    column: $table.processingTimeMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get faceCount => $composableBuilder(
    column: $table.faceCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detectedObjectsJson => $composableBuilder(
    column: $table.detectedObjectsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ocrText => $composableBuilder(
    column: $table.ocrText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qrText => $composableBuilder(
    column: $table.qrText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<UploadStatus, UploadStatus, String>
  get uploadStatus => $composableBuilder(
    column: $table.uploadStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get visionJson => $composableBuilder(
    column: $table.visionJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteDriveUrl => $composableBuilder(
    column: $table.remoteDriveUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteSheetRowId => $composableBuilder(
    column: $table.remoteSheetRowId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncAttempts => $composableBuilder(
    column: $table.syncAttempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CaptureEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CaptureEntriesTable> {
  $$CaptureEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cameraSourceId => $composableBuilder(
    column: $table.cameraSourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get processingTimeMs => $composableBuilder(
    column: $table.processingTimeMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get faceCount => $composableBuilder(
    column: $table.faceCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detectedObjectsJson => $composableBuilder(
    column: $table.detectedObjectsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ocrText => $composableBuilder(
    column: $table.ocrText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qrText => $composableBuilder(
    column: $table.qrText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uploadStatus => $composableBuilder(
    column: $table.uploadStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get visionJson => $composableBuilder(
    column: $table.visionJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteDriveUrl => $composableBuilder(
    column: $table.remoteDriveUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteSheetRowId => $composableBuilder(
    column: $table.remoteSheetRowId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncAttempts => $composableBuilder(
    column: $table.syncAttempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CaptureEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CaptureEntriesTable> {
  $$CaptureEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cameraSourceId => $composableBuilder(
    column: $table.cameraSourceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get processingTimeMs => $composableBuilder(
    column: $table.processingTimeMs,
    builder: (column) => column,
  );

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<int> get faceCount =>
      $composableBuilder(column: $table.faceCount, builder: (column) => column);

  GeneratedColumn<String> get detectedObjectsJson => $composableBuilder(
    column: $table.detectedObjectsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ocrText =>
      $composableBuilder(column: $table.ocrText, builder: (column) => column);

  GeneratedColumn<String> get qrText =>
      $composableBuilder(column: $table.qrText, builder: (column) => column);

  GeneratedColumnWithTypeConverter<UploadStatus, String> get uploadStatus =>
      $composableBuilder(
        column: $table.uploadStatus,
        builder: (column) => column,
      );

  GeneratedColumn<String> get visionJson => $composableBuilder(
    column: $table.visionJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteDriveUrl => $composableBuilder(
    column: $table.remoteDriveUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteSheetRowId => $composableBuilder(
    column: $table.remoteSheetRowId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get syncAttempts => $composableBuilder(
    column: $table.syncAttempts,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CaptureEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CaptureEntriesTable,
          CaptureEntry,
          $$CaptureEntriesTableFilterComposer,
          $$CaptureEntriesTableOrderingComposer,
          $$CaptureEntriesTableAnnotationComposer,
          $$CaptureEntriesTableCreateCompanionBuilder,
          $$CaptureEntriesTableUpdateCompanionBuilder,
          (
            CaptureEntry,
            BaseReferences<_$AppDatabase, $CaptureEntriesTable, CaptureEntry>,
          ),
          CaptureEntry,
          PrefetchHooks Function()
        > {
  $$CaptureEntriesTableTableManager(
    _$AppDatabase db,
    $CaptureEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CaptureEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CaptureEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CaptureEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> cameraSourceId = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
                Value<String> thumbnailPath = const Value.absent(),
                Value<String> mimeType = const Value.absent(),
                Value<int> capturedAt = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> processingTimeMs = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<int> faceCount = const Value.absent(),
                Value<String> detectedObjectsJson = const Value.absent(),
                Value<String> ocrText = const Value.absent(),
                Value<String> qrText = const Value.absent(),
                Value<UploadStatus> uploadStatus = const Value.absent(),
                Value<String> visionJson = const Value.absent(),
                Value<String?> remoteDriveUrl = const Value.absent(),
                Value<String?> remoteSheetRowId = const Value.absent(),
                Value<int> syncAttempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CaptureEntriesCompanion(
                id: id,
                cameraSourceId: cameraSourceId,
                imagePath: imagePath,
                thumbnailPath: thumbnailPath,
                mimeType: mimeType,
                capturedAt: capturedAt,
                latitude: latitude,
                longitude: longitude,
                note: note,
                processingTimeMs: processingTimeMs,
                confidence: confidence,
                faceCount: faceCount,
                detectedObjectsJson: detectedObjectsJson,
                ocrText: ocrText,
                qrText: qrText,
                uploadStatus: uploadStatus,
                visionJson: visionJson,
                remoteDriveUrl: remoteDriveUrl,
                remoteSheetRowId: remoteSheetRowId,
                syncAttempts: syncAttempts,
                lastError: lastError,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String cameraSourceId,
                required String imagePath,
                required String thumbnailPath,
                Value<String> mimeType = const Value.absent(),
                required int capturedAt,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required int processingTimeMs,
                required double confidence,
                required int faceCount,
                required String detectedObjectsJson,
                required String ocrText,
                required String qrText,
                required UploadStatus uploadStatus,
                required String visionJson,
                Value<String?> remoteDriveUrl = const Value.absent(),
                Value<String?> remoteSheetRowId = const Value.absent(),
                Value<int> syncAttempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CaptureEntriesCompanion.insert(
                id: id,
                cameraSourceId: cameraSourceId,
                imagePath: imagePath,
                thumbnailPath: thumbnailPath,
                mimeType: mimeType,
                capturedAt: capturedAt,
                latitude: latitude,
                longitude: longitude,
                note: note,
                processingTimeMs: processingTimeMs,
                confidence: confidence,
                faceCount: faceCount,
                detectedObjectsJson: detectedObjectsJson,
                ocrText: ocrText,
                qrText: qrText,
                uploadStatus: uploadStatus,
                visionJson: visionJson,
                remoteDriveUrl: remoteDriveUrl,
                remoteSheetRowId: remoteSheetRowId,
                syncAttempts: syncAttempts,
                lastError: lastError,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CaptureEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CaptureEntriesTable,
      CaptureEntry,
      $$CaptureEntriesTableFilterComposer,
      $$CaptureEntriesTableOrderingComposer,
      $$CaptureEntriesTableAnnotationComposer,
      $$CaptureEntriesTableCreateCompanionBuilder,
      $$CaptureEntriesTableUpdateCompanionBuilder,
      (
        CaptureEntry,
        BaseReferences<_$AppDatabase, $CaptureEntriesTable, CaptureEntry>,
      ),
      CaptureEntry,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueEntriesTableCreateCompanionBuilder =
    SyncQueueEntriesCompanion Function({
      required String id,
      required String captureId,
      required SyncJobStatus status,
      Value<int> attempts,
      Value<String?> lastError,
      Value<String?> remoteDriveUrl,
      Value<String?> remoteSheetRowId,
      Value<int?> nextRetryAt,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$SyncQueueEntriesTableUpdateCompanionBuilder =
    SyncQueueEntriesCompanion Function({
      Value<String> id,
      Value<String> captureId,
      Value<SyncJobStatus> status,
      Value<int> attempts,
      Value<String?> lastError,
      Value<String?> remoteDriveUrl,
      Value<String?> remoteSheetRowId,
      Value<int?> nextRetryAt,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$SyncQueueEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueEntriesTable> {
  $$SyncQueueEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get captureId => $composableBuilder(
    column: $table.captureId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncJobStatus, SyncJobStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteDriveUrl => $composableBuilder(
    column: $table.remoteDriveUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteSheetRowId => $composableBuilder(
    column: $table.remoteSheetRowId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueEntriesTable> {
  $$SyncQueueEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get captureId => $composableBuilder(
    column: $table.captureId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteDriveUrl => $composableBuilder(
    column: $table.remoteDriveUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteSheetRowId => $composableBuilder(
    column: $table.remoteSheetRowId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueEntriesTable> {
  $$SyncQueueEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get captureId =>
      $composableBuilder(column: $table.captureId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncJobStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<String> get remoteDriveUrl => $composableBuilder(
    column: $table.remoteDriveUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteSheetRowId => $composableBuilder(
    column: $table.remoteSheetRowId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SyncQueueEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueEntriesTable,
          SyncQueueEntry,
          $$SyncQueueEntriesTableFilterComposer,
          $$SyncQueueEntriesTableOrderingComposer,
          $$SyncQueueEntriesTableAnnotationComposer,
          $$SyncQueueEntriesTableCreateCompanionBuilder,
          $$SyncQueueEntriesTableUpdateCompanionBuilder,
          (
            SyncQueueEntry,
            BaseReferences<
              _$AppDatabase,
              $SyncQueueEntriesTable,
              SyncQueueEntry
            >,
          ),
          SyncQueueEntry,
          PrefetchHooks Function()
        > {
  $$SyncQueueEntriesTableTableManager(
    _$AppDatabase db,
    $SyncQueueEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> captureId = const Value.absent(),
                Value<SyncJobStatus> status = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<String?> remoteDriveUrl = const Value.absent(),
                Value<String?> remoteSheetRowId = const Value.absent(),
                Value<int?> nextRetryAt = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueEntriesCompanion(
                id: id,
                captureId: captureId,
                status: status,
                attempts: attempts,
                lastError: lastError,
                remoteDriveUrl: remoteDriveUrl,
                remoteSheetRowId: remoteSheetRowId,
                nextRetryAt: nextRetryAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String captureId,
                required SyncJobStatus status,
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<String?> remoteDriveUrl = const Value.absent(),
                Value<String?> remoteSheetRowId = const Value.absent(),
                Value<int?> nextRetryAt = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueEntriesCompanion.insert(
                id: id,
                captureId: captureId,
                status: status,
                attempts: attempts,
                lastError: lastError,
                remoteDriveUrl: remoteDriveUrl,
                remoteSheetRowId: remoteSheetRowId,
                nextRetryAt: nextRetryAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueEntriesTable,
      SyncQueueEntry,
      $$SyncQueueEntriesTableFilterComposer,
      $$SyncQueueEntriesTableOrderingComposer,
      $$SyncQueueEntriesTableAnnotationComposer,
      $$SyncQueueEntriesTableCreateCompanionBuilder,
      $$SyncQueueEntriesTableUpdateCompanionBuilder,
      (
        SyncQueueEntry,
        BaseReferences<_$AppDatabase, $SyncQueueEntriesTable, SyncQueueEntry>,
      ),
      SyncQueueEntry,
      PrefetchHooks Function()
    >;
typedef $$SettingEntriesTableCreateCompanionBuilder =
    SettingEntriesCompanion Function({
      required String key,
      required String value,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$SettingEntriesTableUpdateCompanionBuilder =
    SettingEntriesCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$SettingEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SettingEntriesTable> {
  $$SettingEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingEntriesTable> {
  $$SettingEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingEntriesTable> {
  $$SettingEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingEntriesTable,
          SettingEntry,
          $$SettingEntriesTableFilterComposer,
          $$SettingEntriesTableOrderingComposer,
          $$SettingEntriesTableAnnotationComposer,
          $$SettingEntriesTableCreateCompanionBuilder,
          $$SettingEntriesTableUpdateCompanionBuilder,
          (
            SettingEntry,
            BaseReferences<_$AppDatabase, $SettingEntriesTable, SettingEntry>,
          ),
          SettingEntry,
          PrefetchHooks Function()
        > {
  $$SettingEntriesTableTableManager(
    _$AppDatabase db,
    $SettingEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingEntriesCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SettingEntriesCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingEntriesTable,
      SettingEntry,
      $$SettingEntriesTableFilterComposer,
      $$SettingEntriesTableOrderingComposer,
      $$SettingEntriesTableAnnotationComposer,
      $$SettingEntriesTableCreateCompanionBuilder,
      $$SettingEntriesTableUpdateCompanionBuilder,
      (
        SettingEntry,
        BaseReferences<_$AppDatabase, $SettingEntriesTable, SettingEntry>,
      ),
      SettingEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CameraSourceEntriesTableTableManager get cameraSourceEntries =>
      $$CameraSourceEntriesTableTableManager(_db, _db.cameraSourceEntries);
  $$CaptureEntriesTableTableManager get captureEntries =>
      $$CaptureEntriesTableTableManager(_db, _db.captureEntries);
  $$SyncQueueEntriesTableTableManager get syncQueueEntries =>
      $$SyncQueueEntriesTableTableManager(_db, _db.syncQueueEntries);
  $$SettingEntriesTableTableManager get settingEntries =>
      $$SettingEntriesTableTableManager(_db, _db.settingEntries);
}
