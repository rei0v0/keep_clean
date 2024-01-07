import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keep_clean/model/task.dart';
part 'location.freezed.dart';

@freezed

class Location with _$Location {
  const factory Location({
    required String name,
    @Default([]) List<Task> tasks,
  })  = _Location;

}