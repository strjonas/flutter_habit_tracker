import 'package:flutter/material.dart';
import 'main.dart';

class HabitView extends StatefulWidget {
  const HabitView({Key? key, this.habits}) : super(key: key);

  final habits;

  @override
  _HabitViewState createState() => _HabitViewState();
}

final _biggerFont = const TextStyle(fontSize: 18.0);

class _HabitViewState extends State<HabitView> {
  @override
  Widget build(BuildContext context) {
    var habits = widget.habits;
    final tiles = habits.map<Widget>((habit) {
      return Dismissible(
        key: Key(habit["id"]!),
        background: Container(
          alignment: AlignmentDirectional.centerStart,
          color: Colors.red,
          child: Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (direction) {
          setState(() {
            habits.removeAt(habits.indexOf(habits));
          });
          storage.setItem('habits', habit["id"]);

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Dismissed!')));
        },
        child: ListTile(
            title: Text(
              habit["title"]!,
              style: habit["thisweek"] == "0"
                  ? TextStyle(decoration: TextDecoration.lineThrough)
                  : _biggerFont,
            ),
            trailing: Icon(
                habit["thisweek"] == "0" ? Icons.check_circle : Icons.add,
                color: habit["isdone"] == "true"
                    ? Colors.greenAccent
                    : Colors.red[300]),
            onTap: () {
              // goto detailed view
            }),
      );
    });

    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(context: context, tiles: tiles).toList()
        : <Widget>[];
    return ListView(children: divided);
  }
}
