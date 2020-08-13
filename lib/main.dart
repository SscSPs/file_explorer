import 'dart:io';

import 'package:file_explorer/ListElement.dart';
import 'package:file_explorer/data.dart';
import 'package:flutter/material.dart';
import 'package:ms_material_color/ms_material_color.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MsMaterialColor.fromARGB(255, 0, 0, 0),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  final String currentPath = Data.startPath;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    Permission.storage.request();
    Permission.storage.status.then((value) => print(value));
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.currentPath),
        ),
        body: FileListElement.fromPath(widget.currentPath),
        // This trailing comma makes auto-formatting nicer for build methods.
      );

  }
}
