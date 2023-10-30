import 'package:flutter/cupertino.dart';

class Todo
{
    String? id;
    String? todoText;
    bool isDone;

    Todo ({
        required this.id,
        required this.todoText,
    this.isDone = false
});

    static List<Todo> todoList() {
        return [
            Todo(id: '01', todoText: 'Morning Workout', isDone: true),
            Todo(id: '02', todoText: 'Buy Veggies', isDone: true),
            Todo(id: '03', todoText: 'Check Mail', ),
            Todo(id: '04', todoText: 'Team Meeting', ),
            Todo(id: '05', todoText: 'Work on Projects', ),
            Todo(id: '06', todoText: 'Business Dinner', ),
        ];
    }
}