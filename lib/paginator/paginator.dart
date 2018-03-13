import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:darequest/request.dart';

abstract class Paginator {

  int currentPage = 0;

  String pageParam = 'page';

  bool get hasNextPage;

  Future<List> load([Map<String, dynamic> params]) {
    return Request.get(getUrl(), {"params": params}).then((response) async {
      var responseBody;
      if (Request.parseResponse) {
        responseBody = response.responseBody;
      } else {
        var body = await response.response.transform(UTF8.decoder).join();
        responseBody = Request.decodeJson(body);
      }
      return onLoad(responseBody);
    });
  }

  Future<List> page(int page, [Map<String, dynamic> params]){
    if (params == null) {
      params = {};
    }
    params[pageParam] = page;
    return load(params);
  }

  Future<List> next([Map<String, dynamic> params]){
    if (params == null) {
      params = {};
    }
    params[pageParam] = currentPage + 1;
    return load(params);
  }

  Future<List> prev([Map<String, dynamic> params]){
    if (params == null) {
      params = {};
    }
    params[pageParam] = currentPage - 1;
    return load(params);
  }


  Future<List> onLoad(dynamic response);

  String getUrl();
}
