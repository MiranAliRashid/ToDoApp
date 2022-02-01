import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/provider/tododate/todoData.dart';
import 'package:todo_app/screens/todo_screen/todo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => debugPrint('Firebase Initialized'));
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
