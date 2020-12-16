import 'dart:io';

import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String _imagePath;
  const ImageBox(this._imagePath, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.file(
        File(_imagePath),
      ),
    );
  }
}
