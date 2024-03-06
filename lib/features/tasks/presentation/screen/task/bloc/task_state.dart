part of 'task_bloc.dart';

enum TaskStatus { initial, loading, loaded, created, deleted, failure }

class TaskState extends Equatable {
  const TaskState({this.status = TaskStatus.initial, this.res, this.msg});

  final dynamic res;
  final String? msg;
  final TaskStatus status;

  @override
  List<Object?> get props => [status, msg, res];

  TaskState copyWith({dynamic res, String? msg, TaskStatus? status}) {
    return TaskState(res: res, msg: msg, status: status ?? this.status);
  }
}
