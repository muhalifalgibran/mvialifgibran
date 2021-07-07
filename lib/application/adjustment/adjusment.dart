import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egg_note/framework/core/core_behavior.dart';
import 'package:egg_note/framework/core/core_view.dart';
import 'package:egg_note/framework/network/firebase/prices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_icons/line_icons.dart';

class AdjustmentData {
  int grain;
  int rack;
  bool isFocus = true;
  AdjustmentData(this.grain, this.rack, {this.isFocus});
}

class AdjustmentBehavior
    extends CoreBehavior<AdjusmentView, AdjustmentBehavior, AdjustmentData> {
  final prices = Get.find<Prices>();
  int _grain;
  int _rack;
  GetStorage box = GetStorage();

  @override
  Future<AdjustmentData> initState() async {
    await prices.getPrices().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _rack = doc["rack"];
        _grain = doc["grain"];
      });
    });
    box.write('rack', _rack);
    box.write('grain', _grain);
    return AdjustmentData(_grain, _rack, isFocus: true);
  }

  void changeFocus(bool f) {
    state.isFocus = f;
    render();
  }

  void changeFocusAndSaveData(bool f, int grain, int rack) async {
    state.isFocus = f;
    state.grain = grain;
    state.rack = rack;

    await prices.setPrices(grain, rack);
    render();
  }
}

class AdjusmentView
    extends CoreView<AdjusmentView, AdjustmentBehavior, AdjustmentData> {
  final _controller_grain = TextEditingController();
  final _controller_rack = TextEditingController();

  @override
  AdjustmentBehavior initBehavior() {
    return AdjustmentBehavior();
  }

  @override
  Widget loadScreen(
      BuildContext context, AdjustmentBehavior behavior, AdjustmentData state) {
    _controller_grain.text = state.grain.toString();
    _controller_rack.text = state.rack.toString();
    print(state.rack.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Catat Telur"),
        actions: [
          GestureDetector(
            child: Icon(LineIcons.edit),
            onTap: () => behavior.changeFocus(!state.isFocus),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextFormField(
                  readOnly: state.isFocus == null ? true : state.isFocus,
                  controller: _controller_grain,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Butir',
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: "Harga per-butir",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 1.0),
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
                  readOnly: state.isFocus == null ? true : state.isFocus,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Masukan jumlah',
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: "Rak",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 2.0),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: state.isFocus == null ? !true : !state.isFocus,
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  behavior.changeFocusAndSaveData(
                      !state.isFocus,
                      int.parse(_controller_grain.text),
                      int.parse(_controller_rack.text));
                },
                child: Text('Simpan'),
              ),
            )
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
