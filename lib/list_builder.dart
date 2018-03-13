import 'dart:async';

import 'package:flutter/material.dart';
import 'paginator/paginator.dart';
import 'pull_up_load_notification.dart';

abstract class ListBuilder {
  Map<String, dynamic> get params;

  Paginator pager;

  ListBuilder() {
    pager = getPager();
  }

  Paginator getPager();

  List items = [];

  Widget onCreateItem(BuildContext context, Map<String, Object> item,
      int index);

  Widget onBuildList(BuildContext ctx) {
    var listView = new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index >= items.length - 1 && pager.hasNextPage) {
            notifyLoadMore(context);
          }
          var item = items[index];

          if (item is Widget) {
            return item;
          }

          return onCreateItem(context, item, index);
        }, itemCount: items.length);

    return listView;
  }

  Future<List> loadData() {
    return pager.load(params)
        .then((data) => items = onLoadData(data))
        .catchError((error) => onLoadError(error));
  }

  Future<List> loadMore() {
    return pager.next(params).then((data) {
      onLoadData(data).forEach((item) => this.items.add(item));
      return items;
    }).catchError((error) => onLoadError(error));
  }

  List onLoadData(List data) {
    return data;
  }

  void addNoMore(){
    this.items.add(noMore());
  }

  Widget noMore();

  dynamic onLoadError(error) {
    throw error;
  }

  void notifyLoadMore(BuildContext context) {
    new PullUpLoadNotification().dispatch(context);
  }
}
