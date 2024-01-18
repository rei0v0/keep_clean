import 'package:freezed_annotation/freezed_annotation.dart';
part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task with _$Task {

  const factory Task({
    @JsonKey(name: '_id') int? id,
    required int locationId,
    @Default("unknown") String name,
    required DateTime nextDue,
    required String cycle,
  })  = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      TaskFields.locationId: locationId,
      TaskFields.name: name,
      TaskFields.nextDate: nextDue.toIso8601String(),
      TaskFields.cycle: cycle,
    };
  }

}

class TaskFields {
  static const String id = '_id';
  static const String locationId = 'locationId';
  static const String name = 'name';
  static const String nextDate = 'nextDue';
  static const String cycle = 'cycle';
}

const String tableTask = 'task';