import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keep_clean/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';

import 'package:keep_clean/model/task.dart';

import 'notifier/setting_notifier.dart';





class TaskListPage extends StatelessWidget {
  TaskListPage(this.name);
  String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KBOYのFlutter大学'),
      ),
      body: Container(
        color: Colors.red,
        child: Text(name),
      ),
    );
  }
}