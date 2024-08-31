import 'package:flutter/material.dart';
import 'package:flutter_todo_app/contants/constant.dart';
import 'package:flutter_todo_app/models/todo.dart';
import 'package:flutter_todo_app/wigdet/todo_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todosList = Todo.todoList();
  late final TextEditingController _taskcontroller;
  List<Todo> _foundTodo = [];

  @override
  void initState() {
    _taskcontroller = TextEditingController();
    _foundTodo = todosList;
    super.initState();
  }

  @override
  void dispose() {
    _taskcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.tdBGColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: TColor.tdBGColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: TColor.tdBlack,
              size: 30.0,
            ),
            SizedBox(
              height: 40.0,
              width: 30.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset('assets/images/man-image.jpeg'),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(children: [
          _searchBar(),
          const SizedBox(
            height: 50.0,
          ),
          Expanded(
            child: _listView(),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialogue(context),
        backgroundColor: TColor.tdBlue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    );
  }

  _showAddTaskDialogue(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add New Task"),
            content: TextField(
              controller: _taskcontroller,
              decoration: const InputDecoration(hintText: "Enter task"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Closes the dialog
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                child: const Text("Add"),
                onPressed: () {
                  setState(() {
                    todosList.add(Todo(
                        id: DateTime.now().toString(),
                        todoText: _taskcontroller.text));
                  });
                  _taskcontroller.clear(); // Clear the text field
                  Navigator.of(context).pop(); // Closes the dialog
                },
              )
            ],
          );
        });
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: TextField(
          onChanged: (value) => runFilter(value),
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(
                Icons.search,
                color: TColor.tdBlack,
                size: 20.0,
              ),
              prefixIconConstraints:
                  BoxConstraints(maxHeight: 20.0, minWidth: 50.0),
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(color: TColor.tdGrey)),
        ),
      ),
    );
  }

  Widget _listView() {
    return ListView.builder(
      itemCount: _foundTodo.length,
      itemBuilder: (context, index) {
        return TodoItem(
          todo: _foundTodo[index],
          onTodoChange: _todoChange,
          onDelete: _todoDelete,
        );
      },
    );
  }

  void _todoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone!;
    });
  }

  void _todoDelete(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void runFilter(String enterKeyWord) {
    List<Todo> results = [];
    if (enterKeyWord.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) =>
              item.todoText!.toLowerCase().contains(enterKeyWord.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTodo = results;
    });
  }
}
