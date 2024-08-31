import 'package:flutter/material.dart';
import 'package:flutter_todo_app/contants/constant.dart';
import 'package:flutter_todo_app/models/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(
      {super.key, required this.todo, this.onTodoChange, required this.onDelete});
  final Todo todo;
  final void Function(Todo)? onTodoChange;
  final void Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        onTap: () => onTodoChange?.call(todo),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone! ? Icons.check_box : Icons.check_box_outline_blank,
          color: TColor.tdBlue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16.0,
              color: TColor.tdBlack,
              decoration: todo.isDone! ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            height: 35.0,
            width: 35.0,
            decoration: BoxDecoration(
              color: TColor.tdRed,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: IconButton(
              color: Colors.white,
              iconSize: 18.0,
              icon: const Icon(Icons.delete),
              onPressed: () => onDelete.call(todo.id!),
            )),
      ),
    );
  }
}
