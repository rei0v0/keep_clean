import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:keep_clean/db/cleaningDB.dart';
import 'package:keep_clean/model/setting_page_state.dart';
import 'package:keep_clean/repository/cleaning_repository.dart';
import '../model/location.dart';
import '../model/task.dart';

final settingPageProvider = StateNotifierProvider<SettingNotifier, List<Location>>((ref) {
  return SettingNotifier(CleaningRepository(CleaningDatabase.instance));
});

class SettingNotifier extends StateNotifier<List<Location>> {

  String _data = "Load JSON Data";
  final CleaningRepository _cleaningRepository;

  SettingNotifier(this._cleaningRepository) : super(const []) {
    _init();
  }

  void _init() async{
      //await loadJsonAsset();
      await roadData();
  }

  Future<void> roadData() async {
    final locations = await _cleaningRepository.getLocations();
    //print(locations);
    state = locations;
  }

  Future<void> addLocation(Location location) async {
    final locations = await _cleaningRepository.addLocation(location);
  }

  /*
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
          locationId: 0,
          name: taskData["task"],
          nextDue: DateTime.parse(taskData["last_updated"]),
          cycle: taskData["cycle"],
        );
        tasks.add(task);
      }
      locations.add(Location(name: location));
    }
    state = state.copyWith(
      locations: locations
    );
  }
   */
}