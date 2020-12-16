import 'package:deep_steganography_app/screens/decode_page.dart';
import 'package:deep_steganography_app/screens/encode_page.dart';
import 'package:deep_steganography_app/utils/size_config.dart';
import 'package:deep_steganography_app/utils/theme_data.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Deep Steganography app"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RaisedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => EncodePage(),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.black),
                ),
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text("Encode"),
                ),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => DecodePage(),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.black),
                ),
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text("Decode"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
