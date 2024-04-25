import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_api/bloc/todo_bloc.dart';
import 'package:todo_bloc_api/screens/home_screen.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => TodoBloc(),
    child: ToDoApplication(),
  ));
}

class ToDoApplication extends StatelessWidget {
  const ToDoApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
