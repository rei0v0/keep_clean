import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:keep_clean/model/cleaning_list_page_state.dart';
import 'package:keep_clean/model/task.dart';


final cleaningListProvider = StateNotifierProvider<CleaningListNotifier, CleaningListPageState>((ref) {
  return CleaningListNotifier();
});

class CleaningListNotifier extends StateNotifier<CleaningListPageState> {

  final ScrollController scrollController = ScrollController();
  final double currentPosition = 0.0;
  String _data = "Load JSON Data";
  List<Task> tasks = [];
  double topContainer = 0.0;

  CleaningListNotifier() : super(const CleaningListPageState()) {
    _initScrollController();
  }


  void _initScrollController() async {
    scrollController.addListener(_scrollListener);
    await loadJsonAsset();
  }
  void _scrollListener() {

    double value = scrollController.offset/100;
    print("offset");
    print(scrollController.offset);
    print(value);
    double positionRate =
        scrollController.offset / scrollController.position.maxScrollExtent;
    state = state.copyWith(topContainer: value, position: positionRate);

  }

  Future<void> loadJsonAsset() async {
    _data = "";
    String loadData = await rootBundle.loadString('asset/test_data.json');
    _data = loadData;
    var parsed = json.decode(_data);


    for (var locationData in parsed["cleaning_tasks"]) {
      String location = locationData["location"];
      for (var taskData in locationData["tasks"]) {
        Task task = Task(
          locationId: 0,
          name: taskData["task"],
          nextDue: DateTime.parse(taskData["last_updated"]),
          cycle: taskData["cycle"],
        );
        tasks.add(task);
      }
    }
    state = state.copyWith(
      overdueTasks: getOverdueTasks(tasks),
      todayTasks: getDueTasks(tasks,0),
      tomorrowTasks: getDueTasks(tasks,1),
      threeDaysTasks: getDueTasks(tasks,3),
    );
  }

  void reload(){
    state = state.copyWith(
      overdueTasks: getOverdueTasks(tasks),
      todayTasks: getDueTasks(tasks,0),
      tomorrowTasks: getDueTasks(tasks,1),
      threeDaysTasks: getDueTasks(tasks,3),
    );
  }

  int cycleDays(String cycle) {
    switch (cycle) {
      case "daily":
        return 1;
      case "weekly":
        return 7;
      case "bi-weekly":
        return 14;
      case "monthly":
        return 30;
      default:
        return 0;
    }
  }

  bool isDueWithin(Task task, int days) {
    final nextDueDate = task.nextDue.add(Duration(days: cycleDays(task.cycle)));
    print(task);
    print(nextDueDate);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day).add(Duration(days: days));
    return nextDueDate == today;
  }

  bool isOverdue(Task task) {
    final nextDueDate = task.nextDue.add(Duration(days: cycleDays(task.cycle)));
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return nextDueDate.isBefore(today);
  }

  List<Task> getDueTasks(List<Task> tasks, int days) {
    return tasks.where((task) => isDueWithin(task, days)).toList();
  }

  List<Task> getOverdueTasks(List<Task> tasks) {
    return tasks.where((task) => isOverdue(task)).toList();
  }

  void updateTask(Task task){
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final Task newTask = Task(name: task.name,locationId: 9,nextDue: today, cycle: task.cycle);
    tasks.remove(task);
    tasks.add(newTask);
    reload();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

}