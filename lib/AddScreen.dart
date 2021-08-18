import 'package:flutter/material.dart';
import 'main.dart';
import 'InputPicker.dart';

final titleController = TextEditingController();
final descriptionController = TextEditingController();

var titleFiled = Container(
  width: 200,
  child: TextField(
    controller: titleController,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: "Title",
      hintStyle: TextStyle(color: Color(0xff495057)),
    ),
  ),
);

var descriptionFiled = Container(
  child: TextField(
    controller: descriptionController,
    keyboardType: TextInputType.multiline,
    maxLines: 3,
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Description (optional)",
        hintStyle: TextStyle(color: Color(0xff495057))),
  ),
);

class SelectionButtons extends StatefulWidget {
  const SelectionButtons({Key? key, this.onFloatingPressed, this.manageNewData})
      : super(key: key);

  final onFloatingPressed;
  final manageNewData;

  @override
  _SelectionButtonsState createState() => _SelectionButtonsState();
}

class _SelectionButtonsState extends State<SelectionButtons> {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  void sendData() {
    var dur = exportDuration;
    var wek = exportWeekly;
    var tit = titleController.text;
    var des = descriptionController.text;
    widget.manageNewData(dur, wek, tit, des);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 30,
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () => widget.onFloatingPressed(),
                    child: const Text('Disgard'),
                  ),
                ),
                Container(
                  width: 100,
                  height: 50,
                  margin: EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: style,
                    onPressed: () {
                      sendData();
                      widget.onFloatingPressed();
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            )));
  }
}

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key, this.onFloatingPressed, this.manageNewData})
      : super(key: key);

  final onFloatingPressed;
  final manageNewData;

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(height: 260, child: ImageTextStack),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.all(10.0), child: titleFiled),
                    Padding(
                        padding: EdgeInsets.all(10.0), child: descriptionFiled),
                    InputPickers(),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: SelectionButtons(
                      onFloatingPressed: widget.onFloatingPressed,
                      manageNewData: widget.manageNewData)),
            ],
          ),
        ),
      ),
    );
  }
}
