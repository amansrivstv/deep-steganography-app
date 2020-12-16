import 'package:deep_steganography_app/utils/theme_data.dart';
import 'package:flutter/material.dart';

class DecodePage extends StatefulWidget {
  DecodePage({Key key}) : super(key: key);

  @override
  _DecodePageState createState() => _DecodePageState();
}

class _DecodePageState extends State<DecodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Decode Page"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
      ),
    );
  }
}
