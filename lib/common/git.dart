import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:github_client/common/Global.dart';
import 'package:github_client/models/index.dart';

import 'Global.dart';
import 'Global.dart';

class Git {
  Git([this.context]) {
    _options = Options(extra: {'context': context});
  }
  BuildContext context;
  Options _options;

  static Dio dio =
      new Dio(BaseOptions(baseUrl: 'https://api.github.com/', headers: {
    HttpHeaders.acceptHeader:
        "application/vnd.github.squirrel-girl-preview,application/vnd.github.symmetra-preview+json,application/vnd.github.v3+json"
  }));

  static void init() {
    dio.interceptors.add(Global.netCache);
    print('user token: ${Global.profile.token}');
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;
    if (!Global.isRelease) {
      print('go no release');
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return 'PROXY 10.10.11.107:8888';
        };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  Future<User> login(String login, String pwd) async {
    String basic = 'Basic' + base64.encode(utf8.encode('$login:$pwd'));
    var r = await dio.get('/users/$login',
        options: _options.merge(
            headers: {HttpHeaders.authorizationHeader: basic},
            extra: {'noCache': true}));

    dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    Global.netCache.cache.clear();
    Global.profile.token = 'Basic ' + base64.encode(utf8.encode('$login:$pwd'));
    return User.fromJson(r.data);
  }

  Future<List<Repo>> getRepos(
      {Map<String, dynamic> queryParams, refresh = false}) async {
    if (refresh) {
      // 列表下拉刷新，需要删除缓存（拦截器中会读取这些信息）
      _options.extra.addAll({"refresh": true, "list": true});
    }
    var r = await dio.get<List>(
      "user/repos",
      queryParameters: queryParams,
      options: _options,
    );
    print('repo data: $r');
    return r.data.map((e) => Repo.fromJson(e)).toList();
  }
}
