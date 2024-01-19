import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keep_clean/model/location.dart';
import 'package:keep_clean/model/task.dart';
part 'cleaning_list_page_state.freezed.dart';


@freezed

class CleaningListPageState with _$CleaningListPageState {
  const factory CleaningListPageState({
    @Default([]) List<Location> locations,
    @Default([]) List<Task> overdueTasks,
    @Default([]) List<Task> todayTasks,
    @Default([]) List<Task> tomorrowTasks,
    @Default([]) List<Task> threeDaysTasks,
  })  = _CleaningListPageState;
}