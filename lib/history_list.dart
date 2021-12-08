import 'package:coffee_love/Models/description.dart';
import 'package:coffee_love/history_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryList extends StatefulWidget {
  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  Widget build(BuildContext context) {
    final descriptions = Provider.of<List<Descriptions>>(context);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: descriptions?.length ?? 0,
      itemBuilder: (context, index) {
        return HistoryTile(description: descriptions[index]);
      },
    );
  }
}
