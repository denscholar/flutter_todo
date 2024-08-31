class Todo {
  final String? id;
  final String? todoText;
  bool? isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<Todo> todoList() {
    return [
      Todo(id: '01', todoText: 'Morning Excersize', isDone: true),
      Todo(id: '02', todoText: 'night Excersize', isDone: true),
      Todo(id: '03', todoText: 'team meeting'),
      Todo(id: '04', todoText: 'check email'),
      Todo(id: '05', todoText: 'work on mobile apps for 2 hrs'),
      Todo(id: '06', todoText: 'dinner with chimamanda'),
    ];
  }
}
