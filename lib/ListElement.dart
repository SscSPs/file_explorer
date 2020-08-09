import 'dart:io';

import 'package:flutter/material.dart';

class FileListElement extends StatefulWidget {
  final FileSystemEntity fileObject;
  final FileSystemEntityType type;
  final FileStat fileStat;

  FileListElement(this.fileObject, this.type, this.fileStat);

  factory FileListElement.fromPath(String path) {
    FileSystemEntity fse;
    FileSystemEntityType fseType = FileSystemEntity.typeSync(path);
    switch (fseType) {
      case FileSystemEntityType.directory:
        fse = new Directory(path);
        break;
      case FileSystemEntityType.file:
        fse = new File(path);
        break;
      case FileSystemEntityType.link:
        fse = new Link(path);
        break;
      case FileSystemEntityType.notFound:
        throw new FileSystemException("The path provided is not present in filesystem.", path);
    }

    return new FileListElement(fse, fseType, fse.statSync());
  }

  _FileListElement createState() => _FileListElement();
}

class _FileListElement extends State<FileListElement> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
