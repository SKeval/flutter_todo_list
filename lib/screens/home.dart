import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_todo_list/model/taskmodel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController todoCont = TextEditingController();

  int selectedTask = -1;

  //List<String> listStudent = ["raj", 'Keval', 'bHemal', "Kisu", 'Dharuv'];
  List<TaskModel> listTask = [];
  //snack bar

  showMySnackbar(BuildContext context, String msg, {Color c = Colors.red}) {
    //snackbar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$msg'),
      backgroundColor: c,
    ));
  }

  // int count = 1;
  // Timer? timer;

  // showTimer() {
  //   timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     setState(() {
  //       count++;
  //     });

  //     if (count > 10) {
  //       timer.cancel();
  //     }
  //   });
  // }

  String getCurrentDate() {
    String str = DateTime.now().toString();
    return str.split(' ')[0];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    todoCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Example Todo"),
        ),
        body: todoBody()

        /*
       Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.blueGrey[600],
                  height: 100,
                  child: Center(
                      child: Text(
                    "$count",
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  )),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              timer!.cancel();
            },
            child: Text('Stop Timer'),
          )
        ],
      ),
      */
        );
  }

  /*
 //important
        children: listStudent
            .map((e) => ListTile(
                  title: Text(e),
                ))
            .toList(),
      ),

  */

  Widget todoBody() {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: listTask.length,
            itemBuilder: (context, index) {
              bool isChecked = false;

              if (listTask[index].ischeck) {
                isChecked = true;
              }

              return Card(
                child: ListTile(
                  onTap: () {
                    print('tile clicked');
                    if (listTask[index].ischeck) {
                      listTask[index].ischeck = false;
                    } else {
                      listTask[index].ischeck = true;
                      showMySnackbar(context, 'Task Done', c: Colors.green);
                    }
                    setState(() {
                      print('index : $index');
                      print(listTask.toString());
                    });
                  },
                  title: Text(
                    listTask[index].title,
                    style: const TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    listTask[index].dateoftodo,
                    style: const TextStyle(fontSize: 16),
                  ),
                  leading: IconButton(
                      onPressed: () {
                        setState(() {
                          selectedTask = index;
                          todoCont.text = listTask[selectedTask].title;
                        });
                      },
                      icon: const Icon(Icons.edit)),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        Checkbox(
                            value: isChecked,
                            onChanged: (val) {
                              //code to change
                            }),

                        //code to delete
                        IconButton(
                            onPressed: () {
                              setState(() {
                                listTask.removeAt(index);
                                print('index : $index');
                                print(listTask.toString());

                                showMySnackbar(context, 'Task Deleted !');
                              });
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
                // child: Container(
                //   padding: EdgeInsets.all(18),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         listOfTodo[index],
                //         style: const TextStyle(fontSize: 18),
                //       ),
                //       Checkbox(
                //           value: isChecked,
                //           onChanged: (val) {
                //             if (listIsDone.contains(listOfTodo[index])) {
                //               listIsDone.remove(listOfTodo[index]);
                //             } else {
                //               listIsDone.add(listOfTodo[index]);
                //             }
                //             setState(() {
                //               print('index : $index');
                //               print(listIsDone);
                //             });
                //           })
                //     ],
                //   ),
                // ),
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 6,
              );
            },
          ),
          // ListView(
          //   //shrinkWrap: true,
          //   children: [
          //     Text(listOfTodo[0]),
          //     Text(listOfTodo[1]),
          //     Text(listOfTodo[2]),
          //   ],
          // ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: todoCont,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Enter Todo',
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (selectedTask != -1) {
                      //edit / update

                      setState(() {
                        listTask[selectedTask].title = todoCont.text.trim();
                        todoCont.clear();
                        selectedTask = -1;
                      });
                    } else {
                      //add new one
                      showMySnackbar(context, 'Task Added!', c: Colors.green);

                      setState(() {
                        print(todoCont.text.trim());
                        listTask.add(TaskModel(
                            title: todoCont.text.trim(),
                            dateoftodo: getCurrentDate()));

                        todoCont.clear();
                      });
                    }
                  },
                  child: Text(selectedTask != -1 ? 'Update Task' : 'Add Task'))
            ],
          ),
        )
      ],
    );
  }
}
