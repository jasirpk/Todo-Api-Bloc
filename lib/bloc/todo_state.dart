part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

class ToDoLoading extends TodoState {}

class ToDoFetched extends TodoState {
  final List<TodoModel> todoList;
  ToDoFetched({required this.todoList});
}

class ToDoAdded extends TodoState {}

class Addsuccess extends TodoState {}

class ToDoAddingError extends TodoState {
  final String error;
  ToDoAddingError(this.error);
}

class ToDoEdided extends TodoState {}

final class ToDoEditingError extends TodoState {
  final String error;
  ToDoEditingError(this.error);
}

class TodoDeleted extends TodoState {}

class DeletionError extends TodoState {
  final String error;
  DeletionError(this.error);
}
