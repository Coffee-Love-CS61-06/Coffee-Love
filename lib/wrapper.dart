import 'package:coffee_love/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Aunthenicate/sign_in.dart';
import 'home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return SignIn();
    } else {
      return Home();
    }
  }
}
