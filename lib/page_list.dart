import 'dart:async';

import 'package:flutter/material.dart';
import 'list_builder.dart';
import 'pull_up_load_notification.dart';


export 'list_builder.dart';
export 'paginator/paginator.dart';
export 'paginator/length_aware_paginator.dart';

class PageList extends StatefulWidget {
  final ListBuilder builder;

  PageList({Key key, this.builder}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new PageListState();
}

class PageListState extends State<PageList> {

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    var indicator = new RefreshIndicator(
        child: widget.builder.onBuildList(context), onRefresh: loadData);

    return new NotificationListener(
      child: indicator,
      onNotification: onListNotification,
    );
  }


  Future<Null> loadData() {
    return widget.builder.loadData().then((items) {
      setState(() => {});
      return null;
    });
  }

  Future<Null> loadMore() {
    var builder = widget.builder;
    return builder.loadMore().then((items) {
      if (!builder.pager.hasNextPage){
        builder.addNoMore();
      }
      setState(() => {});
      return null;
    });
  }


  bool onListNotification(n) {
    if (n is PullUpLoadNotification) {
      loadMore();
    }

    return true;
  }
}