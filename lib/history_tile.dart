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
        margin: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
        child: ListTile(
          leading: Image.network(description.imageUrl, fit: BoxFit.fill),
          title: Text(description.classResult + "\n" + description.scoreResult),
          subtitle: Text("Description:" +
              "\n" +
              description.descriptionText +
              "\n\n\n" +
              description.dateTime),
        ),
      ),
    );
  }
}
