import 'package:coffee_love/predict.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File imageURI;

  getImageFromCamera() async {
    final navigator = Navigator.of(context);
    File pickedImage = await ImagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      print(pickedImage.path);
      await navigator.push(
        MaterialPageRoute(
          builder: (context) => Predict(
            // imageURI: pickedImage.path,
          ),
        ),
      );
    }
  }

  getImageFromGallery() async {
    final navigator = Navigator.of(context);
    File pickedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      print(pickedImage.path);
      await navigator.push(
        MaterialPageRoute(
          builder: (context) => Predict(
            // localImagePath: pickedImage.path,
          ),
        ),
      );
    }
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
                        height: 200.0,
                        width: 400.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/logoname.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      GestureDetector(
                        child: Container(
                            width: 300,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/camera.png'),
                                  fit: BoxFit.cover),
                            )),
                        onTap: () => getImageFromCamera(),
                      ),
                      Container(
                        height: 30.0,
                      ),
                      GestureDetector(
                        child: Container(
                            width: 300,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/photo.png'),
                                  fit: BoxFit.cover),
                            )),
                        onTap: () => getImageFromGallery(),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      ButtonTheme(
                        minWidth: 290.0,
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () => {},
                          color: Color(0xFF885E5F),
                          child: Text(
                            'History',
                            style: TextStyle(color: Color(0xFFFFFFFF)),
                          ),
                        ),
                      ),
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
