import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keep_clean/model/location.dart';
part 'setting_page_state.freezed.dart';


@freezed

class SettingPageState with _$SettingPageState {
  const factory SettingPageState({
    @Default([]) List<Location> locations,
  })  = _SettingPageState;
}