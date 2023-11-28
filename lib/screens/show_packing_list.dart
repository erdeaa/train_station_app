import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:train_station_app/models/list.dart';
import 'package:train_station_app/screens/create_packing_list.dart';

import '../widgets/drawer.dart';
import 'custom_floating_action.dart';

class ShowPackingList extends StatefulWidget {
  const ShowPackingList({Key? key}) : super(key: key);

  @override
  State<ShowPackingList> createState() => _ShowPackingList();
}

class _ShowPackingList extends State<ShowPackingList> {
  final _todoBox = Hive.box<ListModel>('todos');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 98, 74, 155),
        centerTitle: true,
        title: const Text('CHECK LIST'),
      ),
      drawer: buildDrawer(context),
      body: ValueListenableBuilder(
        valueListenable: _todoBox.listenable(),
        builder: (context, Box<ListModel> box, _) {
          //check if list is empty
          if (box.length != 0) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final todo = box.getAt(index)!;
                  return TodoListTile(
                    todo: todo,
                    index: index,
                    onDelete: _deleteTodo,
                  );
                },
              ),
            );
          }
          //text when list is empty
          else {
            return const Center(
              child: Text(
                  "Press the \"+\" button at the bottom right to add your list."),
            );
          }
        },
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: _addTodo,
      ),
    );
  }

  void _addTodo(String list) {
    final todo = ListModel(title: list);
    _todoBox.add(todo);
  }

  void _deleteTodo(int index) {
    _todoBox.deleteAt(index);
  }
}
