part of 'task_bloc.dart';

//enum TaskEvent { loadTasks, createTask, deleteTask }

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {
  const LoadTasks();
}

class CreateTask extends TaskEvent {
  const CreateTask({required this.formData});

  final Map<String, dynamic> formData;

  @override
  List<Object> get props => [formData];
}

class GetTask extends TaskEvent {
  const GetTask();

  @override
  List<Object> get props => [];
}

class DeleteTask extends TaskEvent {
  const DeleteTask({required this.taskId});

  final int taskId;

  @override
  List<Object> get props => [taskId];
}
