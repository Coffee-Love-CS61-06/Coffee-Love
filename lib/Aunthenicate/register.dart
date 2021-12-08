import 'package:coffee_love/Presenters/auth.dart';
import 'package:coffee_love/shared/constants.dart';
import 'package:coffee_love/shared/loading.dart';
import 'package:flutter/material.dart';
import '../wrapper.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String confirmPassword = '';
  String firstname = '';
  String lastname = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color(0xFFF1EAE0),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text('REGISTER',
                        style: TextStyle(color: Colors.black, fontSize: 22)),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Email',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Password',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Firstname',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Enter an firstname' : null,
                      onChanged: (val) {
                        setState(() => firstname = val);
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Lastname',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Enter an lastname' : null,
                      onChanged: (val) {
                        setState(() => lastname = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
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
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Register',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    email, password, firstname, lastname);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Please supply a valid email';
                              });
                            } else {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Wrapper()),
                                  (route) => false);
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
