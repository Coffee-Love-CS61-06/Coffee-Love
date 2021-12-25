import 'package:coffee_love/Aunthenicate/register.dart';
import 'package:coffee_love/Presenters/auth.dart';
import 'package:coffee_love/shared/constants.dart';
import 'package:coffee_love/shared/loading.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.brown[100],
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFFEEE3D5),
                    Color(0xFFD2B79A),
                    Color(0xFFAC7A49)
                  ],
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 200.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text('Coffee Roast Intelligence',
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                    SizedBox(height: 40.0),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Email',
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Password',
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 12.0),
                    ),
                    FlatButton(
                        child: Text('Forgot Password?',
                            style: TextStyle(
                                color: Color(0xFFFFFFFF), fontSize: 16),
                            textAlign: TextAlign.right),
                        padding: EdgeInsets.fromLTRB(120, 0, 0, 0),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              return Scaffold(
                                backgroundColor: Color(0xFFF3E8DA),
                                appBar: AppBar(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0.0,
                                  leading: IconButton(
                                    icon: Icon(Icons.arrow_back_ios,
                                        color: Colors.black),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ),
                                body: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 50.0),
                                  child: Form(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 150.0,
                                          width: 150.0,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/logo.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Text('Forget Password',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22)),
                                        SizedBox(height: 20.0),
                                        TextFormField(
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                              labelText: 'Enter Your Email',
                                              labelStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                            validator: (val) => val.isEmpty
                                                ? 'Enter an email'
                                                : null,
                                            onChanged: (val) {
                                              setState(() => email = val);
                                            }),
                                        SizedBox(height: 20.0),
                                        FlatButton(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Container(
                                              width: 300,
                                              decoration: new BoxDecoration(
                                                  gradient: new LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color(0xFFBC744D),
                                                  Color(0xFFA97D69),
                                                  Color(0xFF725F5B)
                                                ],
                                              )),
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                'Confirm',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            onPressed: () async {
                                              _auth.sendPasswordResetEmail(
                                                  email);
                                              if (email != null) {
                                                Flushbar(
                                                  title: 'Reset Password',
                                                  message:
                                                      'We send the detail to $email successfully',
                                                  icon: Icon(
                                                    Icons.info_outline,
                                                    size: 28,
                                                    color: Colors.blue.shade300,
                                                  ),
                                                  leftBarIndicatorColor:
                                                      Colors.blue.shade300,
                                                  duration:
                                                      Duration(seconds: 3),
                                                ).show(context);
                                              }
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          );
                        }),
                    RaisedButton(
                        color: Color(0xFFD8803C),
                        child: Text(
                          'Sign In   ',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        padding: EdgeInsets.fromLTRB(115, 12, 115, 12),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Could not sign in with those credentials';
                              });
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    RaisedButton(
                        color: Color(0xFFC46937),
                        child: Text(
                          'Register   ',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        padding: EdgeInsets.fromLTRB(110, 12, 110, 12),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                        }),
                    SizedBox(height: 12.0),
                  ],
                ),
              ),
            ),
          );
  }
}
