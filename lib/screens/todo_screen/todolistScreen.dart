import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/dataModel/todoModel.dart';
import 'package:todo_app/provider/tododate/todoData.dart';

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

    List<Todo> savedllist = saved!.map((data) {
      return Todo.fromMap(jsonDecode(data));
    }).toList();

    savedllist.forEach((element) {
      Provider.of<TodoData>(context, listen: false).dataaysnc(element.title!,
          element.content!, element.dueDate!, element.submitDate!);
    });
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
                          color: Colors.grey[200],
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
                                    Provider.of<TodoData>(context, listen: true)
                                        .Todos[index]
                                        .dueDate
                                        .toString()),
                                Text(
                                    Provider.of<TodoData>(context, listen: true)
                                        .Todos[index]
                                        .submitDate
                                        .toString())
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
