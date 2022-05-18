import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/group/create_group.dart';
import 'package:flutter_application_1/widgets/group/group_list.dart';
import 'package:flutter_application_1/widgets/task/create_task.dart';
import 'package:flutter_application_1/widgets/task/task_list.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(MaterialApp(
    home: const MainPage(),
    routes: <String, WidgetBuilder>{
      '/GroupListForm': (BuildContext context) => const GroupFormWidget(),
      '/TaskListForm': (BuildContext context) => const TaskListWidget(),
      '/CreateTask': (BuildContext context) => const TaskFormWidget(),
    },
  ));
}
