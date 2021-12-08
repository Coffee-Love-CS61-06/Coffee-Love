import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_love/Presenters/description.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DrawerCode extends StatefulWidget {
  @override
  _DrawerCodeState createState() => _DrawerCodeState();
}

class _DrawerCodeState extends State<DrawerCode> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where("uid", isEqualTo: user.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading...');
          default:
            return Drawer(
              child: Material(
                color: Color(0xffF8F1E9),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  children: <Widget>[
                    Container(height: 40),
                    Container(
                        child: Column(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return new ListTile(
                          title: Text(
                            "Profile",
                            style: TextStyle(fontSize: 30),
                          ),
                        );
                      }).toList(),
                    )),
                    Container(
                      child: Container(
                        height: 5,
                        color: Color(0xff8D5F5F),
                      ),
                    ),
                    Container(
                      height: 20,
                    ),
                    Container(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/profile.png'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        child: Column(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return new ListTile(
                          title: Text(
                            document['firstname'] + " " + document['lastname'],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24),
                          ),
                        );
                      }).toList(),
                    )),
                    Container(
                        child: Column(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return new ListTile(
                          title: Text(
                            document['email'],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }).toList(),
                    )),
                    Container(
                      height: 250,
                    ),
                    ButtonTheme(
                      height: 45.0,
                      child: RaisedButton(
                          color: Color(0xffDA3B19),
                          child: Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            await _auth.signOut();
                          }),
                    ),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
