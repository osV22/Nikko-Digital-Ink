// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drawing_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DrawingSettings {
  double get strokeWidth => throw _privateConstructorUsedError;
  Color get strokeColor => throw _privateConstructorUsedError;

  /// Create a copy of DrawingSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DrawingSettingsCopyWith<DrawingSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrawingSettingsCopyWith<$Res> {
  factory $DrawingSettingsCopyWith(
    DrawingSettings value,
    $Res Function(DrawingSettings) then,
  ) = _$DrawingSettingsCopyWithImpl<$Res, DrawingSettings>;
  @useResult
  $Res call({double strokeWidth, Color strokeColor});
}

/// @nodoc
class _$DrawingSettingsCopyWithImpl<$Res, $Val extends DrawingSettings>
    implements $DrawingSettingsCopyWith<$Res> {
  _$DrawingSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DrawingSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? strokeWidth = null, Object? strokeColor = null}) {
    return _then(
      _value.copyWith(
            strokeWidth: null == strokeWidth
                ? _value.strokeWidth
                : strokeWidth // ignore: cast_nullable_to_non_nullable
                      as double,
            strokeColor: null == strokeColor
                ? _value.strokeColor
                : strokeColor // ignore: cast_nullable_to_non_nullable
                      as Color,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DrawingSettingsImplCopyWith<$Res>
    implements $DrawingSettingsCopyWith<$Res> {
  factory _$$DrawingSettingsImplCopyWith(
    _$DrawingSettingsImpl value,
    $Res Function(_$DrawingSettingsImpl) then,
  ) = __$$DrawingSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double strokeWidth, Color strokeColor});
}

/// @nodoc
class __$$DrawingSettingsImplCopyWithImpl<$Res>
    extends _$DrawingSettingsCopyWithImpl<$Res, _$DrawingSettingsImpl>
    implements _$$DrawingSettingsImplCopyWith<$Res> {
  __$$DrawingSettingsImplCopyWithImpl(
    _$DrawingSettingsImpl _value,
    $Res Function(_$DrawingSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DrawingSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? strokeWidth = null, Object? strokeColor = null}) {
    return _then(
      _$DrawingSettingsImpl(
        strokeWidth: null == strokeWidth
            ? _value.strokeWidth
            : strokeWidth // ignore: cast_nullable_to_non_nullable
                  as double,
        strokeColor: null == strokeColor
            ? _value.strokeColor
            : strokeColor // ignore: cast_nullable_to_non_nullable
                  as Color,
      ),
    );
  }
}

/// @nodoc

class _$DrawingSettingsImpl implements _DrawingSettings {
  const _$DrawingSettingsImpl({
    this.strokeWidth = 4.0,
    this.strokeColor = const Color(0xFF000000),
  });

  @override
  @JsonKey()
  final double strokeWidth;
  @override
  @JsonKey()
  final Color strokeColor;

  @override
  String toString() {
    return 'DrawingSettings(strokeWidth: $strokeWidth, strokeColor: $strokeColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawingSettingsImpl &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth) &&
            (identical(other.strokeColor, strokeColor) ||
                other.strokeColor == strokeColor));
  }

  @override
  int get hashCode => Object.hash(runtimeType, strokeWidth, strokeColor);

  /// Create a copy of DrawingSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawingSettingsImplCopyWith<_$DrawingSettingsImpl> get copyWith =>
      __$$DrawingSettingsImplCopyWithImpl<_$DrawingSettingsImpl>(
        this,
        _$identity,
      );
}

abstract class _DrawingSettings implements DrawingSettings {
  const factory _DrawingSettings({
    final double strokeWidth,
    final Color strokeColor,
  }) = _$DrawingSettingsImpl;

  @override
  double get strokeWidth;
  @override
  Color get strokeColor;

  /// Create a copy of DrawingSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawingSettingsImplCopyWith<_$DrawingSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
