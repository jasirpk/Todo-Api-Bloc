part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

final class AddToDo extends TodoEvent {
  final String title;
  final String description;
  AddToDo({required this.title, required this.description});
}

final class EditToDo extends TodoEvent {
  final String id;
  final String title;
  final String description;
  EditToDo({required this.title, required this.description, required this.id});
}

final class DeleteToDo extends TodoEvent {
  final String id;
  DeleteToDo({required this.id});
}

final class InitialToDo extends TodoEvent {}
