import 'package:flutter/material.dart';
import 'package:task_management/features/tasks/presentation/screen/splash/splash_screen.dart';
import 'package:task_management/features/tasks/presentation/screen/task/task_create.dart';
import 'package:task_management/features/tasks/presentation/screen/task/task_detail.dart';
import 'package:task_management/features/tasks/presentation/screen/task/task_screen.dart';

class AppRouter {
  static const ROUTE_SPLASH = "/splash";
  static const ROUTE_TASK = "/task";
  static const ROUTE_TASK_CREATE = "/task-create";
  static const ROUTE_TASK_DETAIL = "/task-detail";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE_SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case ROUTE_TASK:
        return MaterialPageRoute(builder: (_) => TaskScreen());

      case ROUTE_TASK_CREATE:
        return MaterialPageRoute(builder: (_) => TaskCreate());

      case ROUTE_TASK_DETAIL:
        return MaterialPageRoute(builder: (_) => TaskDetailScreen());

      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text("No route"))));
    }
  }
}