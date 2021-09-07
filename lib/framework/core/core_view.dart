import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'core_behavior.dart';

abstract class CoreView<V extends CoreView<V, B, S>,
    B extends CoreBehavior<V, B, S>, S> extends StatelessWidget {
  B initBehavior();

  @override
  Widget build(BuildContext context) {
    B behavior = initBehavior();
    return GetBuilder<B>(
      init: behavior,
      builder: (B behavior) => WillPopScope(
          child: behavior.isBusy
              ? onLoadingView(context)
              : loadScreen(context, behavior, behavior.state),
          onWillPop: onWillPop),
    );
  }

  Future<bool> onWillPop() async => true;

  Widget loadScreen(BuildContext context, B behavior, S state);
  Widget onLoadingView(BuildContext context);
}

abstract class CoreChildView<V extends CoreView<V, B, S>,
    B extends CoreBehavior<V, B, S>, S> extends StatelessWidget {
  Widget loadScreen(BuildContext context, B behavior, S state);

  final B behavior = Get.find<B>();

  // specifify what to show when screen state is still not ready
  // this view will be rendered every time actions is busy
  Widget loadingViewBuilder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return behavior.isBusy
        ? loadingViewBuilder(context)
        : loadScreen(context, behavior, behavior.state);
  }
}
