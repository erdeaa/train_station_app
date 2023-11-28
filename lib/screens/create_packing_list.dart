import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:train_station_app/models/list.dart';
import 'package:train_station_app/screens/delete_packing_list.dart';

class TodoListTile extends StatelessWidget {
  final ListModel todo;
  final int index;
  final Function(int) onDelete;

  const TodoListTile({
    super.key,
    required this.todo,
    required this.index,
    required this.onDelete,
  });

  void _showDeleteConfirmationDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(
          onCancel: () {
            Navigator.of(context).pop();
          },
          onDelete: () {
            onDelete(index);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          todo.title,
          style: TextStyle(
            decoration:
                todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        leading: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: todo.isDone
                  ? const Color.fromARGB(255, 110, 43, 173)
                  : const Color.fromARGB(255, 110, 43, 173),
              width: 2,
            ),
          ),
          child: Center(
            child: todo.isDone
                ? const Icon(
                    Icons.check,
                    size: 16,
                    color: Color.fromARGB(255, 98, 74, 155),
                  )
                : null,
          ),
        ),
        onTap: () {
          final newTodo = ListModel(
            title: todo.title,
            isDone: !todo.isDone,
          );
          Hive.box<ListModel>('todos').putAt(index, newTodo);
        },
        //tile long press delete
        onLongPress: () {
          _showDeleteConfirmationDialog(context);
        },
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _showDeleteConfirmationDialog(context),
        ),
      ),
    );
  }
}
