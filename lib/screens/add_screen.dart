// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_api/bloc/todo_bloc.dart';
import 'package:todo_bloc_api/models/todo_model.dart';

class AddScreen extends StatefulWidget {
  final TodoModel? todo;
  const AddScreen({
    super.key,
    this.todo,
  });

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late bool isedit;

  @override
  void initState() {
    super.initState();
    isedit = widget.todo == null ? false : true;
    titleController.text = widget.todo != null ? widget.todo!.title : "";
    descriptionController.text =
        widget.todo != null ? widget.todo!.description : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          !isedit ? 'Add ToDo ' : 'Edit ToDo',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is ToDoAdded) {
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: 'add title', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Descriprion',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: 'enter description',
                    border: OutlineInputBorder()),
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    !isedit
                        ? context.read<TodoBloc>().add(AddToDo(
                            title: titleController.text,
                            description: descriptionController.text))
                        : context.read<TodoBloc>().add(EditToDo(
                            title: titleController.text,
                            description: descriptionController.text,
                            id: widget.todo!.id));
                  },
                  icon: Icon(Icons.download),
                  label: Text(!isedit ? 'submit' : 'update'))
            ],
          ),
        ),
      ),
    );
  }
}
