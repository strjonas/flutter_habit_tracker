import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';

void main() {
  runApp(MyApp());
}

bool isAddScreen = false;

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

var titleFiled = Container(
  width: 200,
  child: TextField(
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: "Title",
      hintStyle: TextStyle(color: Color(0xff495057)),
    ),
  ),
);

var descriptionFiled = Container(
  child: TextField(
    keyboardType: TextInputType.multiline,
    maxLines: 3,
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Description (optional)",
        hintStyle: TextStyle(color: Color(0xff495057))),
  ),
);

var ImageTextStack = Stack(
  alignment: Alignment.topLeft,
  children: <Widget>[
    Image.asset(
      "assets/headerImage.jpg",
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    ),
    Padding(
        padding: EdgeInsets.all(32.0),
        child: Text(
          "New Habit",
          style: TextStyle(
              color: Colors.grey[700],
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ))
  ],
);

class InputPickers extends StatefulWidget {
  const InputPickers({Key? key}) : super(key: key);

  @override
  InputPickersState createState() => InputPickersState();
}

var weeklyTimesText = "Weekly";

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

class _AmountPicker extends StatefulWidget {
  const _AmountPicker({Key? key}) : super(key: key);

  @override
  _AmountPickerState createState() => _AmountPickerState();
}

class _AmountPickerState extends State<_AmountPicker> {
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
            onConfirmed: () => {weeklyTimesText = age.toString()},
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
    return Builder(
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

          setState(() => durationButtonText = hours != "0"
              ? "$hours hours and $minutes minutes"
              : "$minutes minutes");
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Chosen duration: $durationButtonText')));
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
    );
  }
}

class SelectionButtons extends StatefulWidget {
  const SelectionButtons({Key? key}) : super(key: key);

  @override
  _SelectionButtonsState createState() => _SelectionButtonsState();
}

class _SelectionButtonsState extends State<SelectionButtons> {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

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
                    onPressed: null,
                    child: const Text('Disgard'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: style,
                    onPressed: () {},
                    child: const Text('Save'),
                  ),
                ),
              ],
            )));
  }
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
              Container(height: 230, child: ImageTextStack),
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
              Padding(padding: EdgeInsets.all(20), child: SelectionButtons()),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MainApp(),
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  void onFloatingPressed() {
    setState(() {
      isAddScreen = !isAddScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isAddScreen) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: onFloatingPressed,
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text(
                  'HABITS',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.white,
                expandedHeight: 230.0,
                floating: true,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    "assets/headerImage.jpg",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ];
          },
          body: TaskHolder(),
        ),
      );
    } else {
      return AddScreen();
    }
  }
}

class TaskHolder extends StatefulWidget {
  const TaskHolder({Key? key}) : super(key: key);

  @override
  _TaskHolderState createState() => _TaskHolderState();
}

class _TaskHolderState extends State<TaskHolder> {
  final _tasks = [
    {"id": "1", "title": "dishes", "isdone": "false"},
    {"id": "2", "title": "cleaning", "isdone": "true"},
  ];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TaskList(),
    );
  }

  Widget _buildRow(String task) {
    return ListTile(
      title: Text(task, style: _biggerFont),
      trailing: Icon(Icons.delete),
    );
  }

  Widget TaskList() {
    final tiles = _tasks.map(
      (task) {
        return Dismissible(
          key: Key(task["id"]!),
          background: Container(
            alignment: AlignmentDirectional.centerStart,
            color: Colors.red,
            child: Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            setState(() {
              _tasks.removeAt(_tasks.indexOf(task));
            });

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Dismissed!')));
          },
          child: ListTile(
              title: Text(
                task["title"]!,
                style: task["isdone"] == "true"
                    ? TextStyle(decoration: TextDecoration.lineThrough)
                    : _biggerFont,
              ),
              trailing: Icon(
                  task["isdone"] == "true"
                      ? Icons.check_circle
                      : Icons.check_circle_outline,
                  color: task["isdone"] == "true"
                      ? Colors.greenAccent
                      : Colors.red),
              onTap: () {
                setState(() {
                  if (task["isdone"] == "false") {
                    task["isdone"] = "true";
                  } else {
                    task["isdone"] = "false";
                  }
                });
              }),
        );
      },
    );
    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(context: context, tiles: tiles).toList()
        : <Widget>[];
    return ListView(children: divided);
  }
}
