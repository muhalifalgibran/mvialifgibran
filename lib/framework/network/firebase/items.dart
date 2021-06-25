import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egg_note/framework/network/firebase/firebase.dart';

class Items {
  Future addSoldItem(pickedItem, amount) {
    return FirebaseNetwork.items
        .add({
          'pickedItem': pickedItem,
          'amount': amount,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Stream<QuerySnapshot<Object>> streamItem() {
    return FirebaseNetwork.usersStream;
  }
}
