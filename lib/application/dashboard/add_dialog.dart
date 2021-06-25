import 'package:egg_note/application/dashboard/dashboard_view.dart';
import 'package:egg_note/framework/core/core_view.dart';
import 'package:egg_note/framework/core/res/res_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';

class AddDialog
    extends CoreChildView<DashboardView, DashboardBehavior, DashboardData> {
  final _controller_amount = TextEditingController();

  @override
  Widget loadingViewBuilder(BuildContext context) => Container(
        color: Colors.white12,
        child: Center(
          child: SpinKitChasingDots(
            color: ResColor.primaryColor,
            size: 50.0,
          ),
        ),
      );

  @override
  Widget loadScreen(
      BuildContext context, DashboardBehavior behavior, DashboardData state) {
    return AlertDialog(
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Wrap(
            children: [
              Center(
                child: Text("Tambah Penjualan",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Butir",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() => behavior.changePickedItem(0));
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: state.itemPicked == 0
                                  ? Colors.greenAccent
                                  : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Icon(
                            LineIcons.egg,
                            size: 48,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Rak"),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() => behavior.changePickedItem(1));
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: state.itemPicked == 1
                                  ? Colors.greenAccent
                                  : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Icon(
                            LineIcons.database,
                            size: 48,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: 10,
              ),
              TextFormField(
                controller: _controller_amount,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Masukan jumlah',
                  labelStyle: TextStyle(color: Colors.black),
                  labelText: "Jumlah",
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.greenAccent, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12, width: 2.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    state.amount = int.parse(_controller_amount.text);
                    behavior.addItemSold();
                  },
                  child: const Text('Tambahkan'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
