import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keep_clean/model/cleaning_list_page_state.dart';
import 'package:keep_clean/model/task.dart';
import '../db/cleaningDB.dart';
import '../repository/cleaning_repository.dart';


final cleaningListProvider = StateNotifierProvider<CleaningListNotifier, CleaningListPageState>((ref) {
  return CleaningListNotifier(CleaningRepository(CleaningDatabase.instance));
});

class CleaningListNotifier extends StateNotifier<CleaningListPageState> {

  final CleaningRepository _cleaningRepository;

  //String _data = "Load JSON Data";
  List<Task> tasks = [];

  CleaningListNotifier(this._cleaningRepository) : super(const CleaningListPageState()) {
    init();
  }

  Future init() async {
    await loadLocations();
    await loadTasks();
  }

  Future loadLocations() async {
    final locations = await _cleaningRepository.getLocations();
    state = state.copyWith(locations: locations);
  }

  Future loadTasks() async {
    tasks = await _cleaningRepository.getAllTasks();
    state = state.copyWith(
      overdueTasks: getOverdueTasks(tasks),
      todayTasks: getDueTasks(tasks,0),
      tomorrowTasks: getDueTasks(tasks,1),
      threeDaysTasks: getDueTasks(tasks,3),
    );
  }

  String getIconName(int locationId){
    return state.locations.where((location) => location.id == locationId).first.iconName;
  }

  String getLocationName(int locationId){
    return state.locations.where((location) => location.id == locationId).first.name;
  }

  List<Task> getDueTasks(List<Task> tasks, int days) {
    DateTime today = DateTime.now();
    DateTime startDate;
    DateTime endDate;

    if (days == 0) {
      startDate = DateTime(today.year, today.month, today.day);
      endDate = startDate;
    } else if (days == 1) {
      startDate = DateTime(today.year, today.month, today.day).add(const Duration(days: 1));
      endDate = startDate;
    } else if (days == 3) {
      startDate = DateTime(today.year, today.month, today.day).add(const Duration(days: 2));
      endDate = DateTime(today.year, today.month, today.day).add(const Duration(days: 3));
    } else {
      startDate = DateTime(today.year, today.month, today.day).add(Duration(days: days));
      endDate = startDate;
    }

    return tasks.where((task) {
      DateTime dueDate = task.nextDue;
      DateTime justDueDate = DateTime(dueDate.year, dueDate.month, dueDate.day);
      return justDueDate.isAfter(startDate.subtract(const Duration(days: 1))) && justDueDate.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }


  List<Task> getOverdueTasks(List<Task> tasks) {
    DateTime today = DateTime.now();
    DateTime justToday = DateTime(today.year, today.month, today.day);
    return tasks.where((task) {
      DateTime dueDate = task.nextDue;
      DateTime justDueDate = DateTime(dueDate.year, dueDate.month, dueDate.day);
      return justDueDate.isBefore(justToday);
    }).toList();
  }

  void reload(){
    state = state.copyWith(
      overdueTasks: getOverdueTasks(tasks),
      todayTasks: getDueTasks(tasks,0),
      tomorrowTasks: getDueTasks(tasks,1),
      threeDaysTasks: getDueTasks(tasks,3),
    );
  }

  DateTime getNextWeekday(int weekday) {
    DateTime now = DateTime.now();
    int daysToAdd = (weekday - now.weekday + 7) % 7;
    if (daysToAdd == 0) {
      daysToAdd = 7;
    }
    DateTime nextWeekday = now.add(Duration(days: daysToAdd));
    return nextWeekday;
  }

  DateTime cycleDays(String cycle) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    switch (cycle.toLowerCase()) {
      case "daily":
        return today.add(const Duration(days: 1));
      case "bi-daily":
        return today.add(const Duration(days: 2));
      case "tri-daily":
        return today.add(const Duration(days: 3));
      case "weekly":
        return today.add(const Duration(days: 7));
      case "bi-weekly":
        return today.add(const Duration(days: 14));
      case "monthly":
        return today.add(const Duration(days: 30));
      case "sun":
        return getNextWeekday(0);
      case "mon":
        return getNextWeekday(1);
      case "tue":
        return getNextWeekday(2);
      case "wed":
        return getNextWeekday(3);
      case "thu":
        return getNextWeekday(4);
      case "fri":
        return getNextWeekday(5);
      case "sat":
        return getNextWeekday(6);
      default:
        return today.add(const Duration(days: 1));
    }
  }

  Future updateTask(Task task) async {
    tasks.remove(task);
    final nextDue = cycleDays(task.cycle);
    final newTask = Task(id: task.id, locationId: task.locationId, name: task.name, nextDue: nextDue, cycle: task.cycle);
    await _cleaningRepository.updateTask(newTask);
    tasks.add(newTask);
    reload();
  }

  Future changeDue(Task task, DateTime changedDue) async {
    tasks.remove(task);
    final newTask = Task(id: task.id, locationId: task.locationId, name: task.name, nextDue: changedDue, cycle: task.cycle);
    await _cleaningRepository.updateTask(newTask);
    tasks.add(newTask);
    reload();
  }

  bool notExistTasks() {
    if(tasks.isEmpty) return true;
    return false;
  }



}