import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final int amount;
  final int grain;
  final int pickedItem;
  final int rack;

  ItemEntity(this.amount, this.grain, this.pickedItem, this.rack);

  @override
  List<Object> get props => throw UnimplementedError();

  Map<String, Object> toJson() {
    return {
      'amount': amount,
      'grain': grain,
      'pickedItem': pickedItem,
      'rack': rack
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'ItemEntity{ $amount, $grain, $pickedItem, $rack }';
  }

  static ItemEntity fromJson(Map<String, Object> json) {
    return ItemEntity(
      json['amount'] as int,
      json['grain'] as int,
      json['pickedItem'] as int,
      json['rack'] as int,
    );
  }

  static ItemEntity fromSnapshot(DocumentSnapshot snapshot) {
    return ItemEntity(
      snapshot.get('amount'),
      snapshot.get('grain'),
      snapshot.get('pickedItem'),
      snapshot.get('rack'),
    );
  }

  Map<String, Object> toDocument() {
    return {
      'amount': amount,
      'grain': grain,
      'pickedItem': pickedItem,
      'rack': rack
    };
  }
}
