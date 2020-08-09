import 'dart:io';

class MyFileObject{
  String fileName;
  bool isDataFilled;

  MyFileObject.fromStat(FileStat fileStat){
    this.fileName = fileStat.mode as String;
  }

  setData(FileStat fileStat) {
    this.fileName = fileStat.mode as String;
  }
}