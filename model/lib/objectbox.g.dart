// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';

import 'data/weather.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 7765062655362549306),
      name: 'Weather',
      lastPropertyId: const IdUid(4, 3707589965848411330),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5900991038394429313),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7888499216295426689),
            name: 'times',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 630382881704079493),
            name: 'temperatures',
            type: 29,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 3707589965848411330),
            name: 'humidity',
            type: 27,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Shortcut for [Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [Store.new] for an explanation of all parameters.
Store openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) =>
    Store(getObjectBoxModel(),
        directory: directory,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// Returns the ObjectBox model definition for this project for use with
/// [Store.new].
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 7765062655362549306),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Weather: EntityDefinition<Weather>(
        model: _entities[0],
        toOneRelations: (Weather object) => [],
        toManyRelations: (Weather object) => {},
        getId: (Weather object) => object.id,
        setId: (Weather object, int id) {
          object.id = id;
        },
        objectToFB: (Weather object, fb.Builder fbb) {
          final timesOffset = fbb.writeList(
              object.times.map(fbb.writeString).toList(growable: false));
          final temperaturesOffset = fbb.writeListFloat64(object.temperatures);
          final humidityOffset = fbb.writeListInt64(object.humidity);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, timesOffset);
          fbb.addOffset(2, temperaturesOffset);
          fbb.addOffset(3, humidityOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final temperaturesParam =
              const fb.ListReader<double>(fb.Float64Reader(), lazy: false)
                  .vTableGet(buffer, rootOffset, 8, []);
          final timesParam = const fb.ListReader<String>(
                  fb.StringReader(asciiOptimization: true),
                  lazy: false)
              .vTableGet(buffer, rootOffset, 6, []);
          final humidityParam =
              const fb.ListReader<int>(fb.Int64Reader(), lazy: false)
                  .vTableGet(buffer, rootOffset, 10, []);
          final object = Weather(
              id: idParam,
              temperatures: temperaturesParam,
              times: timesParam,
              humidity: humidityParam);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Weather] entity fields to define ObjectBox queries.
class Weather_ {
  /// see [Weather.id]
  static final id = QueryIntegerProperty<Weather>(_entities[0].properties[0]);

  /// see [Weather.times]
  static final times =
      QueryStringVectorProperty<Weather>(_entities[0].properties[1]);

  /// see [Weather.temperatures]
  static final temperatures =
      QueryDoubleVectorProperty<Weather>(_entities[0].properties[2]);

  /// see [Weather.humidity]
  static final humidity =
      QueryIntegerVectorProperty<Weather>(_entities[0].properties[3]);
}