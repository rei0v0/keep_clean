import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keep_clean/model/task.dart';
import '../db/cleaningDB.dart';
import '../model/location.dart';
import '../repository/cleaning_repository.dart';


final registrationListProvider = StateNotifierProvider.family.autoDispose<RegistrationListNotifier,List<Task>,int>((ref,locationId) => RegistrationListNotifier(
  CleaningRepository(CleaningDatabase.instance,), locationId)
);

class RegistrationListNotifier extends StateNotifier<List<Task>>{

  final CleaningRepository _cleaningRepository;
  final int locationId;

  RegistrationListNotifier(this._cleaningRepository, this.locationId) : super(const []) {
    _init();
  }

  void _init() async{
    await fetchTasks();
  }

  Future fetchTasks() async {
    final tasks = await _cleaningRepository.getTasks(locationId);
    state = tasks;
  }

  Future addNewTask(Task task) async {
    //final newTask = task.copyWith(locationId: locationId);
    await _cleaningRepository.addTask(task);
  }

  List<Task> filterTasksByCycle(String cycle) {
    return state.where((task) => task.cycle == cycle).toList();
  }

  Future deleteTask(Task task) async {
    await _cleaningRepository.deleteTask(task);
  }

  Future deleteLocation(Location location) async {
    await _cleaningRepository.deleteLocation(location);
  }



}