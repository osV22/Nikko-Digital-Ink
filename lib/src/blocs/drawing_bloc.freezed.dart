// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drawing_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DrawingEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Stroke stroke) strokeAdded,
    required TResult Function() processRequested,
    required TResult Function() clearRequested,
    required TResult Function() canvasClearRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Stroke stroke)? strokeAdded,
    TResult? Function()? processRequested,
    TResult? Function()? clearRequested,
    TResult? Function()? canvasClearRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Stroke stroke)? strokeAdded,
    TResult Function()? processRequested,
    TResult Function()? clearRequested,
    TResult Function()? canvasClearRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DrawingStrokeAdded value) strokeAdded,
    required TResult Function(DrawingProcessRequested value) processRequested,
    required TResult Function(DrawingClearRequested value) clearRequested,
    required TResult Function(DrawingCanvasClearRequested value)
    canvasClearRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DrawingStrokeAdded value)? strokeAdded,
    TResult? Function(DrawingProcessRequested value)? processRequested,
    TResult? Function(DrawingClearRequested value)? clearRequested,
    TResult? Function(DrawingCanvasClearRequested value)? canvasClearRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DrawingStrokeAdded value)? strokeAdded,
    TResult Function(DrawingProcessRequested value)? processRequested,
    TResult Function(DrawingClearRequested value)? clearRequested,
    TResult Function(DrawingCanvasClearRequested value)? canvasClearRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrawingEventCopyWith<$Res> {
  factory $DrawingEventCopyWith(
    DrawingEvent value,
    $Res Function(DrawingEvent) then,
  ) = _$DrawingEventCopyWithImpl<$Res, DrawingEvent>;
}

/// @nodoc
class _$DrawingEventCopyWithImpl<$Res, $Val extends DrawingEvent>
    implements $DrawingEventCopyWith<$Res> {
  _$DrawingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DrawingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$DrawingStrokeAddedImplCopyWith<$Res> {
  factory _$$DrawingStrokeAddedImplCopyWith(
    _$DrawingStrokeAddedImpl value,
    $Res Function(_$DrawingStrokeAddedImpl) then,
  ) = __$$DrawingStrokeAddedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Stroke stroke});
}

/// @nodoc
class __$$DrawingStrokeAddedImplCopyWithImpl<$Res>
    extends _$DrawingEventCopyWithImpl<$Res, _$DrawingStrokeAddedImpl>
    implements _$$DrawingStrokeAddedImplCopyWith<$Res> {
  __$$DrawingStrokeAddedImplCopyWithImpl(
    _$DrawingStrokeAddedImpl _value,
    $Res Function(_$DrawingStrokeAddedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DrawingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? stroke = null}) {
    return _then(
      _$DrawingStrokeAddedImpl(
        null == stroke
            ? _value.stroke
            : stroke // ignore: cast_nullable_to_non_nullable
                  as Stroke,
      ),
    );
  }
}

/// @nodoc

class _$DrawingStrokeAddedImpl implements DrawingStrokeAdded {
  const _$DrawingStrokeAddedImpl(this.stroke);

  @override
  final Stroke stroke;

