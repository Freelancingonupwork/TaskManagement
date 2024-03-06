import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/tasks/presentation/comman/router.dart';
import 'package:task_management/features/tasks/presentation/screen/task/bloc/task_bloc.dart';
import 'package:task_management/helper/utils.dart';

class TaskCreate extends StatefulWidget {
  const TaskCreate({super.key});

  @override
  State<TaskCreate> createState() => _TaskCreateState();
}

class _TaskCreateState extends State<TaskCreate> {
  TextEditingController txTitleController = TextEditingController();
  TextEditingController txDescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task Create",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        leading: const SizedBox(),
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state.status == TaskStatus.created) {
            showToast(Msg: 'Task Created successfully');
            txTitleController.clear();
            txDescriptionController.clear();
            context.read<TaskBloc>().add(const GetTask());
          }else if(state.status == TaskStatus.loaded){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, TaskState state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: txTitleController,
                    decoration: InputDecoration(
                        hintText: "Title",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black, width: 2))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: txDescriptionController,
                    maxLines: 5,
                    minLines: 3,
                    decoration: InputDecoration(
                        hintText: "Description",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black, width: 2))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        if (state.status != TaskStatus.loading) {
                          context.read<TaskBloc>().add(
                                CreateTask(
                                  formData: {
                                    "title": txTitleController.text,
                                    "description": txDescriptionController.text
                                  },
                                ),
                              );
                        }
                      },
                      child: SizedBox(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: state.status == TaskStatus.loading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  "Save Task".toUpperCase(),
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
