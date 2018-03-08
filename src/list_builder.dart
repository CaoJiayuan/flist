import 'package:flutter/material.dart';

abstract class ListBuilder {
  final String url;
  final Map<String, dynamic> params;

  List<Map<String, Object>> items = [];

  ListBuilder({this.url, this.params: const {}});

  Widget onCreateItem(BuildContext context, Map<String, Object> item);

  ListView onBuildList(BuildContext ctx) {
    return new ListView.builder(
        itemBuilder: (BuildContext context, int index) => onCreateItem(context, items[index]), itemCount: items.length);
  }
}
