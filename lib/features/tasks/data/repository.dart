// Interface for TaskRepository
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/features/tasks/data/db_helper.dart';
import 'package:task_management/features/tasks/data/model.dart';

class TaskRepository {
  static const _tasksKey = 'tasks'; // Remove this line (not used now)

  final DbHelper dbHelper = DbHelper();

  Future<List<Task>> getTasks() async {
    return await dbHelper.getTasks();
  }

  Future<dynamic> saveTask(Task task) async {
    return await dbHelper.saveTask(task);
  }

  Future<dynamic> deleteTask(int taskId) async {
    return await dbHelper.deleteTask(taskId);
  }
}
