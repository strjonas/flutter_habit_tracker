import 'package:app/AddScreen.dart';
import 'package:app/HabitView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:uuid/uuid.dart';

import 'AddScreen.dart';

final LocalStorage storage = new LocalStorage('habits.json');
var uuid = Uuid();

var habits = [
  {
    "id": "1", // uuid.v4();
    "title": "jugglen",
    "description": "jonglieren hatl",
    "weekly": "5",
    "duration": "0:03",
    "thisweek": "5"
  },
  {
    "id": "2",
    "title": "jugglen",
    "description": "jonglieren hatl",
    "weekly": "5",
    "duration": "0:03",
    "thisweek": "5"
  }
];

void main() {
  if (storage.getItem("habits") == null) {
    storage.setItem("habits", habits);
  } else {
    habits = storage.getItem("habits");
  }
  runApp(MyApp());
}

bool isAddScreen = false;

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
        padding: EdgeInsets.all(42.0),
        child: Text(
          "New Habit",
          style: TextStyle(
              color: Colors.grey[700],
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ))
  ],
);

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
      print(isAddScreen);
    });
  }

  void manageNewData(duration, weekly, title, description) {
    final id = uuid.v4();
    var newData = {
      "id": "$id",
      "title": "$title",
      "description": "$description",
      "weekly": "$weekly",
      "duration": "$duration",
      "thisweek": "$weekly"
    };
    habits.add(newData);
    storage.setItem("habis", habits);
    print("$title, $description, $weekly, $duration");
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
          body: HabitView(habits: habits),
        ),
      );
    } else {
      return AddScreen(
          onFloatingPressed: onFloatingPressed, manageNewData: manageNewData);
    }
  }
}
