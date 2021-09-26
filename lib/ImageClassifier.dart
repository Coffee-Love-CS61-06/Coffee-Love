import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class ImageClassifier extends StatefulWidget {
  @override
  _ImageClassifierState createState() => _ImageClassifierState();
}

class _ImageClassifierState extends State<ImageClassifier> {
  List _outputs;
  File _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/coffee_model.tflite",
        labels: "assets/labels.txt",
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 4,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(_image);
  }

  pickImageTwo() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
    classifyImage(_image);
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
                _loading
                    ? Container(
                        height: 300,
                        width: 300,
                      )
                    : Container(
                        // margin: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _image == null ? Container() : Image.file(_image),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            _image == null
                                ? Container()
                                : _outputs != null
                                    ? Container(
                                        child: Column(
                                          children: [
                                            Text(
                                              _outputs[0]["label"] + "\n",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              "${(_outputs[0]["confidence"] * 100).toStringAsFixed(2)}%  Confidence level" +
                                                  "\n",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(child: Text(""))
                          ],
                        ),
                      ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.01,
                // ),
                IconButton(
                  icon: Image.asset('assets/images/camera.png'),
                  iconSize: 350,
                  onPressed: pickImageTwo,
                  padding: EdgeInsets.zero,
                ),
                IconButton(
                  icon: Image.asset('assets/images/photo.png'),
                  iconSize: 350,
                  onPressed: pickImage,
                  padding: EdgeInsets.zero,
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
