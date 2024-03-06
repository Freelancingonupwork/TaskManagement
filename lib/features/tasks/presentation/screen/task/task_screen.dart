import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/tasks/data/model.dart';
import 'package:task_management/features/tasks/presentation/comman/router.dart';
import 'package:task_management/features/tasks/presentation/screen/task/bloc/task_bloc.dart';
import 'package:task_management/helper/utils.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TaskBloc>().add(const GetTask());
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks", style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
        leading: const SizedBox(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRouter.ROUTE_TASK_CREATE);
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: BlocConsumer<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state.status == TaskStatus.deleted) {
              showToast(Msg: 'Task Delete successfully');
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state.status == TaskStatus.loading || state.status == TaskStatus.initial) {
              return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  semanticsLabel: 'Circular progress indicator',
                ),
              );
            } else if (state.status == TaskStatus.failure) {
              return Text(
                "something went to wrong",
                style: Theme.of(context).textTheme.headlineSmall,
              );
            } else if (state.status == TaskStatus.deleted || state.status == TaskStatus.loaded) {
              List<Task> data = state.res;
              if(data.isEmpty){

                return Align(
                  alignment: Alignment.center,
                  child: Text("No Task Found",style: Theme.of(context).textTheme.titleLarge,),
                );
              }else{

                return ListView.separated(
                  itemCount: data.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${data[index].title}",
                                    style: Theme.of(context).textTheme.titleLarge,
                                    maxLines: 2,
                                  ),
                                  Text(
                                    "${data[index].description}",
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    maxLines: 2,
                                  ),
                                ],
                              )
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Delete'),
                                  content: const Text('Are you sure you went to delete'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.read<TaskBloc>().add(DeleteTask(taskId: data[index].id ?? 0));
                                      },
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.delete_forever,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 5,
                      color: Colors.grey,
                      endIndent: 5,
                      indent: 5,
                      thickness: 2,
                    );
                  },
                );
              }
            } else {
              return Text(
                "something went to wrong",
                style: Theme.of(context).textTheme.headlineSmall,
              );
            }
          },
        ),
      ),
    );
  }
}
