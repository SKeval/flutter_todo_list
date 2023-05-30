import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController todoCont = TextEditingController();

  List<String> listOfTodo = [];

  List<String> listIsDone = [];

  int selectedTask = -1;

  //snack bar

  showMySnackbar(BuildContext context, String msg, {Color c = Colors.red}) {
    //snackbar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$msg'),
      backgroundColor: c,
    ));
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
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: listOfTodo.length,
              itemBuilder: (context, index) {
                bool isChecked = false;

                if (listIsDone.contains(listOfTodo[index])) {
                  isChecked = true;
                }

                return Card(
                  child: ListTile(
                    onTap: () {
                      print('tile clicked');
                      if (listIsDone.contains(listOfTodo[index])) {
                        listIsDone.remove(listOfTodo[index]);
                      } else {
                        listIsDone.add(listOfTodo[index]);
                        showMySnackbar(context, 'Task Done', c: Colors.green);
                      }
                      setState(() {
                        print('index : $index');
                        print(listIsDone);
                      });
                    },
                    title: Text(
                      listOfTodo[index],
                      style: const TextStyle(fontSize: 18),
                    ),
                    leading: IconButton(
                        onPressed: () {
                          setState(() {
                            selectedTask = index;
                            todoCont.text = listOfTodo[selectedTask];
                          });
                        },
                        icon: const Icon(Icons.edit)),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Checkbox(value: isChecked, onChanged: (val) {}),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  listIsDone.remove(listOfTodo[index]);
                                  listOfTodo.removeAt(index);
                                  print('index : $index');
                                  print(listIsDone);

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
                          listOfTodo[selectedTask] = todoCont.text.trim();
                          todoCont.clear();
                          selectedTask = -1;
                        });
                      } else {
                        //add new one
                        showMySnackbar(context, 'Task Added!', c: Colors.green);

                        setState(() {
                          print(todoCont.text.trim());
                          listOfTodo.add(todoCont.text.trim());
                          todoCont.clear();
                        });
                      }
                    },
                    child:
                        Text(selectedTask != -1 ? 'Update Task' : 'Add Task'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
