import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_tracking_app/models/weights.dart';

class WeightsNotifier extends StateNotifier<List<Weights>> {
  WeightsNotifier() : super([]);

  void setData(List<Weights> data) {
    state = data;
  }

  List<Weights> getData() {
    return state;
  }

  void addWeightsWorkout(Weights weights) {
    state = [...state, weights];
  }

  void updateWeightsWorkout(Weights weights) {
    int idxToUpdate = state.indexWhere((element) => element.id == weights.id);
    var newState = state;
    newState[idxToUpdate] = weights;
    state = [...newState];
  }  
}

final weightsProvider = StateNotifierProvider<WeightsNotifier, List<Weights>>(
  (ref) => WeightsNotifier()
);