import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_bloc_api/models/todo_model.dart';
import 'package:todo_bloc_api/services/repository.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<AddToDo>(addTodo);
    on<InitialToDo>(initialToDoFetch);
    on<DeleteToDo>(deleteToDo);
    on<EditToDo>(editToDo);
  }

  initialToDoFetch(InitialToDo event, Emitter<TodoState> emit) async {
    emit(ToDoLoading());
    try {
      final values = await fetchdata();
      final List<TodoModel> items = [];
      for (int i = 0; i < values.length; i++) {
        items.add(TodoModel(
            id: values[i]["_id"],
            title: values[i]['title'],
            description: values[i]['description']));
      }
      emit(ToDoFetched(todoList: items));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  addTodo(AddToDo event, Emitter<TodoState> emit) async {
    emit(ToDoAdded());
    emit(ToDoLoading());
    try {
      final result = await submitData(event.title, event.description);
      if (result == 'success') {
        emit(Addsuccess());
        add(InitialToDo());
      }
    } catch (e) {
      emit(ToDoAddingError(e.toString()));
      add(InitialToDo());
    }
  }

  deleteToDo(DeleteToDo event, Emitter<TodoState> emit) async {
    emit(ToDoLoading());
    try {
      final result = await deleteData(event.id);
      if (result == "success") {
        emit(TodoDeleted());
        add(InitialToDo());
      }
    } catch (e) {
      emit(DeletionError(e.toString()));
      add(InitialToDo());
    }
  }

  editToDo(EditToDo event, Emitter<TodoState> emit) async {
    emit(ToDoAdded());
    emit(ToDoLoading());
    try {
      final result = await updateData(event.id, event.title, event.description);
      if (result == "success") {
        add(InitialToDo());
      } else {
        emit(ToDoEditingError("error in updating"));
        add(InitialToDo());
      }
    } catch (e) {
      emit(ToDoEditingError(e.toString()));
    }
  }

  @override
  void onTransition(Transition<TodoEvent, TodoState> transition) {
    if (kDebugMode) {
      print(transition);
    }
    super.onTransition(transition);
  }
}
