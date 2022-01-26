import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/provider/tododate/todoData.dart';
import 'package:todo_app/screens/todo_screen/todo.dart';

void main() {
  runApp(Config());
}

class Config extends StatefulWidget {
  Config({Key? key}) : super(key: key);

  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoData()),
      ],
      child: MaterialApp(
        home: Todo(),
      ),
    );
  }
}
