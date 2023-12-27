import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keep_clean/model/task.dart';
part 'cleaning_list_page_state.freezed.dart';


@freezed

class CleaningListPageState with _$CleaningListPageState {
  const factory CleaningListPageState({
    @Default(false) bool closeTopContainer,
    @Default(0.0) double topContainer,
    @Default(0.0) double position,
    @Default([]) List<Task> overdueTasks,
    @Default([]) List<Task> todayTasks,
    @Default([]) List<Task> tomorrowTasks,
    @Default([]) List<Task> threeDaysTasks,
  })  = _CleaningListPageState;
}