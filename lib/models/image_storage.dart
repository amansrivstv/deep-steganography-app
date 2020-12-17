import 'package:flutter/material.dart';

class ImageStorage extends ChangeNotifier {
  String encodeInputOnePath;
  String encodeInputTwoPath;
  String encodeOutputPath;

  String decodeInputPath;
  String decodeOutputOnePath;
  String decodeOutputTwoPath;

  void notify() {
    notifyListeners();
  }
}
