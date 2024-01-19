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

  Future<List<Task>> getAllTasks() async {
    final List<Task> tasks = await _cleaningDatabase.readAllTasks();
    return tasks;
  }


  Future<List<Task>> getTasks(int locationId) async {
    final List<Task> tasks = await _cleaningDatabase.readTasksInLocation(locationId);
    return tasks;
  }

  Future addTask(Task task) async {
    await _cleaningDatabase.insertTask(task);
  }

  Future addLocation(Location location) async {
    await _cleaningDatabase.insertLocation(location);
  }

  Future updateTask(Task task) async {
    await _cleaningDatabase.updateTask(task);
  }

  Future deleteTask(Task task) async {
    await _cleaningDatabase.deleteTask(task);
  }

  Future deleteLocation(Location location) async {
    await _cleaningDatabase.deleteLocation(location);
  }

}