  @override
  String toString() {
    return 'DrawingEvent.strokeAdded(stroke: $stroke)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawingStrokeAddedImpl &&
            (identical(other.stroke, stroke) || other.stroke == stroke));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stroke);

  /// Create a copy of DrawingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawingStrokeAddedImplCopyWith<_$DrawingStrokeAddedImpl> get copyWith =>
      __$$DrawingStrokeAddedImplCopyWithImpl<_$DrawingStrokeAddedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Stroke stroke) strokeAdded,
    required TResult Function() processRequested,
    required TResult Function() clearRequested,
    required TResult Function() canvasClearRequested,
  }) {
    return strokeAdded(stroke);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Stroke stroke)? strokeAdded,
    TResult? Function()? processRequested,
    TResult? Function()? clearRequested,
    TResult? Function()? canvasClearRequested,
  }) {
    return strokeAdded?.call(stroke);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Stroke stroke)? strokeAdded,
    TResult Function()? processRequested,
    TResult Function()? clearRequested,
    TResult Function()? canvasClearRequested,
    required TResult orElse(),
  }) {
    if (strokeAdded != null) {
      return strokeAdded(stroke);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DrawingStrokeAdded value) strokeAdded,
    required TResult Function(DrawingProcessRequested value) processRequested,
    required TResult Function(DrawingClearRequested value) clearRequested,
    required TResult Function(DrawingCanvasClearRequested value)
    canvasClearRequested,
  }) {
    return strokeAdded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DrawingStrokeAdded value)? strokeAdded,
    TResult? Function(DrawingProcessRequested value)? processRequested,
    TResult? Function(DrawingClearRequested value)? clearRequested,
    TResult? Function(DrawingCanvasClearRequested value)? canvasClearRequested,
  }) {
    return strokeAdded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DrawingStrokeAdded value)? strokeAdded,
    TResult Function(DrawingProcessRequested value)? processRequested,
    TResult Function(DrawingClearRequested value)? clearRequested,
    TResult Function(DrawingCanvasClearRequested value)? canvasClearRequested,
    required TResult orElse(),
  }) {
    if (strokeAdded != null) {
      return strokeAdded(this);
    }
    return orElse();
  }
}

abstract class DrawingStrokeAdded implements DrawingEvent {
  const factory DrawingStrokeAdded(final Stroke stroke) =
      _$DrawingStrokeAddedImpl;

  Stroke get stroke;

  /// Create a copy of DrawingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawingStrokeAddedImplCopyWith<_$DrawingStrokeAddedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DrawingProcessRequestedImplCopyWith<$Res> {
  factory _$$DrawingProcessRequestedImplCopyWith(
    _$DrawingProcessRequestedImpl value,
    $Res Function(_$DrawingProcessRequestedImpl) then,
  ) = __$$DrawingProcessRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DrawingProcessRequestedImplCopyWithImpl<$Res>
    extends _$DrawingEventCopyWithImpl<$Res, _$DrawingProcessRequestedImpl>
    implements _$$DrawingProcessRequestedImplCopyWith<$Res> {
  __$$DrawingProcessRequestedImplCopyWithImpl(
    _$DrawingProcessRequestedImpl _value,
    $Res Function(_$DrawingProcessRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DrawingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DrawingProcessRequestedImpl implements DrawingProcessRequested {
  const _$DrawingProcessRequestedImpl();

  @override
  String toString() {
    return 'DrawingEvent.processRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawingProcessRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Stroke stroke) strokeAdded,
    required TResult Function() processRequested,
    required TResult Function() clearRequested,
    required TResult Function() canvasClearRequested,
  }) {
    return processRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Stroke stroke)? strokeAdded,
    TResult? Function()? processRequested,
    TResult? Function()? clearRequested,
    TResult? Function()? canvasClearRequested,
  }) {
    return processRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Stroke stroke)? strokeAdded,
    TResult Function()? processRequested,
    TResult Function()? clearRequested,
    TResult Function()? canvasClearRequested,
    required TResult orElse(),
  }) {
    if (processRequested != null) {
      return processRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DrawingStrokeAdded value) strokeAdded,
    required TResult Function(DrawingProcessRequested value) processRequested,
    required TResult Function(DrawingClearRequested value) clearRequested,
    required TResult Function(DrawingCanvasClearRequested value)
    canvasClearRequested,
  }) {
    return processRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DrawingStrokeAdded value)? strokeAdded,
    TResult? Function(DrawingProcessRequested value)? processRequested,
    TResult? Function(DrawingClearRequested value)? clearRequested,
    TResult? Function(DrawingCanvasClearRequested value)? canvasClearRequested,
  }) {
    return processRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DrawingStrokeAdded value)? strokeAdded,
    TResult Function(DrawingProcessRequested value)? processRequested,
    TResult Function(DrawingClearRequested value)? clearRequested,
    TResult Function(DrawingCanvasClearRequested value)? canvasClearRequested,
    required TResult orElse(),
  }) {
    if (processRequested != null) {
      return processRequested(this);
    }
    return orElse();
  }
}

