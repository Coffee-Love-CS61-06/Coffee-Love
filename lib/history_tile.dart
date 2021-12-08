import 'package:coffee_love/Models/description.dart';
import 'package:flutter/material.dart';

class HistoryTile extends StatelessWidget {
  final Descriptions description;
  HistoryTile({this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
          ),
          title: Text(description.class_result),
          subtitle: Text(description.score_result),
        ),
      ),
    );
  }
}
