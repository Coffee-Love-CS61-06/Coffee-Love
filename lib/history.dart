import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_love/Presenters/auth.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                    margin: const EdgeInsets.all(5),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
