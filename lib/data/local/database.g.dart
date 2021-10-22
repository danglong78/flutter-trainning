// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Dog extends DataClass implements Insertable<Dog> {
  final int id;
  final String name;
  final String url;
  final bool isFile;
  final String breed;
  final String describe;
  Dog(
      {required this.id,
      required this.name,
      required this.url,
      required this.isFile,
      required this.breed,
      required this.describe});
  factory Dog.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Dog(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      url: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}url'])!,
      isFile: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}isFile'])!,
      breed: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}breed'])!,
      describe: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}describe'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['url'] = Variable<String>(url);
    map['isFile'] = Variable<bool>(isFile);
    map['breed'] = Variable<String>(breed);
    map['describe'] = Variable<String>(describe);
    return map;
  }

  DogsCompanion toCompanion(bool nullToAbsent) {
    return DogsCompanion(
      id: Value(id),
      name: Value(name),
      url: Value(url),
      isFile: Value(isFile),
      breed: Value(breed),
      describe: Value(describe),
    );
  }

  factory Dog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Dog(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      url: serializer.fromJson<String>(json['url']),
      isFile: serializer.fromJson<bool>(json['isFile']),
      breed: serializer.fromJson<String>(json['breed']),
      describe: serializer.fromJson<String>(json['describe']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'url': serializer.toJson<String>(url),
      'isFile': serializer.toJson<bool>(isFile),
      'breed': serializer.toJson<String>(breed),
      'describe': serializer.toJson<String>(describe),
    };
  }

  Dog copyWith(
          {int? id,
          String? name,
          String? url,
          bool? isFile,
          String? breed,
          String? describe}) =>
      Dog(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
        isFile: isFile ?? this.isFile,
        breed: breed ?? this.breed,
        describe: describe ?? this.describe,
      );
  @override
  String toString() {
    return (StringBuffer('Dog(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('isFile: $isFile, ')
          ..write('breed: $breed, ')
          ..write('describe: $describe')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, url, isFile, breed, describe);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Dog &&
          other.id == this.id &&
          other.name == this.name &&
          other.url == this.url &&
          other.isFile == this.isFile &&
          other.breed == this.breed &&
          other.describe == this.describe);
}

class DogsCompanion extends UpdateCompanion<Dog> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> url;
  final Value<bool> isFile;
  final Value<String> breed;
  final Value<String> describe;
  const DogsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.url = const Value.absent(),
    this.isFile = const Value.absent(),
    this.breed = const Value.absent(),
    this.describe = const Value.absent(),
  });
  DogsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String url,
    required bool isFile,
    required String breed,
    required String describe,
  })  : name = Value(name),
        url = Value(url),
        isFile = Value(isFile),
        breed = Value(breed),
        describe = Value(describe);
  static Insertable<Dog> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? url,
    Expression<bool>? isFile,
    Expression<String>? breed,
    Expression<String>? describe,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (url != null) 'url': url,
      if (isFile != null) 'isFile': isFile,
      if (breed != null) 'breed': breed,
      if (describe != null) 'describe': describe,
    });
  }

  DogsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? url,
      Value<bool>? isFile,
      Value<String>? breed,
      Value<String>? describe}) {
    return DogsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      isFile: isFile ?? this.isFile,
      breed: breed ?? this.breed,
      describe: describe ?? this.describe,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (isFile.present) {
      map['isFile'] = Variable<bool>(isFile.value);
    }
    if (breed.present) {
      map['breed'] = Variable<String>(breed.value);
    }
    if (describe.present) {
      map['describe'] = Variable<String>(describe.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DogsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('isFile: $isFile, ')
          ..write('breed: $breed, ')
          ..write('describe: $describe')
          ..write(')'))
        .toString();
  }
}

