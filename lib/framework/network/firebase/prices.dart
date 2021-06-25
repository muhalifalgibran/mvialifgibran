import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egg_note/framework/network/firebase/firebase.dart';

class Prices {
  Future setPrices() async {
    return FirebaseNetwork.adjustment
        .orderBy("addTime", descending: true)
        .limit(1)
        .get();
  }
}
