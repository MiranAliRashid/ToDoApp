import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/provider/tododate/todoData.dart';
import 'package:todo_app/screens/todo_screen/todolistScreen.dart';

class Todo extends StatefulWidget {
  Todo({Key? key}) : super(key: key);

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  int _selectedIndex = 0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  DateTime? dueDate;
  DateTime? submitDate;

//func todo screen

//list for bot nav
  List<Widget> screens = <Widget>[
    todoScreen(),
    Text(
      'not working for now2',
    ),
    Text(
      'not working for now3',
    ),
  ];
  //change bot nav
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return _showMaterialDialog(context);
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        alignment: Alignment.center,
        child: screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hourglass_top),
            label: 'Doing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check),
            label: 'Done',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.black87,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.white38,
        onTap: _onItemTapped,
      ),
    );
  }

  _showMaterialDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add ToDo'),
            content: Container(
              alignment: Alignment.center,
              width: 300,
              height: 240,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: title,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "title must not be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Title", border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: content,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "context must not be empty";
                        }
                        return null;
                      },
                      maxLines: 3,
                      decoration: InputDecoration(
                          labelText: "content", border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2040),
                              ).then((selectedDate) {
                                if (selectedDate == null) {
                                  return;
                                } else {
                                  setState(() {
                                    dueDate = selectedDate;
                                    submitDate = DateTime.now();
                                  });
                                }
                              });
                            },
                            child: Text("Due Date"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (dueDate != null || submitDate != null) {
                        Provider.of<TodoData>(context, listen: false).addToDo(
                            title.value.text,
                            content.value.text,
                            dueDate!,
                            submitDate!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              backgroundColor: Colors.greenAccent,
                              content: Text('ToDo is successfuly add Data')),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.redAccent,
                                content: Text('please select a Date')));
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text('save')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('cancel'),
              )
            ],
          );
        });
  }
}
