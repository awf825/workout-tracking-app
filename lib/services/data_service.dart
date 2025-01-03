import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workout_tracking_app/models/cardio.dart';
import 'package:workout_tracking_app/models/lifts.dart';
import 'package:workout_tracking_app/models/weights.dart';
// import 'package:payment_tracking/models/income_stream.dart';
// import 'package:payment_tracking/models/payment_method.dart';

class DataService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, List<dynamic>>> loadAll() async {
    try {
      List<Cardio> cardioData = await getCardioWorkouts();
      List<Weights> weightsData = await getWeightWorkouts();
      List<Lifts> liftsData = await getLifts();

      for (var weights in weightsData) {
        var lift = liftsData.firstWhere((l) => l.id == weights.liftId, orElse: () => Lifts(id: "0", name: "UNKNOWN"));
        weights.setLift(lift);
      }

      print(weightsData);

      Map<String, List<dynamic>> allData = {
        "cardio": cardioData,
        "weights": weightsData,
        "lifts": liftsData
      };
      return allData;
    } catch (e) {
      print("<!!! -- Error loading all data: $e -- !!!>");
      return {};
    }
  }

  Future<List<Cardio>> getCardioWorkouts() async {
    List<Cardio> out = [];
    QuerySnapshot querySnapshot = await _db.collection('cardio').get();

    for (var doc in querySnapshot.docs) {
      final id = doc.id;
      final data = doc.data() as Map;
      Cardio cardio = Cardio(
        id: id,
        date: data['date'],
        minutes: data['minutes'],
        distance: data['distance'],
        averageSpeed: data['averageSpeed'],
        averageIncline: data['averageIncline'],
        calories: data['calories'],
        averagePace: data['averagePace'],
        averageWatts: data['averageWatts'],
        averageMets: data['averageMets'],
        peakSpeed: data['peakSpeed'],
        peakWatts: data['peakWatts'],
        peakMets: data['peakMets']
      );
      out.add(cardio);
    }

    return out;
  }

  Future<List<Weights>> getWeightWorkouts() async {
    List<Weights> out = [];
    QuerySnapshot querySnapshot = await _db.collection('weights').get();

    for (var doc in querySnapshot.docs) {
      final id = doc.id;
      final data = doc.data() as Map;
      Weights weights = Weights(
        id: id,
        date: data['date'],
        liftId: data['liftId'],
        completeBeforeExhaustion: data['completeBeforeExhaustion'],
        desiredRepsPerSet: data['desiredRepsPerSet'],
        minutesRest: data['minutesRest'],
        sets: data['sets'],
        totalPounds: data['totalPounds'],
        totalReps: data['totalReps']
      );
      out.add(weights);
    }

    return out;
  }

  Future<List<Lifts>> getLifts() async {
    List<Lifts> out = [];
    QuerySnapshot querySnapshot = await _db.collection('lifts').get();

    for (var doc in querySnapshot.docs) {
      final id = doc.id;
      final data = doc.data() as Map;
      Lifts lifts = Lifts(
        id: id,
        name: data['name']
      );
      out.add(lifts);
    }

    return out;
  }

  Future<String?> addCardio(Cardio cardio) async {
    try {
      final docRef = _db
        .collection("cardio")
        .withConverter(
          fromFirestore: Cardio.fromFirestore,
          toFirestore: (cardio, options) => cardio.toFirestore(),
        )
        .doc();
      await docRef.set(cardio);
      return docRef.id;
    } catch (e) {
      print("<!!! -- Error writing payment doc: $e -- !!!>");
      return null;
    }
  }

    Future<String?> addWeights(weights) async {
    try {
      final docRef = _db
        .collection("weights")
        .withConverter(
          fromFirestore: Weights.fromFirestore,
          toFirestore: (cardio, options) => cardio.toFirestore(),
        )
        .doc();
      await docRef.set(weights);
      return docRef.id;
    } catch (e) {
      print("<!!! -- Error writing payment doc: $e -- !!!>");
      return null;
    }
  }

  // Future<List<Payment>> query(
  //   String ?paymentMethodId,
  //   String ?categoryId,
  //   DateTime start,
  //   DateTime end
  // ) async {
  //   try {
  //     List<Payment> out = [];
  //     // Timestamp startStamp = start.millisecondsSinceEpoch as Timestamp;
  //     // Timestamp endStamp = end.millisecondsSinceEpoch as Timestamp;
  //     QuerySnapshot querySnapshot = await _db.collection('payment')
  //     .where("paymentMethodId", isEqualTo: paymentMethodId)
  //     .where("categoryId", isEqualTo: categoryId)
  //     .where("date", isGreaterThanOrEqualTo: start)
  //     .where("date", isLessThanOrEqualTo: end)
  //     .get();

  //     for (var doc in querySnapshot.docs) {
  //       // print('<!-- doc.id --!>');
  //       // print(doc.id);
  //       final id = doc.id;
  //       final data = doc.data() as Map;
  //       Payment payment = Payment(
  //         id: id,
  //         date: data["date"], 
  //         recipient: data["recipient"], 
  //         amount: data["amount"], 
  //         paymentMethodId: data["paymentMethodId"], 
  //         categoryId: data["categoryId"]
  //       );
  //       out.add(payment);
  //     }

  //     return out;
  //   } catch (e) {
  //     print("<!!! -- Error querying: $e -- !!!>");
  //     return [];
  //   }
  // }

  // Future<void> purge() async {
  //   // get all payments older than a month
  //   QuerySnapshot querySnapshot = await _db.collection('payment')
  //     .where("date", isLessThanOrEqualTo: DateTime.now().subtract(const Duration(days: 40)))
  //     .get(); 

  //   for (var doc in querySnapshot.docs) {
  //     print('<!-- doc.id --!>');
  //     print(doc.id);
  //     final docRef = doc.reference;
  //     await docRef.delete();
  //   }
  // }

}