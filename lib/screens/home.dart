import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/widgets/todo_item.dart';

class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = Todo.todoList();
  List<Todo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _foundToDo = todosList;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBgColor,
      appBar: AppBar(
        backgroundColor: tdBgColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.jpeg'),
            ),
          )
        ],),
      ),

      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                searchBox(),
                Expanded(child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 50,
                        bottom: 20,
                      ),
                      child: Text(
                        'All Pending Work!',
                        style: TextStyle(fontSize: 30,
                        fontWeight: FontWeight.w600),
                      ),
                    ),
                    for(Todo todo in _foundToDo.reversed)
                      TodoItem(todo: todo, 
                      onToDoChanged: _handleToDoChange,
                        onDeleteItem: _deleteToDoChange,
                      )],
                ))
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 0),
                      blurRadius: 10,
                      spreadRadius: 0,
                    )],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Add a New Task!',
                      border: InputBorder.none
                    ),
                  ),
                )
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20),
                      child: ElevatedButton(
                        child: Text('+', style: TextStyle(fontSize: 40),),
                        onPressed: () {
                          _addToDoItem(_todoController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tdBlue,
                          minimumSize: Size(60, 60),
                          elevation: 10,
                        ),
                      ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  void _handleToDoChange(Todo todo)
  {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoChange(String id)
  {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String todo)
  {
    setState(() {
      todosList.add(Todo(id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword)
  {
    List<Todo> result = [];
    // if blank space is entered
    if(enteredKeyword.isEmpty)
      {
        result = todosList;
      }
    else
      {
        result = todosList
            .where((item) => item.todoText !
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase()))
            .toList();
      }

    setState(() {
      _foundToDo = result;
    });

  }

  Widget searchBox()
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

}

