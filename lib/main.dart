import 'dart:convert';

import 'package:app/AddScreen.dart';
import 'package:app/HabitView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';
import 'AddScreen.dart';
import 'package:path/path.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

final LocalStorage storage = new LocalStorage('habits');
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

var DATABASE_PATH = "/data/user/0/com.example.app/app_flutter/habits.db";

void main() async {
  await Hive.initFlutter();

  DatabaseFactory dbFactory = databaseFactoryIo;
  Database db = await dbFactory.openDatabase(DATABASE_PATH);
  var store = StoreRef.main();

  if (await store.record('habits').get(db) == null) {
    await store.record('habits').put(db, habits);
  } else {
    var temp = await store.record('habits').get(db);
    List<Map<String, String>> arr = [];
    for (var i in temp) {
      Map<String, String> dict = {};
      for (var entry in i.entries) {
        var e = entry.key;
        var v = entry.value;
        dict["$e"] = "$v";
      }
      arr.add(dict);
    }
    habits = arr;
  }

  print(habits);
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
      padding: EdgeInsets.only(top: 30),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
          "NEW HABIT",
          style: TextStyle(
              color: Colors.grey[700],
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
    )
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
    });
  }

  void manageNewData(duration, weekly, title, description) async {
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
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(DATABASE_PATH);
    var store = StoreRef.main();
    await store.record('habits').put(db, habits);
    //print("$title, $description, $weekly, $duration");
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
