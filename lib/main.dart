import 'package:coffee_love/Models/user.dart';
import 'package:coffee_love/Presenters/auth.dart';
import 'package:coffee_love/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    home: MyApp(),
  ));
}

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
      title: Text('Coffee Roast Intelligence',
          style: TextStyle(color: Colors.white, fontSize: 28)),
      image: Image.asset('assets/images/logo.png'),
      gradientBackground: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Color(0xFFEEE3D5), Color(0xFFD2B79A), Color(0xFFAC7A49)],
      ),
      styleTextUnderTheLoader: TextStyle(),
      photoSize: 120.0,
      loaderColor: Colors.white,
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
        value: AuthService().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TensorFlow',
          home: Wrapper(),
        ));
  }
}
