import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egg_note/framework/network/firebase/firebase.dart';
import 'package:get_storage/get_storage.dart';

class Items {
  final box = GetStorage();
  Future addSoldItem(pickedItem, amount) {
    return FirebaseNetwork.items
        .add({
          'pickedItem': pickedItem,
          'amount': amount,
          'rack': box.read('rack'),
          'grain': box.read('grain'),
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Stream<QuerySnapshot<Object>> streamItem() {
    return FirebaseNetwork.usersStream;
  }
}
