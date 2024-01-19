import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keep_clean/db/cleaningDB.dart';
import 'package:keep_clean/repository/cleaning_repository.dart';
import '../model/location.dart';

final settingPageProvider = StateNotifierProvider<SettingNotifier, List<Location>>((ref) {
  return SettingNotifier(CleaningRepository(CleaningDatabase.instance));
});

class SettingNotifier extends StateNotifier<List<Location>> {

  final CleaningRepository _cleaningRepository;

  SettingNotifier(this._cleaningRepository) : super(const []) {
    _init();
  }

  void _init() async{
      await roadData();
  }

  Future<void> roadData() async {
    final locations = await _cleaningRepository.getLocations();
    state = locations;
  }

  Future<void> addLocation(Location location) async {
    await _cleaningRepository.addLocation(location);
  }

}