import 'package:flutter/material.dart';
//https://pub.dev/packages/flutter_easyloading
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
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
                            // child: Image.file(imageURI,
                            //     width: 300, height: 200, fit: BoxFit.cover),
                            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          ),
                          Text(
                            '',
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Text('Result:',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.00,
                                )),
                            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          ),
                          Text(
                            '',
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: RaisedButton(
                                onPressed: () {},
                                child: Text(
                                  'Predict',
                                  style: TextStyle(fontSize: 18),
                                ),
                                textColor: Colors.white,
                                color: Color(0xFFCD976A),
                                padding: EdgeInsets.fromLTRB(60, 12, 60, 12),
                              )),
                          Text(
                            '',
                            style: TextStyle(fontSize: 18),
                          ),
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
