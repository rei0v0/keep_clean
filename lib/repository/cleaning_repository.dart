import 'package:keep_clean/db/cleaningDB.dart';
import 'package:keep_clean/model/location.dart';

import '../model/task.dart';

class CleaningRepository {
  final CleaningDatabase _cleaningDatabase;
  CleaningRepository(this._cleaningDatabase);

  Future<List<Location>> getLocations() async {
    final List<Location> locations = await _cleaningDatabase.readAllLocations();
    return locations;
  }

  Future<List<Task>> getTasks(int locationId) async {
    final List<Task> tasks = await _cleaningDatabase.readTasksInLocation(locationId);
    return tasks ?? [];
  }

  Future addTask(Task task) async {
    await _cleaningDatabase.insertTask(task);
  }

}