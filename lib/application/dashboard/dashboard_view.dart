import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egg_note/application/dashboard/add_dialog.dart';
import 'package:egg_note/framework/core/core_behavior.dart';
import 'package:egg_note/framework/core/core_view.dart';
import 'package:egg_note/framework/impl_repositories/firebase_item_repository.dart';
import 'package:egg_note/framework/network/firebase/items.dart';
import 'package:egg_note/framework/models/item.dart';
import 'package:egg_note/framework/repositories/itemRepository.dart';
import 'package:egg_note/framework/res/res_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_icons/line_icons.dart';

class DashboardData {
  int itemPicked;
  int amount;
  List<Item> itemList;
  Item item;

  DashboardData({this.itemPicked, this.amount, this.itemList, this.item});
}

class DashboardBehavior
    extends CoreBehavior<DashboardView, DashboardBehavior, DashboardData> {
  final itemsRepo = Get.find<Items>();
  final firebaseItemsRepo = Get.find<ItemRepository>();
  final box = GetStorage();

  @override
  Future<DashboardData> initState() async {
    // List<Item> item;
    // await firebaseItemsRepo.itemsList().listen((event) {
    //   print(event.first.amount);
    //   item = event;
    //   return DashboardData(itemPicked: 0, amount: 0, itemList: item);
    // }).asFuture();
    return DashboardData();
  }

  void changePickedItem(index) {
    state.itemPicked = index;
    render();
  }

  // Stream<Items> _mapItemsLoadedToState() async* {
  //  firebaseItemsRepo.itemsList().listen((event) {
  //     print(event.first.amount);
  //     return  item = event;

  //   });
  // }

  Future<void> addItemSold() async {
    await firebaseItemsRepo.addItem(state.item);
    // await itemsRepo.addSoldItem(state.itemPicked, state.amount);
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: ResColor.appBackground,
            child: StreamBuilder<QuerySnapshot>(
              stream: behavior.streamItems(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    print(data['grain']);
                    if (data['pickedItem'] == 0) {
                      harga = data['amount'] *
                              double.parse("${data['grain']}.0 ") ??
                          1500;
                    } else {
                      harga =
                          data['amount'] * double.parse("${data['rack']}.0 ") ??
                              45000;
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
            // child: ListView.builder(
            //     itemCount: state.itemList.length ?? 0,
            //     itemBuilder: (context, index) {
            //       return Text(state.itemList.elementAt(index).grain.toString());
            //     })
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
