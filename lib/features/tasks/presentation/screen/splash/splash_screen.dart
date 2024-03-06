import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_management/features/tasks/presentation/comman/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSplash();
  }

  startSplash() async {
    return Timer(Duration(seconds: 2), () {
      Navigator.popAndPushNamed(context, AppRouter.ROUTE_TASK);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Text(
          "TASK MANAGEMENT",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
