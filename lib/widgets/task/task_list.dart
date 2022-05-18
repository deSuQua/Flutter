// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/task/task_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({Key? key}) : super(key: key);

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  TaskWidgetModel? _model;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TaskWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final model = _model;
    return TaskWidgetModelProvider(
        model: _model!, child: const TaskWidgetBody());
  }
}

class TaskWidgetBody extends StatelessWidget {
  const TaskWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskWidgetModelProvider.watch(context)?.model;
    final title = model?.group?.name ?? 'Задачи';
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          title,
          style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w300),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          model?.createTask(context);
          // Navigator.of(context).pop();
        },
        tooltip: 'Создать задачу',
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert, color: Colors.white)),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: const _TaskList(),
    );
  }
}

class _TaskList extends StatefulWidget {
  const _TaskList({Key? key}) : super(key: key);

  @override
  State<_TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<_TaskList> {
  @override
  Widget build(BuildContext context) {
    final taskCount =
        TaskWidgetModelProvider.watch(context)?.model.task.length ?? 0;
    return SizedBox(
      height: 630,
      width: double.infinity,
      child: ListView.separated(
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          return _TaskListWidget(
            indexInList: index,
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 5),
        itemCount: taskCount,
      ),
    );
  }
}

class _TaskListWidget extends StatelessWidget {
  final int indexInList;
  const _TaskListWidget({Key? key, required this.indexInList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskWidgetModelProvider.read(context)!.model;
    final task = model.task[indexInList];
    final style = task.isDone
        ? const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 20)
        : const TextStyle(fontSize: 20);
    final icon = task.isDone ? Icons.check_box : Icons.check_box_outline_blank;
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => model.deleteTask(indexInList),
            backgroundColor: Color.fromARGB(255, 255, 134, 134),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Удалить',
          )
        ],
      ),
      child: ListTile(
        title: Text(
          task.text,
          style: style,
        ),
        trailing: Icon(
          icon,
          size: 30,
        ),
        onTap: () => model.toggleDone(indexInList),
      ),
    );
  }
}
