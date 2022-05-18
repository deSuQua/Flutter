// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/group/group_form_model.dart';

class GroupFormWidget extends StatefulWidget {
  const GroupFormWidget({Key? key}) : super(key: key);

  @override
  State<GroupFormWidget> createState() => _GroupFormWidgetState();
}

class _GroupFormWidgetState extends State<GroupFormWidget> {
  final _model = GroupFormWidgetModel();

  @override
  Widget build(BuildContext context) {
    return GroupFormWidgetModelProvider(
        model: _model, child: _GroupFormWidgetBody());
  }
}

class _GroupFormWidgetBody extends StatelessWidget {
  const _GroupFormWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupFormWidgetModelProvider.read(context)?.model;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => GroupFormWidgetModelProvider.read(context)
            ?.model
            .saveGroup(context),
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
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 20, top: 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                      padding: const EdgeInsets.only(left: 25, right: 20),
                      iconSize: 30,
                    ),
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        style: TextStyle(fontSize: 24),
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Новая группа'),
                        onChanged: (value) => model?.groupName = value,
                        onEditingComplete: () =>
                            GroupFormWidgetModelProvider.read(context)
                                ?.model
                                .saveGroup(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
