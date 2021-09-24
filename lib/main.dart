import 'package:flutter/material.dart';
import 'package:coffee_love/ImageClassifier.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(new MaterialApp(
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: AfterSplash(),
      title: Text('Coffee Roast Intelligence', style: TextStyle(color: Colors.white, fontSize: 18)),
      image: Image.asset('assets/images/logo.png'),
      backgroundColor: Color(0xFFB18253),
      styleTextUnderTheLoader: TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.white,
    );
  }
}
class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tensorflow Lite',
      home: ImageClassifier(),
    );
  }
}
