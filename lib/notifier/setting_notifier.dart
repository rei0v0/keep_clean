import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:keep_clean/model/setting_page_state.dart';

import '../model/location.dart';
import '../model/task.dart';

final settingPageProvider = StateNotifierProvider<SettingNotifier, SettingPageState>((ref) {
  return SettingNotifier();
});

class SettingNotifier extends StateNotifier<SettingPageState> {

  String _data = "Load JSON Data";

  SettingNotifier() : super(const SettingPageState()) {
    _init();
  }

  void _init() async{
      await loadJsonAsset();
  }
  Future<void> loadJsonAsset() async {
    _data = "";
    String loadData = await rootBundle.loadString('asset/test_data.json');
    _data = loadData;
    var parsed = json.decode(_data);
    List<Location> locations = [];

    for (var locationData in parsed["cleaning_tasks"]) {
      List<Task> tasks = [];
      String location = locationData["location"];
      for (var taskData in locationData["tasks"]) {
        Task task = Task(
          location: location,
          name: taskData["task"],
          lastUpdated: DateTime.parse(taskData["last_updated"]),
          cycle: taskData["cycle"],
        );
        tasks.add(task);
      }
      locations.add(Location(name: location, tasks: tasks));
    }
    state = state.copyWith(
      locations: locations
    );
  }
}