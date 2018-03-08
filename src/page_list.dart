
import 'package:flutter/material.dart';
import 'package:flutterdemo/components/pagelist/src/list_builder.dart';

class PageList extends StatefulWidget {
  final ListBuilder builder;

  PageList({Key key, this.builder}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new PageListState();
}

class PageListState extends State<PageList> {
  final ListBuilder builder;
  List<Map<String, Object>> items = [];

  PageListState({this.builder});

  @override
  Widget build(BuildContext context) {

    return builder.onBuildList(context);
  }
}