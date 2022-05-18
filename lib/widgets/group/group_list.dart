// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'group_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _model = GroupWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GroupWidgetModelProvider(model: _model, child: MainPageForm());
  }
}

class _GroupTaskListWidget extends StatelessWidget {
  final int indexInGroup;
  const _GroupTaskListWidget({Key? key, required this.indexInGroup})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupWidgetModelProvider.read(context)!.model;
    final group =
        GroupWidgetModelProvider.read(context)!.model.groups[indexInGroup];
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              model.deleteGroup(indexInGroup);
            },
            backgroundColor: Color.fromARGB(255, 255, 134, 134),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Удалить',
          )
        ],
      ),
      child: ListTile(
          title: Text(
            group.name,
            style: TextStyle(fontSize: 20),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => model.showTask(context, indexInGroup)),
    );
  }
}

class MainPageForm extends StatefulWidget {
  const MainPageForm({Key? key}) : super(key: key);

  @override
  State<MainPageForm> createState() => _MainPageFormState();
}

class _MainPageFormState extends State<MainPageForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/GroupListForm');
        },
        tooltip: 'Создать группу',
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Группы',
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
      body: _GroupList(),
      bottomNavigationBar: BottomAppBar(
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
    );
  }
}

class _GroupList extends StatelessWidget {
  const _GroupList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupCount =
        GroupWidgetModelProvider.watch(context)?.model.groups.length ?? 0;
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: SizedBox(
          height: 672,
          width: 800,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 20, right: 10),
            scrollDirection: Axis.vertical,
            itemCount: groupCount,
            separatorBuilder: (BuildContext context, int groupIndex) =>
                Divider(height: 5),
            itemBuilder: (BuildContext context, int groupIndex) {
              return _GroupTaskListWidget(
                indexInGroup: groupIndex,
              );
            },
          ),
        ),
      ),
    );
  }
}
