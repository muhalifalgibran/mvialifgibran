import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egg_note/framework/network/firebase/firebase.dart';

class Prices {
  Future getPrices() async {
    return FirebaseNetwork.adjustment
        .orderBy("addTime", descending: true)
        .limit(1)
        .get();
  }

  Future setPrices(grain, rack) {
    return FirebaseNetwork.adjustment
        .add({
          'grain': grain,
          'rack': rack,
          'addTime': DateTime.now(),
        })
        .then((value) => print("Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
