import 'dart:convert';
import 'package:egg_note/framework/entities/item_entities.dart';
import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final int amount;
  final int grain;
  final int pickedItem;
  final int rack;

  Item({this.amount = 0, this.grain = 0, this.pickedItem = 0, this.rack = 0});

  Item copywith({int amount, int grain, int pickedItem, int rack}) {
    return Item(
        amount: amount ?? this.amount,
        grain: grain ?? this.grain,
        pickedItem: pickedItem ?? this.pickedItem,
        rack: rack ?? this.rack);
  }

  // @override
  // int get HashCode =>
  //     amount.hashCode ^ grain.hashCode ^ pickedItem.hashCode ^ rack.hashCode;

  ItemEntity toEntity() {
    return ItemEntity(amount, grain, pickedItem, rack);
  }

  static Item fromEntitiy(ItemEntity data) {
    return Item(
        amount: data.amount,
        grain: data.grain,
        pickedItem: data.pickedItem,
        rack: data.rack);
  }

  @override
  List<Object> get props => [amount, grain, pickedItem, rack];
}
