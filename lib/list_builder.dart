import 'dart:async';

import 'package:flutter/material.dart';
import 'paginator/paginator.dart';

abstract class ListBuilder {
  Map<String, dynamic> get params;

  Paginator get pager;

  List<Map<String, Object>> items = [];

  Widget onCreateItem(BuildContext context, Map<String, Object> item);

  Widget onBuildList(BuildContext ctx) {
    var listView = new ListView.builder(
        itemBuilder: (BuildContext context, int index) => onCreateItem(context, items[index]), itemCount: items.length);

    return listView;
  }

  Future<List> loadData() {
    return pager.load(params).then((data) => this.items = onLoadData(data)).catchError((error) => onLoadError(error));
  }

  List onLoadData(List data) {
    return data;
  }

  dynamic onLoadError(error) {
    throw error;
  }
}
