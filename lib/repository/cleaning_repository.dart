import 'package:keep_clean/db/cleaningDB.dart';
import 'package:keep_clean/model/location.dart';

class CleaningRepository {
  final CleaningDatabase _cleaningDatabase;
  CleaningRepository(this._cleaningDatabase);

  Future<List<Location>> getLocations() async {
    final List<Location> locations = await _cleaningDatabase.readAllLocations();
    return locations;
  }


}