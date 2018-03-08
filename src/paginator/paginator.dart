import 'dart:async';
import 'dart:io';

import 'package:darequest/request.dart';

abstract class Paginator {
  final String url;

  Paginator({this.url});

  Future<List> load([Map<String, dynamic> params = const {}]) {
    return Request.get(url, {"params": params}).then((response) {
     return onLoad(response);
    });
  }

  Future<List> onLoad(Response<HttpClientResponse> response);
}
