// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setting_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SettingPageState {
  List<Location> get locations => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingPageStateCopyWith<SettingPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingPageStateCopyWith<$Res> {
  factory $SettingPageStateCopyWith(
          SettingPageState value, $Res Function(SettingPageState) then) =
      _$SettingPageStateCopyWithImpl<$Res, SettingPageState>;
  @useResult
  $Res call({List<Location> locations});
}

/// @nodoc
class _$SettingPageStateCopyWithImpl<$Res, $Val extends SettingPageState>
    implements $SettingPageStateCopyWith<$Res> {
  _$SettingPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locations = null,
  }) {
    return _then(_value.copyWith(
      locations: null == locations
          ? _value.locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<Location>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingPageStateImplCopyWith<$Res>
    implements $SettingPageStateCopyWith<$Res> {
  factory _$$SettingPageStateImplCopyWith(_$SettingPageStateImpl value,
          $Res Function(_$SettingPageStateImpl) then) =
      __$$SettingPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Location> locations});
}

/// @nodoc
class __$$SettingPageStateImplCopyWithImpl<$Res>
    extends _$SettingPageStateCopyWithImpl<$Res, _$SettingPageStateImpl>
    implements _$$SettingPageStateImplCopyWith<$Res> {
  __$$SettingPageStateImplCopyWithImpl(_$SettingPageStateImpl _value,
      $Res Function(_$SettingPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locations = null,
  }) {
    return _then(_$SettingPageStateImpl(
      locations: null == locations
          ? _value._locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<Location>,
    ));
  }
}

/// @nodoc

class _$SettingPageStateImpl implements _SettingPageState {
  const _$SettingPageStateImpl({final List<Location> locations = const []})
      : _locations = locations;

  final List<Location> _locations;
  @override
  @JsonKey()
  List<Location> get locations {
    if (_locations is EqualUnmodifiableListView) return _locations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locations);
  }

  @override
  String toString() {
    return 'SettingPageState(locations: $locations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingPageStateImpl &&
            const DeepCollectionEquality()
                .equals(other._locations, _locations));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_locations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingPageStateImplCopyWith<_$SettingPageStateImpl> get copyWith =>
      __$$SettingPageStateImplCopyWithImpl<_$SettingPageStateImpl>(
          this, _$identity);
}

abstract class _SettingPageState implements SettingPageState {
  const factory _SettingPageState({final List<Location> locations}) =
      _$SettingPageStateImpl;

  @override
  List<Location> get locations;
  @override
  @JsonKey(ignore: true)
  _$$SettingPageStateImplCopyWith<_$SettingPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
