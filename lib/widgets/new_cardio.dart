// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_tracking_app/models/cardio.dart';
// import 'package:workout_tracking_app/providers/Cardio_method_provider.dart';
import 'package:workout_tracking_app/services/data_service.dart';

class NewCardio extends ConsumerStatefulWidget {
  const NewCardio({super.key});

  @override
  ConsumerState<NewCardio> createState() {
    return _NewCardioState();
  }
}

class _NewCardioState extends ConsumerState<NewCardio> {
  final _formKey = GlobalKey<FormState>();
  final _dataService = DataService();
  var _enteredMinutes = '';
  var _enteredDistance = ''; 
  var _enteredAvgSpeed = ''; 
  var _enteredAvgIncline = ''; 
  var _enteredCalories = ''; 
  var _enteredAvgPace = ''; 
  var _enteredAvgWatts = ''; 
  var _enteredAvgMets = ''; 
  var _enteredPeakSpeed = ''; 
  var _enteredPeakWatts = ''; 
  var _enteredPeakMets = '';  
  var _isSending = false;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Timestamp now = Timestamp.fromDate(DateTime.now());
      setState(() {
        _isSending = true;
      });

      final cardio = Cardio(
        minutes: double.parse(_enteredMinutes),
        distance: double.parse(_enteredDistance),
        averageSpeed: double.parse(_enteredAvgSpeed), 
        averageIncline: double.parse(_enteredAvgIncline),
        calories: double.parse(_enteredCalories),
        averagePace: double.parse(_enteredAvgPace),
        averageWatts: double.parse(_enteredAvgWatts),
        averageMets: double.parse(_enteredAvgMets),
        peakSpeed: double.parse(_enteredPeakSpeed),
        peakWatts: double.parse(_enteredPeakWatts),
        peakMets: double.parse(_enteredPeakMets),
        date: now,
      );

      final newDocId = await _dataService.addCardio(cardio);

      if (!mounted) { // i.e !context.mounted
        return;
      }

      Navigator.of(context).pop(
        Cardio(
          id: newDocId, 
          minutes: _enteredMinutes,
          distance: _enteredDistance,
          averageSpeed: _enteredAvgSpeed, 
          averageIncline: _enteredAvgIncline,
          calories: _enteredCalories,
          averagePace: _enteredAvgPace,
          averageWatts: _enteredAvgWatts,
          averageMets: _enteredAvgMets,
          peakSpeed: _enteredPeakSpeed,
          peakWatts: _enteredPeakWatts,
          peakMets: _enteredPeakMets,
          date: now, 
        )
      );
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new Cardio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        // child: Text("HELLO TEXT NEW Cardio FORM"),
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
                        label: Text('Minutes')
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                      initialValue: _enteredMinutes,
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
                        print(value);
                        _enteredMinutes = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Distance')
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                      initialValue: _enteredDistance,
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
                        _enteredDistance = value!;
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
                        label: Text('Avg Speed')
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                      initialValue: _enteredAvgSpeed,
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
                        _enteredAvgSpeed = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Avg Incline')
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                      initialValue: _enteredAvgIncline,
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
                        _enteredAvgIncline = value!;
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
                        label: Text('Calories')
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: _enteredCalories,
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
                        _enteredCalories = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Avg Pace')
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                      initialValue: _enteredAvgPace,
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
                        _enteredAvgPace = value!;
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
                        label: Text('Avg Watts')
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                      initialValue: _enteredAvgWatts,
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
                        _enteredAvgWatts = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Avg METs')
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                      initialValue: _enteredAvgMets,
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
                        _enteredAvgMets = value!;
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
                        label: Text('Peak Speed')
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                      initialValue: _enteredPeakSpeed,
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
                        _enteredPeakSpeed = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Peak Watts')
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: _enteredPeakWatts,
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
                        _enteredPeakWatts = value!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),  
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // make sure row content is pushed all the way to the right
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Peak METs')
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                      initialValue: _enteredPeakMets,
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
                        _enteredPeakMets = value!;
                      },
                    ),
                  ),
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