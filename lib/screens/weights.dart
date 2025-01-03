import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracking_app/models/weights.dart';
import 'package:workout_tracking_app/providers/weights_provider.dart';
// import 'package:payment_tracking/widgets/edit_payment.dart';
import 'package:workout_tracking_app/widgets/new_weights.dart';

// ignore: must_be_immutable
class WeightsScreen extends ConsumerStatefulWidget {
  final List<Weights> data;
  const WeightsScreen({super.key, required this.data});

  @override
  // ignore: library_private_types_in_public_api
  _WeightsScreenState createState() => _WeightsScreenState();
}

class _WeightsScreenState extends ConsumerState<WeightsScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Weights> _localWeights = [];

  @override
  void initState() {
    super.initState();
  }

  void addWeights() async {
    final newWorkout = await Navigator.of(context).push<Weights>(
      MaterialPageRoute(
        builder: (ctx) => const NewWeights(),
      )
    );

    if (newWorkout == null) {
      return; 
    }

    ref.read(weightsProvider.notifier).addWeightsWorkout(newWorkout);
  }

  // void editWeights(Weights Weights) async {
  //   final updatedWeights = await Navigator.of(context).push<Weights>(
  //     MaterialPageRoute(
  //       builder: (ctx) => EditWeights(
  //         Weights: Weights
  //       ),
  //     )
  //   );

  //   if (updatedWeights == null) {
  //     return; 
  //   }

  //   ref.read(WeightsProvider.notifier).updateWeightsWorkout(updatedWeights);
  // }

  ExpansionTile _buildExpansionTile(Weights w) {
    final df = new DateFormat('yyyy-MM-dd');
    final GlobalKey expansionTileKey = GlobalKey();
    // final Weights Weights = _localWeights[index];
    DateTime dt = (w.date).toDate();
    return ExpansionTile(
      key: expansionTileKey,
      title: ListTile(
        // leading: Text(p.paymentMethod!.name),
        leading: Text(df.format(dt)),
        // title: Text(p.recipient)
        title: Text(w.liftId)
      ),
      
      // Text('My expansion tile $index'),
      children: <Widget>[
        ListTile(
          leading: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => print('press')
            // onPressed: () => editWeights(c),
          ),
          title: Text("${w.desiredRepsPerSet} x ${w.sets}"),
          subtitle: Text("${w.totalReps} @ ${w.totalPounds} lbs"),
          trailing: Text("${w.minutesRest} minutes rest"),
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    // _localWeights = ref.watch(weightsProvider);
    _localWeights = widget.data;
    _localWeights.sort((a,b) => b.date.compareTo(a.date));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weights Workouts'),
          leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: addWeights,
        ),
      ),
      body: _localWeights.isNotEmpty ? 
        ListView.builder(
          controller: _scrollController,
          itemCount: _localWeights.length,
          itemBuilder: (BuildContext context, int index) => _buildExpansionTile(_localWeights[index]),
        ) :
        const Text('LOADING'),      
    );
  }
}