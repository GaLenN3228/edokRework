import 'dart:async';


import 'package:mobx/mobx.dart';

class AFutureResult<T> {

  AFutureResult(
      ReactiveContext context,
      Future<T> _future,
      T initialResult,
      dynamic initialError,
      FutureStatus initialStatus, String name
  ) : _axnController = ActionController(
        context: context,
        name: '$name.ActionController'
      ),
      _status = Observable(initialStatus, name: '$name.status'),
      _result = Observable(initialResult, name: '$name.result'),
      _errorResult = Observable<dynamic>(initialError, name: '$name.errorResult') {
      _future.then(_fulfill, onError: _reject);
  }

  final ActionController _axnController;

  final Observable<FutureStatus> _status;
  FutureStatus get status => _status.value;

  final Observable<T> _result;
  T get result => _result.value;

  final Observable<dynamic> _errorResult;
  dynamic get errorResult => _errorResult.value;

  void _fulfill(T value) {
    final prevDerivation = _axnController.startAction();
    try {
      _status.value = FutureStatus.fulfilled;
      _result.value = value;
      _errorResult.value = null;
    } finally {
      _axnController.endAction(prevDerivation);
    }
  }

  void _reject(dynamic error) {
    final prevDerivation = _axnController.startAction();
    try {
      _status.value = FutureStatus.rejected;
      _errorResult.value = error;
    } finally {
      _axnController.endAction(prevDerivation);
    }
  }
}

class AObservableFuture<T> implements Future<T>, ObservableValue<T> {

  /// Create a new observable future that tracks the state of the provided future.
  AObservableFuture(Future<T> future, {
    ReactiveContext context, String name
  }) : this._(context ?? mainContext, future, FutureStatus.pending, null, null, name);

  /// Create a new future that is completed with a value.
  ///
  /// [status] is immediately [FutureStatus.fulfilled].
  AObservableFuture.value(T value, {ReactiveContext context, String name})
      : this._(context ?? mainContext, Future.value(value),
      FutureStatus.fulfilled, value, null, name);

  /// Create a new future that is completed with an error.
  ///
  /// [status] is immediately [FutureStatus.rejected].
  AObservableFuture.error(dynamic error, {ReactiveContext context, String name})
      : this._(context ?? mainContext, Future.error(error),
      FutureStatus.rejected, null, error, name);

  AObservableFuture._(this._context, this._future, this._initialStatus,
      this._initialResult, this._initialError, String name) {
    _name = name ?? _context.nameFor('ObservableFuture<$T>');

    // create the result up-front instead of being lazy
    _result = AFutureResult(
      _context, _future, _initialResult, _initialError, _initialStatus, _name
    );

    _initialResult = null;
    _initialError = null;
    _initialStatus = null;
  }

  final ReactiveContext _context;
  Future<T> _future;
  FutureStatus _initialStatus;
  T _initialResult;
  dynamic _initialError;

  AFutureResult<T> _result;

  String _name;
  String get name => _name;

  /// Observable status of this.
  FutureStatus get status => _result.status;

  /// Value if this completed with a value.
  ///
  /// Null otherwise.
  @override
  T get value => _result.result;

  /// Error value if this completed with an error
  ///
  /// Null otherwise.
  dynamic get error => status == FutureStatus.rejected ? _result.errorResult : null;

  /// Maps the current state of this.
  ///
  /// Returns null if a handler for the current state is not provided.
  R matchStatus<R>({
    R Function(T value) fulfilled,
    R Function(T value, dynamic error) rejected,
    R Function(T value) pending
  }) {
    final status = this.status;

    if (status == FutureStatus.fulfilled) {
      return fulfilled == null ? null : fulfilled(value);
    } else if (status == FutureStatus.rejected) {
      return rejected == null ? null : rejected(value, error);
    }
    return pending == null ? null : pending(value);
  }

  R matchValue<R>({
    R Function(T value) hasValue,
    R Function() pending,
    R Function(dynamic error) rejected,
  }) {
    final status = this.status;

    if(value != null) {
      return hasValue == null ? null : hasValue(value);
    }else if(status == FutureStatus.rejected) {
      return rejected == null ? null : rejected(error);
    }
    return pending == null ? null : pending();
  }

  /// Returns a new future that starts with the [status] and [result] of this.
  ///
  /// The [status] and [result] changes when the provided future completes.
  /// Useful when you don't want to clear the result of the previous operation while
  /// executing the new operation.
  AObservableFuture<T> replace(Future<T> nextFuture) =>
      AObservableFuture<T>._(_context, nextFuture, FutureStatus.pending, value, null, name);

  @override
  AObservableFuture<T> catchError(Function onError,
      {bool Function(Object error) test}) =>
      AObservableFuture._(_context, _future.catchError(onError, test: test),
          FutureStatus.pending, null, null, name);

  @override
  AObservableFuture<R> then<R>(FutureOr<R> Function(T value) onValue,
      {Function onError}) =>
      AObservableFuture._(_context, _future.then(onValue, onError: onError),
          FutureStatus.pending, null, null, name);

  @override
  AObservableFuture<T> timeout(Duration timeLimit,
      {FutureOr<T> Function() onTimeout}) =>
      AObservableFuture._(
          _context,
          _future.timeout(timeLimit, onTimeout: onTimeout),
          FutureStatus.pending,
          null,
          null,
          name);

  @override
  AObservableFuture<T> whenComplete(FutureOr Function() action) =>
      AObservableFuture._(_context, _future.whenComplete(action),
          FutureStatus.pending, null, null, name);

  @override
  ObservableStream<T> asStream() => ObservableStream(
      _future.asStream(),
      initialValue: value,
      cancelOnError: false,
      context: _context,
      name: '${name}_asStream');

  AObservableFuture<R> copyWithValue<R>(R value(AObservableFuture<T> observableFuture), {String name}) {
    final newValue = value(this);
    return AObservableFuture<R>._(_context, _future.then((_) => newValue),
        status, newValue, error, name);
  }

}