import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egg_note/framework/core/core_behavior.dart';
import 'package:egg_note/framework/core/core_view.dart';
import 'package:egg_note/framework/network/firebase/prices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AdjustmentData {
  final int grain;
  final int rack;
  AdjustmentData(this.grain, this.rack);
}

class AdjustmentBehavior
    extends CoreBehavior<AdjusmentView, AdjustmentBehavior, AdjustmentData> {
  final prices = Get.find<Prices>();
  int _grain;
  int _rack;

  @override
  Future<AdjustmentData> initState() async {
    await prices.setPrices().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _rack = doc["rack"];
        _grain = doc["grain"];
        print(_rack);
      });
    });
    return AdjustmentData(_grain, _rack);
  }
}

class AdjusmentView
    extends CoreView<AdjusmentView, AdjustmentBehavior, AdjustmentData> {
  final _controller_grain = TextEditingController();
  final _controller_rack = TextEditingController();

  @override
  AdjustmentBehavior initBehavior() {
    print("a");
    return AdjustmentBehavior();
  }

  @override
  Widget loadScreen(
      BuildContext context, AdjustmentBehavior behavior, AdjustmentData state) {
    _controller_grain.text = state.grain.toString();
    _controller_rack.text = state.rack.toString();
    print(state.rack.toString());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              readOnly: true,
              controller: _controller_grain,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Butir',
                labelStyle: TextStyle(color: Colors.black),
                labelText: "Harga per-butir",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 2.0),
                ),
              ),
            ),
            SizedBox(
              height: 14.0,
            ),
            TextFormField(
              controller: _controller_rack,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Masukan jumlah',
                labelStyle: TextStyle(color: Colors.black),
                labelText: "Rak",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 2.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget onLoadingView(BuildContext context) {
    return Container();
  }
}
