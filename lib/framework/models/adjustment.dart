import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egg_note/framework/entities/adjustment_entities.dart';
import 'package:equatable/equatable.dart';

class Adjustment extends Equatable {
  final Timestamp addTime = Timestamp.now();
  final int grain;
  final int rack;

  Adjustment({this.grain = 0, this.rack = 0});

  @override
  List<Object> get props => [
        addTime,
        grain,
        rack,
      ];

  AdjustmentEntity toEntity() {
    return AdjustmentEntity(
      addTime,
      grain,
      rack,
    );
  }

  static Adjustment fromEntity(AdjustmentEntity data) {
    return Adjustment(
      rack: data.rack,
      grain: data.grain,
    );
  }
}
