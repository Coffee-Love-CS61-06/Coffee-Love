import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Predict extends StatefulWidget {
  @override
  _PredictState createState() => _PredictState();
}

class _PredictState extends State<Predict> {
  File imageURI;
  String result;
  String path;

  classifyImage(BuildContext context) async {
    FormData formData =
        new FormData.fromMap({"file": await MultipartFile.fromFile(path)});
    try {
      Dio dio = Dio();
      // var response = await Dio().post("http://[your own ip address]:5000/upload", data: formData); //change [your own ip address] to your own address
      var response =
          await dio.post("http://10.0.2.2:5000/predict", data: formData);
      if (response.statusCode == 200) {
        print("done");
        // var parsedJson = json.decode(response.data.toString());
        setState(() {
          result =
              "${response.data['class']} Roast\n Confidence level ${response.data["score"]} %";
        });
      } else {
        print("error");
      }
    } catch (e) {
      setState(() {
        result = e.toString();
      });
    }
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageURI = image;
      path = image.path;
    });
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageURI = image;
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
                      imageURI == null
                          ? Container(
                              margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                              child: Text('No image selected.',style: TextStyle(fontSize: 18),),
                              padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                            )
                          : Container(
                              margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                              child: Image.file(imageURI,
                                  width: 300, height: 200, fit: BoxFit.cover),
                              padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                            ),
                      result == null
                          ? Text('Result', style: TextStyle(fontSize: 18),)
                          : Container(
                              margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                              child: Text(result,
                                  style: TextStyle(fontSize: 18.00)),
                              padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                            ),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: RaisedButton(
                            onPressed: () => classifyImage(context),
                            child: Text('Predict', style: TextStyle(fontSize: 18),),
                            textColor: Colors.white,
                            color: Color(0xFFCD976A),
                            padding: EdgeInsets.fromLTRB(60, 12, 60, 12),
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: RaisedButton(
                            onPressed: () => getImageFromCamera(),
                            child: Text('TAKE A PHOTO', style: TextStyle(fontSize: 18),),
                            textColor: Colors.white,
                            color: Color(0xFFD8803C),
                            padding: EdgeInsets.fromLTRB(110, 12, 110, 12),
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: RaisedButton(
                            onPressed: () => getImageFromGallery(),
                            child: Text('UPLOAD A PHOTO', style: TextStyle(fontSize: 18),),
                            textColor: Colors.white,
                            color: Color(0xFFD8803C),
                            padding: EdgeInsets.fromLTRB(100, 12, 100, 12),
                          )),
                      // Container(
                      //     margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                      //     child: RaisedButton(
                      //       onPressed: () => classifyImage(context),
                      //       child: Text('Classify Image'),
                      //       textColor: Colors.white,
                      //       color: Colors.blue,
                      //       padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      //     )),
                      // result == null
                      //     ? Text('Result')
                      //     : Container(
                      //     margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                      //     child: Text(result, style:TextStyle(fontSize: 20.00 )),
                      //     padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      // ),
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
