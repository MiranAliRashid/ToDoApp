import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/dataModel/todoModel.dart';

class TodoData extends ChangeNotifier {
  List<Todo> Todos = [];

  // the variable we want to have access in all screens

  Future<void> addToDo(
      String title, String content, DateTime dueDate, DateTime submitDate,
      {bool add_to_firebase = true}) async {
    Todos.add(
      Todo(
        title: title,
        content: content,
        dueDate: dueDate,
        submitDate: submitDate,
      ),
    ); // add value to dotos
    List<String> todopre =
        Todos.map((data) => jsonEncode(data.toMap())).toList();
    // List<String> todopre =
    //     Todos.map((task) => jsonEncode(task.toJson())).toList();

    SharedPreferences toDoPref = await SharedPreferences.getInstance();
    await toDoPref.setStringList('Todos', todopre);
    notifyListeners(); // to let all other widgets that listen to this class be updated

    if (add_to_firebase == true) {
      FirebaseFirestore addtoFirestore = FirebaseFirestore.instance;
      addtoFirestore.collection('Todos').add(
        {
          'title': title,
          'content': content,
          'dueDate': dueDate,
          'submitDate': submitDate,
        },
      );
    }
    debugPrint('successfuly added todo to firestore');
  } //the method to change the value of some variable inside this class

  dataaysnc(
      String title, String content, DateTime dueDate, DateTime submitDate) {
    Todos.add(
      Todo(
        title: title,
        content: content,
        dueDate: dueDate,
        submitDate: submitDate,
      ),
    ); // add value to dotos
    notifyListeners(); // to let all other widgets that listen to this class be updated
  }
}
