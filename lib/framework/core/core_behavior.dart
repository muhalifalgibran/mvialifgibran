import 'package:egg_note/framework/core/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core_view.dart';

abstract class CoreBehavior<V extends CoreView<V, B, S>,
    B extends CoreBehavior<V, B, S>, S> extends GetxController {
  S state;
  bool isBusy = true;

  final Debouncer reloadDbn = Debouncer(Duration(milliseconds: 1));
  final Debouncer renderDbn = Debouncer(Duration(milliseconds: 1));

  Future refreshScreen() async {
    await reloadDbn.runLastFuture(() => onReady());
  }

  Future<S> initState();

  Future reloadScreen() async {
    await reloadDbn.runLastFuture(() => onReady());
  }

  /// render will only be called once after 300ms has passed
  @protected
  void render() {
    if (state != null) renderDbn.runLastCall(() => update());
  }

  Future<bool> onWillPop() async => true;

  @override
  Future<void> onReady() async {
    if (!isBusy) {
      // make sure to change isBusy state if it alredy false before
      isBusy = true;
      render();
    }

    state = await initState();
    isBusy = false;

    render();
  }
}
