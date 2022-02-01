import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/dataModel/todoModel.dart';
import 'package:todo_app/provider/tododate/todoData.dart';
import 'package:intl/intl.dart';

class todoScreen extends StatefulWidget {
  todoScreen({Key? key}) : super(key: key);

  @override
  State<todoScreen> createState() => _todoScreenState();
}

class _todoScreenState extends State<todoScreen> {
  @override
  readToDoData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? saved = preferences.getStringList('Todos');

    if (saved == null) {
      debugPrint('this firebase code aycn woekinggggg ======================<');
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore.collection('Todos').get().then(
        (value) async {
          for (int i = 0; i < value.docs.length; i++) {
            Provider.of<TodoData>(context, listen: false).addToDo(
              value.docs[i]['title'],
              value.docs[i]['content'],
              (value.docs[i]['dueDate']).toDate(),
              (value.docs[i]['submitDate']).toDate(),
              add_to_firebase: false,
            );
          }
        },
      );
    } else {
      debugPrint(
          'this sheard pre ff code aycn woekinggggg ======================<');
      try {
        List<Todo> savedllist = saved.map((data) {
          return Todo.fromMap(jsonDecode(data));
        }).toList();
        debugPrint(savedllist.toString());
        savedllist.forEach((element) {
          Provider.of<TodoData>(context, listen: false).dataaysnc(
              element.title!,
              element.content!,
              element.dueDate!,
              element.submitDate!);
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => readToDoData());
  }

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "todo or not to do",
            style: TextStyle(fontSize: 25),
          ),
          Container(
            height: 400,
            child: Provider.of<TodoData>(context, listen: true).Todos.isEmpty
                ? Center(
                    child: Text("you dont have any todos"),
                  )
                : ListView.builder(
                    itemCount: Provider.of<TodoData>(context, listen: true)
                        .Todos
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(5, 5),
                                blurRadius: 5)
                          ],
                        ),
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                  Provider.of<TodoData>(context, listen: true)
                                      .Todos[index]
                                      .title
                                      .toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                  Provider.of<TodoData>(context, listen: true)
                                      .Todos[index]
                                      .content
                                      .toString()),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  DateFormat('dd-MM-yyyy').format(
                                      Provider.of<TodoData>(context,
                                              listen: true)
                                          .Todos[index]
                                          .dueDate!),
                                ),
                                Text(
                                  DateFormat('dd-MM-yyyy').format(
                                      Provider.of<TodoData>(context,
                                              listen: true)
                                          .Todos[index]
                                          .submitDate!),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
