import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/features/tasks/data/model.dart';
import 'package:task_management/features/tasks/data/repository.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<CreateTask>(_onCreateTask);
    on<GetTask>(_onGetTask);
    on<DeleteTask>(_onDeleteTask);
  }

  _onCreateTask(
    CreateTask event,
    Emitter<TaskState> emit,
  ) async {
    try {
      emit(state.copyWith(status: TaskStatus.loading, res: null));
      Task myTask =
          Task(id: Random().nextInt(1000), title: event.formData["title"], description: event.formData["description"]);
      var result = await TaskRepository().saveTask(myTask);
      emit(state.copyWith(status: TaskStatus.created, res: result));
    } catch (error) {
      emit(state.copyWith(status: TaskStatus.failure, res: null));
    }
  }

  _onGetTask(
    GetTask event,
    Emitter<TaskState> emit,
  ) async {
    try {
      emit(state.copyWith(status: TaskStatus.loading, res: null));

      var result = await TaskRepository().getTasks();

      emit(state.copyWith(status: TaskStatus.loaded, res: result));
    } catch (error) {
      emit(
        state.copyWith(
          status: TaskStatus.failure,
          res: state.res,
        ),
      );
    }
  }

  _onDeleteTask(
    DeleteTask event,
    Emitter<TaskState> emit,
  ) async {
    try {
      emit(state.copyWith(status: TaskStatus.loading, res: null));

      await TaskRepository().deleteTask(event.taskId);
      var resultData = await TaskRepository().getTasks();

      emit(state.copyWith(status: TaskStatus.deleted, res: resultData));
    } catch (error) {
      emit(
        state.copyWith(
          status: TaskStatus.failure,
          res: state.res,
        ),
      );
    }
  }
}
