import 'package:deep_steganography_app/state/providers.dart';
import 'package:deep_steganography_app/utils/theme_data.dart';
import 'package:deep_steganography_app/widgets/image_box.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:image_picker/image_picker.dart';

class EncodePage extends StatefulWidget {
  EncodePage({Key key}) : super(key: key);

  @override
  _EncodePageState createState() => _EncodePageState();
}

class _EncodePageState extends State<EncodePage> {
  final picker = ImagePicker();

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
          child: Consumer(
            builder: (BuildContext context,
                T Function<T>(ProviderBase<Object, T>) watch, Widget child) {
              final imageStorage = watch(imageProvider);

              return Column(
                children: [
                  Spacer(flex: 1),
                  Expanded(
                    flex: 6,
                    child: Row(
                      children: [
                        Spacer(flex: 1),
                        Expanded(
                          flex: 8,
                          child: Column(
                            children: [
                              Text("Input Image One"),
                              SizedBox(height: 6.0),
                              Expanded(
                                child: imageStorage.encodeInputOnePath == null
                                    ? DottedBorder(
                                        color: Colors.grey,
                                        strokeWidth: 1,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                          ),
                                          child: Column(
                                            children: [
                                              RaisedButton.icon(
                                                onPressed: () async {
                                                  final pickedFile =
                                                      await picker.getImage(
                                                          source: ImageSource
                                                              .camera);

                                                  if (pickedFile != null) {
                                                    context
                                                            .read(imageProvider)
                                                            .encodeInputOnePath =
                                                        pickedFile.path;
                                                    context
                                                        .read(imageProvider)
                                                        .notify();
                                                  }
                                                },
                                                icon: Icon(Icons.camera),
                                                label: Text("Open Camera"),
                                              ),
                                              RaisedButton.icon(
                                                onPressed: () async {
                                                  final pickedFile =
                                                      await picker.getImage(
                                                          source: ImageSource
                                                              .gallery);

                                                  if (pickedFile != null) {
                                                    context
                                                            .read(imageProvider)
                                                            .encodeInputOnePath =
                                                        pickedFile.path;
                                                    context
                                                        .read(imageProvider)
                                                        .notify();
                                                  }
                                                },
                                                icon: Icon(Icons.image),
                                                label: Text("Open Gallery"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : ImageBox(imageStorage.encodeInputOnePath),
                              ),
                            ],
                          ),
                        ),
                        Spacer(flex: 1),
                        Expanded(
                          flex: 8,
                          child: Column(
                            children: [
                              Text("Input Image Two"),
                              SizedBox(height: 6.0),
                              Expanded(
                                child: imageStorage.encodeInputTwoPath == null
                                    ? DottedBorder(
                                        color: Colors.grey,
                                        strokeWidth: 1,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                          ),
                                          child: Column(
                                            children: [
                                              RaisedButton.icon(
                                                onPressed: () async {
                                                  final pickedFile =
                                                      await picker.getImage(
                                                          source: ImageSource
                                                              .camera);

                                                  if (pickedFile != null) {
                                                    context
                                                            .read(imageProvider)
                                                            .encodeInputTwoPath =
                                                        pickedFile.path;
                                                    context
                                                        .read(imageProvider)
                                                        .notify();
                                                  }
                                                },
                                                icon: Icon(Icons.camera),
                                                label: Text("Open Camera"),
                                              ),
                                              RaisedButton.icon(
                                                onPressed: () async {
                                                  final pickedFile =
                                                      await picker.getImage(
                                                          source: ImageSource
                                                              .gallery);

                                                  if (pickedFile != null) {
                                                    context
                                                            .read(imageProvider)
                                                            .encodeInputTwoPath =
                                                        pickedFile.path;
                                                    context
                                                        .read(imageProvider)
                                                        .notify();
                                                  }
                                                },
                                                icon: Icon(Icons.image),
                                                label: Text("Open Gallery"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : ImageBox(imageStorage.encodeInputTwoPath),
                              ),
                            ],
                          ),
                        ),
                        Spacer(flex: 1),
                      ],
                    ),
                  ),
                  Spacer(flex: 1),
                  Expanded(
                    flex: 6,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          Text("Output Image"),
                          SizedBox(height: 6.0),
                          Expanded(
                            child: imageStorage.encodeOutputPath == null
                                ? DottedBorder(
                                    color: Colors.grey,
                                    strokeWidth: 1,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child: Center(
                                        child: Text(
                                            "Please select both input images"),
                                      ),
                                    ),
                                  )
                                : ImageBox(imageStorage.encodeOutputPath),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                ],
              );
            },
          )),
    );
  }
}
