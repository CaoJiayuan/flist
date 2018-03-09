import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flist/paginator/paginator.dart';

abstract class ListBuilder {

  Map<String, dynamic> get params;
  Paginator get pager;

  List<Map<String, Object>> items = [];


  Widget onCreateItem(BuildContext context, Map<String, Object> item);

  ListView onBuildList(BuildContext ctx) {
    return new ListView.builder(
        itemBuilder: (BuildContext context, int index) => onCreateItem(context, items[index]), itemCount: items.length);
  }

  Future<List> onLoadData(){
    return pager.load(params).then((data) => this.items = data).catchError((error) => onLoadError(error));
  }

  dynamic onLoadError(error);
}