class $DogsTable extends Dogs with TableInfo<$DogsTable, Dog> {
  final GeneratedDatabase _db;
  final String? _alias;
  $DogsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _urlMeta = const VerificationMeta('url');
  late final GeneratedColumn<String?> url = GeneratedColumn<String?>(
      'url', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _isFileMeta = const VerificationMeta('isFile');
  late final GeneratedColumn<bool?> isFile = GeneratedColumn<bool?>(
      'isFile', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (isFile IN (0, 1))');
  final VerificationMeta _breedMeta = const VerificationMeta('breed');
  late final GeneratedColumn<String?> breed = GeneratedColumn<String?>(
      'breed', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _describeMeta = const VerificationMeta('describe');
  late final GeneratedColumn<String?> describe = GeneratedColumn<String?>(
      'describe', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, url, isFile, breed, describe];
  @override
  String get aliasedName => _alias ?? 'dogs';
  @override
  String get actualTableName => 'dogs';
  @override
  VerificationContext validateIntegrity(Insertable<Dog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('isFile')) {
      context.handle(_isFileMeta,
          isFile.isAcceptableOrUnknown(data['isFile']!, _isFileMeta));
    } else if (isInserting) {
      context.missing(_isFileMeta);
    }
    if (data.containsKey('breed')) {
      context.handle(
          _breedMeta, breed.isAcceptableOrUnknown(data['breed']!, _breedMeta));
    } else if (isInserting) {
      context.missing(_breedMeta);
    }
    if (data.containsKey('describe')) {
      context.handle(_describeMeta,
          describe.isAcceptableOrUnknown(data['describe']!, _describeMeta));
    } else if (isInserting) {
      context.missing(_describeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Dog map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Dog.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DogsTable createAlias(String alias) {
    return $DogsTable(_db, alias);
  }
}

class Upload extends DataClass implements Insertable<Upload> {
  final int id;
  final String status;
  final String path;
  Upload({required this.id, required this.status, required this.path});
  factory Upload.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Upload(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      status: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}status '])!,
      path: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}path'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['status '] = Variable<String>(status);
    map['path'] = Variable<String>(path);
    return map;
  }

  UploadsCompanion toCompanion(bool nullToAbsent) {
    return UploadsCompanion(
      id: Value(id),
      status: Value(status),
      path: Value(path),
    );
  }

  factory Upload.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Upload(
      id: serializer.fromJson<int>(json['id']),
      status: serializer.fromJson<String>(json['status']),
      path: serializer.fromJson<String>(json['path']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'status': serializer.toJson<String>(status),
      'path': serializer.toJson<String>(path),
    };
  }

  Upload copyWith({int? id, String? status, String? path}) => Upload(
        id: id ?? this.id,
        status: status ?? this.status,
        path: path ?? this.path,
      );
  @override
  String toString() {
    return (StringBuffer('Upload(')
          ..write('id: $id, ')
          ..write('status: $status, ')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, status, path);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Upload &&
          other.id == this.id &&
          other.status == this.status &&
          other.path == this.path);
}

class UploadsCompanion extends UpdateCompanion<Upload> {
  final Value<int> id;
  final Value<String> status;
  final Value<String> path;
  const UploadsCompanion({
    this.id = const Value.absent(),
    this.status = const Value.absent(),
    this.path = const Value.absent(),
  });
  UploadsCompanion.insert({
    this.id = const Value.absent(),
    required String status,
    required String path,
  })  : status = Value(status),
        path = Value(path);
  static Insertable<Upload> custom({
    Expression<int>? id,
    Expression<String>? status,
    Expression<String>? path,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (status != null) 'status ': status,
      if (path != null) 'path': path,
    });
  }

  UploadsCompanion copyWith(
      {Value<int>? id, Value<String>? status, Value<String>? path}) {
    return UploadsCompanion(
      id: id ?? this.id,
      status: status ?? this.status,
      path: path ?? this.path,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (status.present) {
      map['status '] = Variable<String>(status.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UploadsCompanion(')
          ..write('id: $id, ')
          ..write('status: $status, ')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }
}

class $UploadsTable extends Uploads with TableInfo<$UploadsTable, Upload> {
  final GeneratedDatabase _db;
  final String? _alias;
  $UploadsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _statusMeta = const VerificationMeta('status');
  late final GeneratedColumn<String?> status = GeneratedColumn<String?>(
      'status ', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _pathMeta = const VerificationMeta('path');
  late final GeneratedColumn<String?> path = GeneratedColumn<String?>(
      'path', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, status, path];
  @override
  String get aliasedName => _alias ?? 'uploads';
  @override
  String get actualTableName => 'uploads';
  @override
  VerificationContext validateIntegrity(Insertable<Upload> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('status ')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status ']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Upload map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Upload.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UploadsTable createAlias(String alias) {
    return $UploadsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $DogsTable dogs = $DogsTable(this);
  late final $UploadsTable uploads = $UploadsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dogs, uploads];
}
