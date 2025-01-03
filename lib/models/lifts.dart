import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracking_app/models/app_model.dart';

class Lifts extends AppModel {
  const Lifts({
    this.id, 
    required this.name,
  });

  final String ?id;
  final String name;

  factory Lifts.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Lifts(
      name: data?['name']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
    };
  }
}