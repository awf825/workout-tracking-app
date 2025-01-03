// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_tracking_app/models/weights.dart';
// import 'package:workout_tracking_app/providers/Weights_method_provider.dart';
import 'package:workout_tracking_app/services/data_service.dart';

class NewWeights extends ConsumerStatefulWidget {
  const NewWeights({super.key});

  @override
  ConsumerState<NewWeights> createState() {
    return _NewWeightsState();
  }
}

class _NewWeightsState extends ConsumerState<NewWeights> {
  final _formKey = GlobalKey<FormState>();
  final _dataService = DataService();
  var _enteredLiftId = '';
  var _enteredDesiredRepsPerSet = '';
  var _enteredMinutesRest = ''; 
  var _enteredSets = ''; 
  var _enteredTotalPounds = ''; 
  var _enteredTotalReps = ''; 
  var _enteredCompleted = ''; 
  var _isSending = false;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Timestamp now = Timestamp.fromDate(DateTime.now());
      setState(() {
        _isSending = true;
      });

      final weights = Weights(
        liftId: _enteredLiftId,
        desiredRepsPerSet: double.parse(_enteredDesiredRepsPerSet),
        minutesRest: double.parse(_enteredMinutesRest), 
        sets: double.parse(_enteredSets),
        totalPounds: double.parse(_enteredTotalPounds),
        totalReps: double.parse(_enteredTotalReps),
        completeBeforeExhaustion: double.parse(_enteredCompleted)>0 ? true : false,
        date: now,
      );

      final newDocId = await _dataService.addWeights(weights);

      if (!mounted) { // i.e !context.mounted
        return;
      }

      Navigator.of(context).pop(
        Weights(
          id: newDocId, 
          liftId: _enteredLiftId,
          desiredRepsPerSet: _enteredDesiredRepsPerSet,
          minutesRest: _enteredMinutesRest, 
          sets: _enteredSets,
          totalPounds: _enteredTotalPounds,
          totalReps: _enteredTotalReps,
          completeBeforeExhaustion: double.parse(_enteredCompleted)>0 ? true : false,
          date: now, 
        )
      );
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new lifting exercise'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        // child: Text("HELLO TEXT NEW Weights FORM"),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Lift')
                      ),
                      initialValue: _enteredLiftId,
                      onSaved: (value) {
                        _enteredLiftId = value!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Desired Reps Per Set')
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                      initialValue: _enteredDesiredRepsPerSet,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          final text = newValue.text;
                          return text.isEmpty
                              ? newValue
                              : double.tryParse(text) == null
                                  ? oldValue
                                  : newValue;
                        }),
                      ],
                      onSaved: (value) {
                        _enteredDesiredRepsPerSet = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Minutes Rest')
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                      initialValue: _enteredMinutesRest,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          final text = newValue.text;
                          return text.isEmpty
                              ? newValue
                              : double.tryParse(text) == null
                                  ? oldValue
                                  : newValue;
                        }),
                      ],
                      onSaved: (value) {
                        _enteredMinutesRest = value!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Sets')
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                      initialValue: _enteredSets,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          final text = newValue.text;
                          return text.isEmpty
                              ? newValue
                              : double.tryParse(text) == null
                                  ? oldValue
                                  : newValue;
                        }),
                      ],
                      onSaved: (value) {
                        _enteredSets = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Total Pounds')
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                      initialValue: _enteredTotalPounds,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          final text = newValue.text;
                          return text.isEmpty
                              ? newValue
                              : double.tryParse(text) == null
                                  ? oldValue
                                  : newValue;
                        }),
                      ],
                      onSaved: (value) {
                        _enteredTotalPounds = value!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Total Reps')
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: _enteredTotalReps,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          final text = newValue.text;
                          return text.isEmpty
                              ? newValue
                              : double.tryParse(text) == null
                                  ? oldValue
                                  : newValue;
                        }),
                      ],
                      onSaved: (value) {
                        _enteredTotalReps = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Completed?')
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          final text = newValue.text;
                          return text.isEmpty
                              ? newValue
                              : double.tryParse(text) == null
                                  ? oldValue
                                  : newValue;
                        }),
                      ],
                      initialValue: _enteredCompleted,
                      onSaved: (value) {
                        _enteredCompleted = value!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),   
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // make sure row content is pushed all the way to the right
                children: [
                  // setting TextButton's onPressed to null will disable the button
                  TextButton(
                    onPressed: _isSending ? null : () {
                      _formKey.currentState!.reset();
                    }, 
                    child: const Text('Reset')
                  ),
                  ElevatedButton(
                    onPressed: _isSending ? null : _saveItem, 
                    child: _isSending 
                      ? const SizedBox(
                        height: 16, 
                        width: 16, 
                        child: CircularProgressIndicator()
                      ) : const Text('Add Item')
                  )
                ],
              )
            ],
          )
        )
      )
    );
  }
}