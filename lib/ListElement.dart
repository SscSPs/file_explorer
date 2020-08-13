import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class FileListElement extends StatefulWidget {
  final FileSystemEntity fileObject;
  final FileSystemEntityType type;
  final FileStat fileStat;
  final List<FileSystemEntity> children;

  FileListElement(this.fileObject, this.type, this.fileStat, this.children);

  factory FileListElement.fromPath(String path) {
    FileSystemEntity fse;
    FileSystemEntityType fseType = FileSystemEntity.typeSync(path);
    List<FileSystemEntity> children = new List();
    switch (fseType) {
      case FileSystemEntityType.directory:
        Directory temp = new Directory(path);
        fse = temp;
        children.add(fse.parent);
        Permission.storage.request();
        children.addAll(temp.listSync());
        break;
      case FileSystemEntityType.file:
        fse = new File(path);
        break;
      case FileSystemEntityType.link:
        fse = new Link(path);
        break;
      case FileSystemEntityType.notFound:
        throw new FileSystemException(
            "The path provided is not present in filesystem.", path);
    }

    return new FileListElement(fse, fseType, fse.statSync(), children);
  }

  _FileListElement createState() => _FileListElement();
}

class _FileListElement extends State<FileListElement> {
  @override
  Widget build(BuildContext context) {
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: ListView.builder(
          itemCount: widget.children.length,
          itemBuilder: (context, index) {
            final item = widget.children[index];
            return ListTile(
              title: new Text(index == 0
                  ? ".."
                  : item.path.replaceAll(item.parent.path + "/", "")),
              subtitle: new Text(item.statSync().size.toString()),
            );
          }),
    );
  }
}
