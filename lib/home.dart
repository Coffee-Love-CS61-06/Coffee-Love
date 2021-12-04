import 'package:coffee_love/predict.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Predict()));
                        },
                        child: Container(
                            width: 350,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/predict.png'),
                                  fit: BoxFit.cover),
                            )),
                      ),
                      Container(
                        height: 30.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Predict()));
                        },
                        child: Container(
                            width: 350,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/history.png'),
                                  fit: BoxFit.cover),
                            )),
                      ),
                      Container(
                        height: 20.0,
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
