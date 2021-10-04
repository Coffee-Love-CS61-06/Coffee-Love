import 'dart:html';

import 'package:coffee_love/predict.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File imageURI;
  String result;
  String path;

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageURI = image as File;
      path = image.path;
    });
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageURI = image as File;
      path = image.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2E9DE),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF885E5F),
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                          child: Text("Coffee Roast Intelligence")),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                          child: IconButton(
                            onPressed: () => getImageFromCamera(),
                            icon: Image.asset('assets/images/camera.png'),
                            iconSize: 350,
                            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: IconButton(
                            onPressed: () => getImageFromGallery(),
                              icon: Image.asset('assets/images/photo.png'),
                            iconSize: 350,
                            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          )),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.01,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
