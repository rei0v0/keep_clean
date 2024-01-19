// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cleaning_list_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CleaningListPageState {
  List<Location> get locations => throw _privateConstructorUsedError;
  List<Task> get overdueTasks => throw _privateConstructorUsedError;
  List<Task> get todayTasks => throw _privateConstructorUsedError;
  List<Task> get tomorrowTasks => throw _privateConstructorUsedError;
  List<Task> get threeDaysTasks => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CleaningListPageStateCopyWith<CleaningListPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CleaningListPageStateCopyWith<$Res> {
  factory $CleaningListPageStateCopyWith(CleaningListPageState value,
          $Res Function(CleaningListPageState) then) =
      _$CleaningListPageStateCopyWithImpl<$Res, CleaningListPageState>;
  @useResult
  $Res call(
      {List<Location> locations,
      List<Task> overdueTasks,
      List<Task> todayTasks,
      List<Task> tomorrowTasks,
      List<Task> threeDaysTasks});
}

/// @nodoc
class _$CleaningListPageStateCopyWithImpl<$Res,
        $Val extends CleaningListPageState>
    implements $CleaningListPageStateCopyWith<$Res> {
  _$CleaningListPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locations = null,
    Object? overdueTasks = null,
    Object? todayTasks = null,
    Object? tomorrowTasks = null,
    Object? threeDaysTasks = null,
  }) {
    return _then(_value.copyWith(
      locations: null == locations
          ? _value.locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<Location>,
      overdueTasks: null == overdueTasks
          ? _value.overdueTasks
          : overdueTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      todayTasks: null == todayTasks
          ? _value.todayTasks
          : todayTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      tomorrowTasks: null == tomorrowTasks
          ? _value.tomorrowTasks
          : tomorrowTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      threeDaysTasks: null == threeDaysTasks
          ? _value.threeDaysTasks
          : threeDaysTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CleaningListPageStateImplCopyWith<$Res>
    implements $CleaningListPageStateCopyWith<$Res> {
  factory _$$CleaningListPageStateImplCopyWith(
          _$CleaningListPageStateImpl value,
          $Res Function(_$CleaningListPageStateImpl) then) =
      __$$CleaningListPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Location> locations,
      List<Task> overdueTasks,
      List<Task> todayTasks,
      List<Task> tomorrowTasks,
      List<Task> threeDaysTasks});
}

/// @nodoc
class __$$CleaningListPageStateImplCopyWithImpl<$Res>
    extends _$CleaningListPageStateCopyWithImpl<$Res,
        _$CleaningListPageStateImpl>
    implements _$$CleaningListPageStateImplCopyWith<$Res> {
  __$$CleaningListPageStateImplCopyWithImpl(_$CleaningListPageStateImpl _value,
      $Res Function(_$CleaningListPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locations = null,
    Object? overdueTasks = null,
    Object? todayTasks = null,
    Object? tomorrowTasks = null,
    Object? threeDaysTasks = null,
  }) {
    return _then(_$CleaningListPageStateImpl(
      locations: null == locations
          ? _value._locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<Location>,
      overdueTasks: null == overdueTasks
          ? _value._overdueTasks
          : overdueTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      todayTasks: null == todayTasks
          ? _value._todayTasks
          : todayTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      tomorrowTasks: null == tomorrowTasks
          ? _value._tomorrowTasks
          : tomorrowTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      threeDaysTasks: null == threeDaysTasks
          ? _value._threeDaysTasks
          : threeDaysTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
    ));
  }
}

/// @nodoc

class _$CleaningListPageStateImpl implements _CleaningListPageState {
  const _$CleaningListPageStateImpl(
      {final List<Location> locations = const [],
      final List<Task> overdueTasks = const [],
      final List<Task> todayTasks = const [],
      final List<Task> tomorrowTasks = const [],
      final List<Task> threeDaysTasks = const []})
      : _locations = locations,
        _overdueTasks = overdueTasks,
        _todayTasks = todayTasks,
        _tomorrowTasks = tomorrowTasks,
        _threeDaysTasks = threeDaysTasks;

  final List<Location> _locations;
  @override
  @JsonKey()
  List<Location> get locations {
    if (_locations is EqualUnmodifiableListView) return _locations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locations);
  }

  final List<Task> _overdueTasks;
  @override
  @JsonKey()
  List<Task> get overdueTasks {
    if (_overdueTasks is EqualUnmodifiableListView) return _overdueTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_overdueTasks);
  }

  final List<Task> _todayTasks;
  @override
  @JsonKey()
  List<Task> get todayTasks {
    if (_todayTasks is EqualUnmodifiableListView) return _todayTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todayTasks);
  }

  final List<Task> _tomorrowTasks;
  @override
  @JsonKey()
  List<Task> get tomorrowTasks {
    if (_tomorrowTasks is EqualUnmodifiableListView) return _tomorrowTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tomorrowTasks);
  }

  final List<Task> _threeDaysTasks;
  @override
  @JsonKey()
  List<Task> get threeDaysTasks {
    if (_threeDaysTasks is EqualUnmodifiableListView) return _threeDaysTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_threeDaysTasks);
  }

  @override
  String toString() {
    return 'CleaningListPageState(locations: $locations, overdueTasks: $overdueTasks, todayTasks: $todayTasks, tomorrowTasks: $tomorrowTasks, threeDaysTasks: $threeDaysTasks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CleaningListPageStateImpl &&
            const DeepCollectionEquality()
                .equals(other._locations, _locations) &&
            const DeepCollectionEquality()
                .equals(other._overdueTasks, _overdueTasks) &&
            const DeepCollectionEquality()
                .equals(other._todayTasks, _todayTasks) &&
            const DeepCollectionEquality()
                .equals(other._tomorrowTasks, _tomorrowTasks) &&
            const DeepCollectionEquality()
                .equals(other._threeDaysTasks, _threeDaysTasks));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_locations),
      const DeepCollectionEquality().hash(_overdueTasks),
      const DeepCollectionEquality().hash(_todayTasks),
      const DeepCollectionEquality().hash(_tomorrowTasks),
      const DeepCollectionEquality().hash(_threeDaysTasks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CleaningListPageStateImplCopyWith<_$CleaningListPageStateImpl>
      get copyWith => __$$CleaningListPageStateImplCopyWithImpl<
          _$CleaningListPageStateImpl>(this, _$identity);
}

abstract class _CleaningListPageState implements CleaningListPageState {
  const factory _CleaningListPageState(
      {final List<Location> locations,
      final List<Task> overdueTasks,
      final List<Task> todayTasks,
      final List<Task> tomorrowTasks,
      final List<Task> threeDaysTasks}) = _$CleaningListPageStateImpl;

  @override
  List<Location> get locations;
  @override
  List<Task> get overdueTasks;
  @override
  List<Task> get todayTasks;
  @override
  List<Task> get tomorrowTasks;
  @override
  List<Task> get threeDaysTasks;
  @override
  @JsonKey(ignore: true)
  _$$CleaningListPageStateImplCopyWith<_$CleaningListPageStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
