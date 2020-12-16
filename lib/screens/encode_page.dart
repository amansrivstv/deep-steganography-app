import 'package:deep_steganography_app/utils/theme_data.dart';
import 'package:flutter/material.dart';

class EncodePage extends StatefulWidget {
  EncodePage({Key key}) : super(key: key);

  @override
  _EncodePageState createState() => _EncodePageState();
}

class _EncodePageState extends State<EncodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Encode Page"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
      ),
    );
  }
}
