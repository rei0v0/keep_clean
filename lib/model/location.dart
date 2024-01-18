import 'package:freezed_annotation/freezed_annotation.dart';
part 'location.freezed.dart';
part 'location.g.dart';
@freezed

class Location with _$Location {
  const factory Location({
    int? id,
    required String name,
    required String iconName,
  })  = _Location;

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

}

class LocationFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String iconName = 'iconName';
}

const String tableLocation = 'location';