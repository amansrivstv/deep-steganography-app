import 'package:deep_steganography_app/state/providers.dart';
import 'package:deep_steganography_app/utils/theme_data.dart';
import 'package:deep_steganography_app/widgets/image_box.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class DecodePage extends StatefulWidget {
  DecodePage({Key key}) : super(key: key);

  @override
  _DecodePageState createState() => _DecodePageState();
}

class _DecodePageState extends State<DecodePage> {
  final picker = ImagePicker();

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
          child: Consumer(
            builder: (BuildContext context,
                T Function<T>(ProviderBase<Object, T>) watch, Widget child) {
              final imageStorage = watch(imageProvider);

              return Column(
                children: [
                  Spacer(flex: 1),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Text("Input Image"),
                        SizedBox(height: 6.0),
                        Expanded(
                          child: imageStorage.decodeInputPath == null
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
                                                    source: ImageSource.camera);

                                            if (pickedFile != null) {
                                              context
                                                      .read(imageProvider)
                                                      .decodeInputPath =
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
                                                    source:
                                                        ImageSource.gallery);

                                            if (pickedFile != null) {
                                              context
                                                      .read(imageProvider)
                                                      .decodeInputPath =
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
                              : ImageBox(imageStorage.decodeInputPath),
                        ),
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
                            child: imageStorage.decodeOutputPath == null
                                ? DottedBorder(
                                    color: Colors.grey,
                                    strokeWidth: 1,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child: Center(
                                        child:
                                            Text("Please select input image"),
                                      ),
                                    ),
                                  )
                                : ImageBox(imageStorage.decodeOutputPath),
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
