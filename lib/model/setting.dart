import 'package:freezed_annotation/freezed_annotation.dart';
part 'setting.freezed.dart';

@freezed

class Setting with _$Setting {
  const factory Setting({
    @Default("unknown") String location,
    @Default("unknown") String name,
    required DateTime lastUpdated,
    required String cycle,
  })  = _Setting;

}