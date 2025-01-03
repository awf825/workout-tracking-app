import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracking_app/models/cardio.dart';
import 'package:workout_tracking_app/providers/Weights_provider.dart';
import 'package:workout_tracking_app/providers/cardio_provider.dart';
import 'package:workout_tracking_app/widgets/new_cardio.dart';
// import 'package:payment_tracking/widgets/edit_payment.dart';

// ignore: must_be_immutable
class CardioScreen extends ConsumerStatefulWidget {
  const CardioScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CardioScreenState createState() => _CardioScreenState();
}

class _CardioScreenState extends ConsumerState<CardioScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void addCardio() async {
    final newWorkout = await Navigator.of(context).push<Cardio>(
      MaterialPageRoute(
        builder: (ctx) => const NewCardio(),
      )
    );

    if (newWorkout == null) {
      return; 
    }

    ref.read(cardioProvider.notifier).addCardioWorkout(newWorkout);
  }

  // void editCardio(Cardio cardio) async {
  //   final updatedCardio = await Navigator.of(context).push<Cardio>(
  //     MaterialPageRoute(
  //       builder: (ctx) => EditCardio(
  //         cardio: cardio
  //       ),
  //     )
  //   );

  //   if (updatedCardio == null) {
  //     return; 
  //   }

  //   ref.read(cardioProvider.notifier).updateCardioWorkout(updatedCardio);
  // }

  ExpansionTile _buildExpansionTile(Cardio c) {
    final df = new DateFormat('yyyy-MM-dd');
    final GlobalKey expansionTileKey = GlobalKey();
    // final Cardio cardio = _localCardio[index];
    DateTime dt = (c.date).toDate();
    return ExpansionTile(
      key: expansionTileKey,
      title: ListTile(
        // leading: Text(p.paymentMethod!.name),
        leading: Text(df.format(dt)),
        // title: Text(p.recipient)
        title: Text("${c.averagePace.toString()} minute mile")
      ),
      
      // Text('My expansion tile $index'),
      children: <Widget>[
        ListTile(
          leading: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => print((ref.read(weightsProvider.notifier).getData()))
            // onPressed: () => editCardio(c),
          ),
          title: Text("${c.distance} miles"),
          subtitle: Text("Average Speed: ${c.averageSpeed} mph"),
          trailing: Text("${c.calories} calories"),
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    List<Cardio> _localCardio = ref.watch(cardioProvider);
    _localCardio.sort((a,b) => b.date.compareTo(a.date));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardio Workouts'),
          leading: IconButton(
          icon: const Icon(Icons.add),
          // onPressed: addCardio,
          onPressed: addCardio,
        ),
      ),
      body: _localCardio.isNotEmpty ? 
        ListView.builder(
          controller: _scrollController,
          itemCount: _localCardio.length,
          itemBuilder: (BuildContext context, int index) => _buildExpansionTile(_localCardio[index]),
        ) :
        const Text('LOADING'),      
    );
  }
}