abstract class DrawingProcessRequested implements DrawingEvent {
  const factory DrawingProcessRequested() = _$DrawingProcessRequestedImpl;
}

/// @nodoc
abstract class _$$DrawingClearRequestedImplCopyWith<$Res> {
  factory _$$DrawingClearRequestedImplCopyWith(
    _$DrawingClearRequestedImpl value,
    $Res Function(_$DrawingClearRequestedImpl) then,
  ) = __$$DrawingClearRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DrawingClearRequestedImplCopyWithImpl<$Res>
    extends _$DrawingEventCopyWithImpl<$Res, _$DrawingClearRequestedImpl>
    implements _$$DrawingClearRequestedImplCopyWith<$Res> {
  __$$DrawingClearRequestedImplCopyWithImpl(
    _$DrawingClearRequestedImpl _value,
    $Res Function(_$DrawingClearRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DrawingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DrawingClearRequestedImpl implements DrawingClearRequested {
  const _$DrawingClearRequestedImpl();

  @override
  String toString() {
    return 'DrawingEvent.clearRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawingClearRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Stroke stroke) strokeAdded,
    required TResult Function() processRequested,
    required TResult Function() clearRequested,
    required TResult Function() canvasClearRequested,
  }) {
    return clearRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Stroke stroke)? strokeAdded,
    TResult? Function()? processRequested,
    TResult? Function()? clearRequested,
    TResult? Function()? canvasClearRequested,
  }) {
    return clearRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Stroke stroke)? strokeAdded,
    TResult Function()? processRequested,
    TResult Function()? clearRequested,
    TResult Function()? canvasClearRequested,
    required TResult orElse(),
  }) {
    if (clearRequested != null) {
      return clearRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DrawingStrokeAdded value) strokeAdded,
    required TResult Function(DrawingProcessRequested value) processRequested,
    required TResult Function(DrawingClearRequested value) clearRequested,
    required TResult Function(DrawingCanvasClearRequested value)
    canvasClearRequested,
  }) {
    return clearRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DrawingStrokeAdded value)? strokeAdded,
    TResult? Function(DrawingProcessRequested value)? processRequested,
    TResult? Function(DrawingClearRequested value)? clearRequested,
    TResult? Function(DrawingCanvasClearRequested value)? canvasClearRequested,
  }) {
    return clearRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DrawingStrokeAdded value)? strokeAdded,
    TResult Function(DrawingProcessRequested value)? processRequested,
    TResult Function(DrawingClearRequested value)? clearRequested,
    TResult Function(DrawingCanvasClearRequested value)? canvasClearRequested,
    required TResult orElse(),
  }) {
    if (clearRequested != null) {
      return clearRequested(this);
    }
    return orElse();
  }
}

abstract class DrawingClearRequested implements DrawingEvent {
  const factory DrawingClearRequested() = _$DrawingClearRequestedImpl;
}

