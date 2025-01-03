import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracking_app/models/app_model.dart';

class Cardio extends AppModel {
  Cardio({
    this.id, 
    required this.date,
    required this.minutes,        // minutes -> 18:36 = 18.6
    required this.distance,       // miles
    required this.averageSpeed,   // mph
    required this.averageIncline, // arbitrary
    required this.calories,
    required this.averagePace,    // minutes 
    required this.averageWatts,
    required this.averageMets,    // see: metabolic equivalent of task
    required this.peakSpeed,      // mph
    required this.peakWatts,
    required this.peakMets
  });

  final String ?id;
  final Timestamp date;
  dynamic minutes;
  dynamic distance;
  dynamic averageSpeed;
  dynamic averageIncline;
  dynamic calories;
  dynamic averagePace;
  dynamic averageWatts;
  dynamic averageMets;
  dynamic peakSpeed;
  dynamic peakWatts;
  dynamic peakMets;

  String readDate() {
    return DateFormat.yMMMd().add_jm().format(date.toDate());
  }

  factory Cardio.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Cardio(
      date: data?['date'],
      minutes: data?['minutes'],
      distance: data?['distance'],
      averageSpeed: data?['averageSpeed'],
      averageIncline: data?['averageIncline'],
      calories: data?['calories'],
      averagePace: data?['averagePace'],
      averageWatts: data?['averageWatts'],
      averageMets: data?['averageMets'],
      peakSpeed: data?['peakSpeed'],
      peakWatts: data?['peakWatts'],
      peakMets: data?['peakMets']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "date": date,
      if (minutes > 0) "minutes": minutes,
      if (distance > 0) "distance": distance,
      if (averageSpeed > 0) "averageSpeed": averageSpeed,
      if (averageIncline > 0) "averageIncline": averageIncline,
      if (calories > 0) "calories": calories,
      if (averagePace > 0) "averagePace": averagePace,
      if (averageWatts > 0) "averageWatts": averageWatts,
      if (averageMets > 0) "averageMets": averageMets,
      if (peakSpeed > 0) "peakSpeed": peakSpeed,
      if (peakWatts > 0) "peakWatts": peakWatts,
      if (peakMets > 0) "peakMets": peakMets,
    };
  }

}