import 'package:freezed_annotation/freezed_annotation.dart';
part 'task.freezed.dart';

@freezed

class Task with _$Task {
  const factory Task({
    @Default("unknown") String location,
    @Default("unknown") String name,
    required DateTime lastUpdated,
    required String cycle,
  })  = _Task;

}