import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egg_note/framework/impl_repositories/firebase_item_repository.dart';
import 'package:egg_note/framework/network/firebase/prices.dart';
import 'package:egg_note/framework/network/firebase/items.dart';
import 'package:egg_note/framework/repositories/itemRepository.dart';
import 'package:get/get.dart';

class FirebaseNetwork {
  const FirebaseNetwork();
  static FirebaseFirestore firestore;
  static CollectionReference items;
  static CollectionReference adjustment;
  static Stream<QuerySnapshot> usersStream;
  static register() async {
    firestore = FirebaseFirestore.instance;
    items = FirebaseFirestore.instance.collection('items');
    usersStream = FirebaseFirestore.instance.collection('items').snapshots();
    adjustment = FirebaseFirestore.instance.collection('prices');

    Get.put(Items());
    Get.put(Prices());
    Get.put<ItemRepository>(FirebaseItemRepository());
  }
}
