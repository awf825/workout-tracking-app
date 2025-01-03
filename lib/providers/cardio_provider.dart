import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_tracking_app/models/cardio.dart';

class CardioNotifier extends StateNotifier<List<Cardio>> {
  CardioNotifier() : super([]);

  void setData(List<Cardio> data) {
    state = data;
  }

  List<Cardio> getData() {
    return state;
  }

  void addCardioWorkout(Cardio cardio) {
    state = [...state, cardio];
  }

  void updateCardioWorkout(Cardio cardio) {
    int idxToUpdate = state.indexWhere((element) => element.id == cardio.id);
    var newState = state;
    newState[idxToUpdate] = cardio;
    state = [...newState];
  }  
}

final cardioProvider = StateNotifierProvider<CardioNotifier, List<Cardio>>(
  (ref) => CardioNotifier()
);