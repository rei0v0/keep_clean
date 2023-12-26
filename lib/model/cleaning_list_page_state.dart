import 'package:freezed_annotation/freezed_annotation.dart';
part 'cleaning_list_page_state.freezed.dart';

// 以下で示すbuildをするまではErrorが出ると思うが、無視して良い。
// 状態変数を定義するclass
@freezed
// _$UserDataをmixinし、コンストラクタに_UserDataを代入する
class CleaningListPageState with _$CleaningListPageState {
  const factory CleaningListPageState({
    @Default(false) bool closeTopContainer,
    @Default(0.0) double topContainer,
    @Default(0.0) double position,
  })  = _CleaningListPageState;
}