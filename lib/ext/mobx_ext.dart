import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:newedok/a_observable_future/a_observable_future.dart';

extension WidgetExt on Widget {
  Widget get containerIfNull => this ?? Container(width: 0, height: 0,);
}

extension AObservableFutureExt<T> on AObservableFuture<T> {
  AObservableFuture<T> replaceOrCreate(Future<T> nextFuture) {
    return this == null ? AObservableFuture(nextFuture) : replace(nextFuture);
  }
}

extension FutureExt<T> on Future<T> {
  AObservableFuture<T> replaceObservableFuture(AObservableFuture<T> oldObservableFuture) {
    return oldObservableFuture.replaceOrCreate(this);
  }

  AObservableFuture<T> asObservableFuture() {
    return AObservableFuture<T>(this);
  }
}

extension FutureStatusExt on FutureStatus {
  bool get isPendingOrFulfilled =>
      [FutureStatus.fulfilled, FutureStatus.pending].contains(this);
}

extension ObservableListExt<T> on Iterable<T> {
  ObservableList<T> toObservableList() {
    return ObservableList.of(this);
  }
}