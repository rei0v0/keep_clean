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
  bool get closeTopContainer => throw _privateConstructorUsedError;
  double get topContainer => throw _privateConstructorUsedError;
  double get position => throw _privateConstructorUsedError;

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
  $Res call({bool closeTopContainer, double topContainer, double position});
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
    Object? closeTopContainer = null,
    Object? topContainer = null,
    Object? position = null,
  }) {
    return _then(_value.copyWith(
      closeTopContainer: null == closeTopContainer
          ? _value.closeTopContainer
          : closeTopContainer // ignore: cast_nullable_to_non_nullable
              as bool,
      topContainer: null == topContainer
          ? _value.topContainer
          : topContainer // ignore: cast_nullable_to_non_nullable
              as double,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as double,
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
  $Res call({bool closeTopContainer, double topContainer, double position});
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
    Object? closeTopContainer = null,
    Object? topContainer = null,
    Object? position = null,
  }) {
    return _then(_$CleaningListPageStateImpl(
      closeTopContainer: null == closeTopContainer
          ? _value.closeTopContainer
          : closeTopContainer // ignore: cast_nullable_to_non_nullable
              as bool,
      topContainer: null == topContainer
          ? _value.topContainer
          : topContainer // ignore: cast_nullable_to_non_nullable
              as double,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$CleaningListPageStateImpl implements _CleaningListPageState {
  const _$CleaningListPageStateImpl(
      {this.closeTopContainer = false,
      this.topContainer = 0.0,
      this.position = 0.0});

  @override
  @JsonKey()
  final bool closeTopContainer;
  @override
  @JsonKey()
  final double topContainer;
  @override
  @JsonKey()
  final double position;

  @override
  String toString() {
    return 'CleaningListPageState(closeTopContainer: $closeTopContainer, topContainer: $topContainer, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CleaningListPageStateImpl &&
            (identical(other.closeTopContainer, closeTopContainer) ||
                other.closeTopContainer == closeTopContainer) &&
            (identical(other.topContainer, topContainer) ||
                other.topContainer == topContainer) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, closeTopContainer, topContainer, position);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CleaningListPageStateImplCopyWith<_$CleaningListPageStateImpl>
      get copyWith => __$$CleaningListPageStateImplCopyWithImpl<
          _$CleaningListPageStateImpl>(this, _$identity);
}

abstract class _CleaningListPageState implements CleaningListPageState {
  const factory _CleaningListPageState(
      {final bool closeTopContainer,
      final double topContainer,
      final double position}) = _$CleaningListPageStateImpl;

  @override
  bool get closeTopContainer;
  @override
  double get topContainer;
  @override
  double get position;
  @override
  @JsonKey(ignore: true)
  _$$CleaningListPageStateImplCopyWith<_$CleaningListPageStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