/// @nodoc
abstract class _$$DrawingCanvasClearRequestedImplCopyWith<$Res> {
  factory _$$DrawingCanvasClearRequestedImplCopyWith(
    _$DrawingCanvasClearRequestedImpl value,
    $Res Function(_$DrawingCanvasClearRequestedImpl) then,
  ) = __$$DrawingCanvasClearRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DrawingCanvasClearRequestedImplCopyWithImpl<$Res>
    extends _$DrawingEventCopyWithImpl<$Res, _$DrawingCanvasClearRequestedImpl>
    implements _$$DrawingCanvasClearRequestedImplCopyWith<$Res> {
  __$$DrawingCanvasClearRequestedImplCopyWithImpl(
    _$DrawingCanvasClearRequestedImpl _value,
    $Res Function(_$DrawingCanvasClearRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DrawingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DrawingCanvasClearRequestedImpl implements DrawingCanvasClearRequested {
  const _$DrawingCanvasClearRequestedImpl();

  @override
  String toString() {
    return 'DrawingEvent.canvasClearRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawingCanvasClearRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Stroke stroke) strokeAdded,
    required TResult Function() processRequested,
    required TResult Function() clearRequested,
    required TResult Function() canvasClearRequested,
  }) {
    return canvasClearRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Stroke stroke)? strokeAdded,
    TResult? Function()? processRequested,
    TResult? Function()? clearRequested,
    TResult? Function()? canvasClearRequested,
  }) {
    return canvasClearRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Stroke stroke)? strokeAdded,
    TResult Function()? processRequested,
    TResult Function()? clearRequested,
    TResult Function()? canvasClearRequested,
    required TResult orElse(),
  }) {
    if (canvasClearRequested != null) {
      return canvasClearRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DrawingStrokeAdded value) strokeAdded,
    required TResult Function(DrawingProcessRequested value) processRequested,
    required TResult Function(DrawingClearRequested value) clearRequested,
    required TResult Function(DrawingCanvasClearRequested value)
    canvasClearRequested,
  }) {
    return canvasClearRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DrawingStrokeAdded value)? strokeAdded,
    TResult? Function(DrawingProcessRequested value)? processRequested,
    TResult? Function(DrawingClearRequested value)? clearRequested,
    TResult? Function(DrawingCanvasClearRequested value)? canvasClearRequested,
  }) {
    return canvasClearRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DrawingStrokeAdded value)? strokeAdded,
    TResult Function(DrawingProcessRequested value)? processRequested,
    TResult Function(DrawingClearRequested value)? clearRequested,
    TResult Function(DrawingCanvasClearRequested value)? canvasClearRequested,
    required TResult orElse(),
  }) {
    if (canvasClearRequested != null) {
      return canvasClearRequested(this);
    }
    return orElse();
  }
}

abstract class DrawingCanvasClearRequested implements DrawingEvent {
  const factory DrawingCanvasClearRequested() =
      _$DrawingCanvasClearRequestedImpl;
}

/// @nodoc
mixin _$DrawingState {
  List<Stroke> get strokes => throw _privateConstructorUsedError;
  String get recognizedText => throw _privateConstructorUsedError;
  bool get isRecognizing => throw _privateConstructorUsedError;
  bool get shouldClearCanvas => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of DrawingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DrawingStateCopyWith<DrawingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrawingStateCopyWith<$Res> {
  factory $DrawingStateCopyWith(
    DrawingState value,
    $Res Function(DrawingState) then,
  ) = _$DrawingStateCopyWithImpl<$Res, DrawingState>;
  @useResult
  $Res call({
    List<Stroke> strokes,
    String recognizedText,
    bool isRecognizing,
    bool shouldClearCanvas,
    String? errorMessage,
  });
}

/// @nodoc
class _$DrawingStateCopyWithImpl<$Res, $Val extends DrawingState>
    implements $DrawingStateCopyWith<$Res> {
  _$DrawingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DrawingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strokes = null,
    Object? recognizedText = null,
    Object? isRecognizing = null,
    Object? shouldClearCanvas = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            strokes: null == strokes
                ? _value.strokes
                : strokes // ignore: cast_nullable_to_non_nullable
                      as List<Stroke>,
            recognizedText: null == recognizedText
                ? _value.recognizedText
                : recognizedText // ignore: cast_nullable_to_non_nullable
                      as String,
            isRecognizing: null == isRecognizing
                ? _value.isRecognizing
                : isRecognizing // ignore: cast_nullable_to_non_nullable
                      as bool,
            shouldClearCanvas: null == shouldClearCanvas
                ? _value.shouldClearCanvas
                : shouldClearCanvas // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DrawingStateImplCopyWith<$Res>
    implements $DrawingStateCopyWith<$Res> {
  factory _$$DrawingStateImplCopyWith(
    _$DrawingStateImpl value,
    $Res Function(_$DrawingStateImpl) then,
  ) = __$$DrawingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Stroke> strokes,
    String recognizedText,
    bool isRecognizing,
    bool shouldClearCanvas,
    String? errorMessage,
  });
}

