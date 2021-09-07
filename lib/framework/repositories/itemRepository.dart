import 'package:egg_note/framework/models/item.dart';

abstract class ItemRepository {
  Future<void> addItem(Item item);
  Stream<List<Item>> itemsList();
}
