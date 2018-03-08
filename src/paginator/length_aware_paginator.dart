import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:darequest/request.dart';

import 'paginator.dart';

class LengthAwarePaginator extends Paginator {

  int total = 0;
  int perPage = 15;
  int currentPage = 1;
  int lastPage = 1;
  String nextPageUrl;
  String prevPageUrl;
  int from = 0;
  int to = 0;
  List<Map<String, Object>> data = [];

  @override
  Future<List<Map<String, Object>>> onLoad(Response<HttpClientResponse> response) async {
    var responseBody ;
    if(Request.parseResponse) {
      responseBody = response.responseBody;
    } else {
      var body = await response.response.transform(UTF8.decoder).join();
      responseBody = Request.decodeJson(body);
    }
    total = responseBody['total'];
    perPage = responseBody['per_page'];
    currentPage = responseBody['current_page'];
    lastPage = responseBody['last_page'];
    nextPageUrl = responseBody['next_page_url'];
    prevPageUrl = responseBody['prev_page_url'];
    from = responseBody['from'];
    to = responseBody['to'];
    data = responseBody['data'];
    return data;
  }
}