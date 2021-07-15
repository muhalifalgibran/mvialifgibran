import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AdjustmentEntity extends Equatable {
  final Timestamp addTime;
  final int grain;
  final int rack;

  AdjustmentEntity(this.addTime, this.grain, this.rack);

  @override
  List<Object> get props => [addTime, grain, rack];

  Map<String, Object> toJson() {
    return {
      'addTime': addTime,
      'grain': grain,
      'rack': rack,
    };
  }

  @override
  String toString() {
    return " 'addTime': $addTime, 'grain': $grain, 'rack': $rack,";
  }

  static AdjustmentEntity fromJson(Map<String, Object> json) {
    return AdjustmentEntity(
      json['addTime'] as Timestamp,
      json['grain'] as int,
      json['rack'] as int,
    );
  }

  static AdjustmentEntity fromSnapshot(DocumentSnapshot snap) {
    return AdjustmentEntity(
      snap.get('addTime'),
      snap.get('grain'),
      snap.get('rack'),
    );
  }

  Map<String, Object> toDocument() {
    return {
      'addTime': addTime,
      'grain': grain,
      'rack': rack,
    };
  }
}
