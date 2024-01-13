import 'package:freezed_annotation/freezed_annotation.dart';
part 'location.freezed.dart';
part 'location.g.dart';
@freezed

class Location with _$Location {
  const factory Location({
    int? id,
    required String name,
  })  = _Location;

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

}

class LocationFields {
  static const String id = 'id';
  static const String name = 'name';
}

const String tableLocation = 'location';