/// @nodoc
class __$$DrawingStateImplCopyWithImpl<$Res>
    extends _$DrawingStateCopyWithImpl<$Res, _$DrawingStateImpl>
    implements _$$DrawingStateImplCopyWith<$Res> {
  __$$DrawingStateImplCopyWithImpl(
    _$DrawingStateImpl _value,
    $Res Function(_$DrawingStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DrawingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strokes = null,
    Object? recognizedText = null,
    Object? isRecognizing = null,
    Object? shouldClearCanvas = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$DrawingStateImpl(
        strokes: null == strokes
            ? _value._strokes
            : strokes // ignore: cast_nullable_to_non_nullable
                  as List<Stroke>,
        recognizedText: null == recognizedText
            ? _value.recognizedText
            : recognizedText // ignore: cast_nullable_to_non_nullable
                  as String,
        isRecognizing: null == isRecognizing
            ? _value.isRecognizing
            : isRecognizing // ignore: cast_nullable_to_non_nullable
                  as bool,
        shouldClearCanvas: null == shouldClearCanvas
            ? _value.shouldClearCanvas
            : shouldClearCanvas // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$DrawingStateImpl implements _DrawingState {
  const _$DrawingStateImpl({
    final List<Stroke> strokes = const [],
    this.recognizedText = '',
    this.isRecognizing = false,
    this.shouldClearCanvas = false,
    this.errorMessage,
  }) : _strokes = strokes;

  final List<Stroke> _strokes;
  @override
  @JsonKey()
  List<Stroke> get strokes {
    if (_strokes is EqualUnmodifiableListView) return _strokes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_strokes);
  }

  @override
  @JsonKey()
  final String recognizedText;
  @override
  @JsonKey()
  final bool isRecognizing;
  @override
  @JsonKey()
  final bool shouldClearCanvas;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'DrawingState(strokes: $strokes, recognizedText: $recognizedText, isRecognizing: $isRecognizing, shouldClearCanvas: $shouldClearCanvas, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawingStateImpl &&
            const DeepCollectionEquality().equals(other._strokes, _strokes) &&
            (identical(other.recognizedText, recognizedText) ||
                other.recognizedText == recognizedText) &&
            (identical(other.isRecognizing, isRecognizing) ||
                other.isRecognizing == isRecognizing) &&
            (identical(other.shouldClearCanvas, shouldClearCanvas) ||
                other.shouldClearCanvas == shouldClearCanvas) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_strokes),
    recognizedText,
    isRecognizing,
    shouldClearCanvas,
    errorMessage,
  );

  /// Create a copy of DrawingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawingStateImplCopyWith<_$DrawingStateImpl> get copyWith =>
      __$$DrawingStateImplCopyWithImpl<_$DrawingStateImpl>(this, _$identity);
}

abstract class _DrawingState implements DrawingState {
  const factory _DrawingState({
    final List<Stroke> strokes,
    final String recognizedText,
    final bool isRecognizing,
    final bool shouldClearCanvas,
    final String? errorMessage,
  }) = _$DrawingStateImpl;

  @override
  List<Stroke> get strokes;
  @override
  String get recognizedText;
  @override
  bool get isRecognizing;
  @override
  bool get shouldClearCanvas;
  @override
  String? get errorMessage;

  /// Create a copy of DrawingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawingStateImplCopyWith<_$DrawingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
