// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      id: json['_id'] as int?,
      locationId: json['locationId'] as int,
      name: json['name'] as String? ?? "unknown",
      nextDue: DateTime.parse(json['nextDue'] as String),
      cycle: json['cycle'] as String,
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'locationId': instance.locationId,
      'name': instance.name,
      'nextDue': instance.nextDue.toIso8601String(),
      'cycle': instance.cycle,
    };
