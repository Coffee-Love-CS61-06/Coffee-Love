import 'dart:io';
import 'package:coffee_love/Presenters/description.dart';
import 'package:coffee_love/history.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//https://pub.dev/packages/flutter_easyloading
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Predict extends StatefulWidget {
  @override
  _PredictState createState() => _PredictState();
}

class _PredictState extends State<Predict> {
  File imageURI;
  String result;
  // ignore: non_constant_identifier_names
  String class_result;
  // ignore: non_constant_identifier_names
  String score_result;
  String path;
  // ignore: non_constant_identifier_names
  String description_text = '';
  // ignore: non_constant_identifier_names
  String image_url;
  // ignore: non_constant_identifier_names
  String image_id;
  // ignore: non_constant_identifier_names
  String date_time;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;

  @override
  void initState() {
    super.initState();
    // EasyLoading.show();
  }

  initUser() async {
    user = _auth.currentUser;
    setState(() {});
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  classifyImage(BuildContext context) async {
    FormData formData =
        new FormData.fromMap({"file": await MultipartFile.fromFile(path)});
    try {
      EasyLoading.show();
      Dio dio = Dio();
      // var response = await Dio().post("http://[your own ip address]:5000/upload", data: formData); //change [your own ip address] to your own address
      var response =
          await dio.post("http://20.115.73.228:8080/predict", data: formData);
      // var response =
      //     await dio.post("http://10.0.2.2:5000/predict", data: formData);
      if (response.statusCode == 200) {
        print(response);
        print("done");
        // var parsedJson = json.decode(response.data.toString());
        setState(() {
          class_result = "${response.data['class']} Roast";
          score_result = "Probability: ${response.data["score"]} %";
          image_url = "${response.data['url']}";
          image_id = "${response.data['image_id']}";
          date_time = "${response.data['upload_time']}";
        });
      } else {
        print("error");
      }
      EasyLoading.dismiss();
    } catch (e) {
      setState(() {
        class_result = e.toString();
        score_result = e.toString();
        image_url = e.toString();
        image_id = e.toString();
        date_time = e.toString();
      });
    }
  }

  TextEditingController _textFieldController = TextEditingController();
  description(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Description'),
            content: TextField(
              controller: _textFieldController,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: "Enter your desciption"),
              onChanged: (val) {
                setState(() => description_text = val);
              },
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Save'),
                onPressed: () {
                  CommentProvider().updateDescriptionsData(
                      class_result,
                      score_result,
                      description_text,
                      image_url,
                      image_id,
                      date_time);
                  Flushbar(
                    message: 'Description Saved',
                    icon: Icon(
                      Icons.info_outline,
                      size: 28,
                      color: Colors.black,
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => History()),
                  );
                },
              )
            ],
          );
        });
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

  var status = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: EasyLoading.init(),
        home: Scaffold(
          backgroundColor: Color(0xFFF2E9DE),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xFF885E5F),
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
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
                                  child: Text(
                                    'No Image selected.' +
                                        "\n" +
                                        'Please take or upload a photo.',
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                  padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                                )
                              : Container(
                                  margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                                  child: Image.file(imageURI,
                                      width: 300,
                                      height: 200,
                                      fit: BoxFit.cover),
                                  padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                                ),
                          class_result == null && score_result == null
                              ? Text(
                                  '',
                                  style: TextStyle(fontSize: 18),
                                )
                              : Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Text(
                                      'Result:' +
                                          "\n" +
                                          class_result +
                                          "\n" +
                                          score_result,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.00,
                                      )),
                                  padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                                ),

                          imageURI == null
                              ? Text(
                                  '',
                                  style: TextStyle(fontSize: 18),
                                )
                              : Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                  child: RaisedButton(
                                    onPressed: () async {
                                      classifyImage(context);
                                      // await Future.delayed(
                                      //     Duration(seconds: 2));
                                      // EasyLoading.show(status: 'loading...');
                                      // await Future.delayed(
                                      //     Duration(seconds: 5));
                                    },
                                    child: Text(
                                      'Predict',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    textColor: Colors.white,
                                    color: Color(0xFFCD976A),
                                    padding:
                                        EdgeInsets.fromLTRB(60, 12, 60, 12),
                                  )),

                          class_result == null && score_result == null
                              ? Text(
                                  '',
                                  style: TextStyle(fontSize: 18),
                                )
                              : Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: RaisedButton(
                                    onPressed: () => description(context),
                                    child: Text(
                                      'Save',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    textColor: Colors.white,
                                    color: Color(0xFF885E5F),
                                    padding:
                                        EdgeInsets.fromLTRB(150, 12, 150, 12),
                                  ),
                                ),
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: RaisedButton(
                                onPressed: () => getImageFromCamera(),
                                child: Text(
                                  'TAKE A PHOTO',
                                  style: TextStyle(fontSize: 18),
                                ),
                                textColor: Colors.white,
                                color: Color(0xFFD8803C),
                                padding: EdgeInsets.fromLTRB(110, 12, 110, 12),
                              )),
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: RaisedButton(
                                onPressed: () => getImageFromGallery(),
                                child: Text(
                                  'UPLOAD A PHOTO',
                                  style: TextStyle(fontSize: 18),
                                ),
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
        ));
  }
}
