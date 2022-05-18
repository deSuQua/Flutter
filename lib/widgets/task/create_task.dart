// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/task/create_task_model.dart';

class TaskFormWidget extends StatefulWidget {
  const TaskFormWidget({Key? key}) : super(key: key);

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  TaskFormWidgetModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TaskFormWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TaskFormWidgetModelProvider(
        model: _model!, child: _TaskFormWidgetBody());
  }
}

class _TaskFormWidgetBody extends StatelessWidget {
  const _TaskFormWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskFormWidgetModelProvider.read(context)?.model;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            TaskFormWidgetModelProvider.read(context)?.model.saveTask(context),
        backgroundColor: Colors.white,
        shape: StadiumBorder(side: BorderSide(color: Colors.black, width: 1)),
        label: Text(
          'Сохранить',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    padding: const EdgeInsets.only(left: 10, top: 1),
                    iconSize: 24,
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 20),
                  child: Flexible(
                    child: TextField(
                      maxLines: null,
                      autofocus: true,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) => model?.taskText = value,
                      onEditingComplete: () => model?.saveTask(context),
                      style: TextStyle(
                          fontSize: 24, color: Colors.black.withOpacity(0.8)),
                      decoration: InputDecoration(
                        hintText: 'Новая задача',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
