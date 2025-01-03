import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_tracking_app/models/lifts.dart';

class LiftsNotifier extends StateNotifier<List<Lifts>> {
  LiftsNotifier() : super([]);

  void setData(List<Lifts> data) {
    state = data;
  }

  List<Lifts> getData() {
    return state;
  }

  void addLifts(Lifts lifts) {
    state = [...state, lifts];
  }

  Lifts getById(String id) {
    int methodIndex = state.indexWhere((p) => p.id == id);
    return state[methodIndex];
  }
}

final liftsProvider = StateNotifierProvider<LiftsNotifier, List<Lifts>>(
  (ref) => LiftsNotifier()
);