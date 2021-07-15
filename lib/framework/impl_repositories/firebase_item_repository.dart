import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egg_note/framework/entities/item_entities.dart';
import 'package:egg_note/framework/models/item.dart';
import 'package:egg_note/framework/repositories/itemRepository.dart';

class FirebaseItemRepository implements ItemRepository {
  final itemCollection = FirebaseFirestore.instance.collection('items');

  @override
  Future<void> addItem(Item item) {
    return itemCollection.add(item.toEntity().toDocument());
  }

  @override
  Stream<List<Item>> itemsList() {
    return itemCollection.snapshots().map((event) {
      return event.docs.map((e) {
        return Item.fromEntitiy(ItemEntity.fromSnapshot(e));
      }).toList();
    });
  }
}
