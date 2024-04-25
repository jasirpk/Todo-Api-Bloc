import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_api/bloc/todo_bloc.dart';
import 'package:todo_bloc_api/screens/add_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(InitialToDo());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'ToDo App',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddScreen()));
          },
          child: const Icon(Icons.add),
        ),
        body: BlocConsumer<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is ToDoEdided) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "Edited successfully",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.orange, // Choose a suitable color
              ));
            }
            if (state is TodoDeleted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "Deleted Succesfully",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ));
            }
            if (state is Addsuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "Added successfully",
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.green,
              ));
            }
          },
          builder: (context, state) {
            if (state is ToDoLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ToDoFetched) {
              if (state.todoList.isEmpty) {
                return const Center(
                  child: Text("No Data"),
                );
              }
              return ListView.builder(
                  itemCount: state.todoList.length,
                  itemBuilder: (context, index) {
                    final item = state.todoList[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(
                              "${index + 1}",
                            )),
                        title: Text(item.title),
                        subtitle: Text(item.description),
                        trailing: PopupMenuButton(onSelected: (value) {
                          if (value == 'edit') {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddScreen(
                                      todo: item,
                                    )));
                          } else if (value == 'delete') {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.blue[50],
                                title: const Text(
                                  "Are You Sure?",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                content: const Text(
                                  'This action will delete the item permanently.',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("No"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<TodoBloc>()
                                          .add(DeleteToDo(id: item.id));
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Yes"),
                                  ),
                                ],
                              ),
                            );
                          }
                        }, itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Text("Edit"),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text("delete"),
                            ),
                          ];
                        }),
                      ),
                    );
                  });
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
