import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egg_note/application/dashboard/add_dialog.dart';
import 'package:egg_note/framework/core/core_behavior.dart';
import 'package:egg_note/framework/core/core_view.dart';
import 'package:egg_note/framework/core/res/res_color.dart';
import 'package:egg_note/framework/network/firebase/items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class DashboardData {
  int itemPicked;
  int amount;
}

class DashboardBehavior
    extends CoreBehavior<DashboardView, DashboardBehavior, DashboardData> {
  final itemsRepo = Get.find<Items>();
  @override
  Future<DashboardData> initState() async {
    return DashboardData();
  }

  void changePickedItem(index) {
    state.itemPicked = index;
    render();
  }

  Future<void> addItemSold() async {
    await itemsRepo.addSoldItem(state.itemPicked, state.amount);
  }

  Stream<QuerySnapshot<Object>> streamItems() {
    return itemsRepo.streamItem();
  }
}

class DashboardView
    extends CoreView<DashboardView, DashboardBehavior, DashboardData> {
  @override
  DashboardBehavior initBehavior() {
    return DashboardBehavior();
  }

  @override
  Widget loadScreen(
      BuildContext context, DashboardBehavior behavior, DashboardData state) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: ResColor.appBackground,
          child: StreamBuilder<QuerySnapshot>(
            stream: behavior.streamItems(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loadingListShimmer();
              }

              return new ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  double harga = 0;
                  if (data['pickedItem'] == 0) {
                    harga = data['amount'] * 2500.0;
                  } else {
                    harga = data['amount'] * 450000.0;
                  }
                  FlutterMoneyFormatter fmf =
                      FlutterMoneyFormatter(amount: harga);
                  return new Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          data['pickedItem'] == 0
                              ? Icon(LineIcons.egg, size: 48.0)
                              : Icon(LineIcons.database, size: 48.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text("Jumlah: "),
                                  Text(data['amount'].toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Rp: "),
                                  Text(fmf.output.nonSymbol.toString()),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AddDialog();
              });
        },
        child: Icon(LineIcons.egg),
      ),
    );
  }

  @override
  Widget onLoadingView(BuildContext context) {
    return loadingListShimmer();
  }

  Widget loadingListShimmer() {
    return ListView(
      children: [for (var i = 0; i <= 10; i++) ListTileShimmer()],
    );
  }
}
