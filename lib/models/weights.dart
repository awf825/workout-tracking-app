import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracking_app/models/app_model.dart';
import 'package:workout_tracking_app/models/lifts.dart';

class Weights extends AppModel {
  Weights({
    this.id, 
    this.lift,
    required this.date,
    required this.desiredRepsPerSet,
    required this.liftId,
    required this.minutesRest,
    required this.sets,
    required this.totalPounds,
    required this.totalReps, 
    required this.completeBeforeExhaustion
  });

  final String ?id;
  final Timestamp date;
  Lifts ?lift;
  dynamic desiredRepsPerSet;
  dynamic minutesRest;
  dynamic sets;
  dynamic totalPounds;
  dynamic totalReps;
  dynamic liftId;
  bool completeBeforeExhaustion;

  void setLift(liftToSet) {
    lift = liftToSet;
  }

  String readDate() {
    return DateFormat.yMMMd().add_jm().format(date.toDate());
  }

  Lifts? readLift() {
    return lift;
  }

  factory Weights.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Weights(
      date: data?['date'],
      liftId: data?['liftId'],
      completeBeforeExhaustion: data?['completeBeforeExhaustion'],
      desiredRepsPerSet: data?['desiredRepsPerSet'],
      minutesRest: data?['minutesRest'],
      sets: data?['sets'],
      totalPounds: data?['totalPounds'],
      totalReps: data?['totalReps']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "date": date,
      "liftId": liftId,
      "completeBeforeExhaustion": completeBeforeExhaustion,
      if (desiredRepsPerSet > 0) "desiredRepsPerSet": desiredRepsPerSet,
      if (minutesRest > 0) "minutesRest": minutesRest,
      if (sets > 0) "sets": sets,
      if (totalPounds > 0) "totalPounds": totalPounds,
      if (totalReps > 0) "totalReps": totalReps
    };
  }

}