import 'package:flutter/material.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';

import 'main.dart';
import 'AddScreen.dart';

var exportDuration;
var exportWeekly;

var weeklyTimesText = "Weekly";

class _AmountPicker extends StatefulWidget {
  const _AmountPicker({Key? key}) : super(key: key);

  @override
  _AmountPickerState createState() => _AmountPickerState();
}

class _AmountPickerState extends State<_AmountPicker> {
  void onComfirmed(age) {
    weeklyTimesText = age.toString();
    exportWeekly = age;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) => TextButton(
        onPressed: () async {
          var age = 3;

          showMaterialNumberPicker(
            context: context,
            title: 'How many times a week',
            maxNumber: 21,
            minNumber: 1,
            selectedNumber: age,
            onConfirmed: () => {onComfirmed(age)},
            onChanged: (value) => setState(() => age = value),
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                width: 160,
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                )),
            Container(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    weeklyTimesText,
                    style: TextStyle(
                      color: Color(0xff495057),
                    ),
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Duration _duration = Duration(hours: 0, minutes: 0);
var durationButtonText = "Pick Duration";

var durationPicker = DurationPicker(
  duration: _duration,
  onChange: (val) {
    _duration = val;
  },
  snapToMins: 5.0,
);

class _DurationPicker extends StatefulWidget {
  const _DurationPicker({Key? key}) : super(key: key);

  @override
  _DurationPickerState createState() => _DurationPickerState();
}

class _DurationPickerState extends State<_DurationPicker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0),
      child: Builder(
        builder: (BuildContext context) => TextButton(
          onPressed: () async {
            var resultingDuration = await showDurationPicker(
              context: context,
              initialTime: Duration(minutes: 30),
            );
            if (resultingDuration == null) return;
            _duration = resultingDuration;
            var liste = resultingDuration.toString().split(":");
            var hours = liste[0];
            var minutes = liste[1];

            exportDuration = "$hours:$minutes";

            setState(() => durationButtonText = hours != "0"
                ? "$hours hours and $minutes minutes"
                : "$minutes minutes");
            // ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text('Chosen duration: $durationButtonText')));
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  width: 243,
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  )),
              Container(
                width: 193,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      durationButtonText,
                      style: TextStyle(
                        color: Color(0xff495057),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InputPickers extends StatefulWidget {
  const InputPickers({Key? key}) : super(key: key);

  @override
  InputPickersState createState() => InputPickersState();
}

class InputPickersState extends State<InputPickers> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DurationPicker(),
          _AmountPicker(),
        ]);
  }
}
