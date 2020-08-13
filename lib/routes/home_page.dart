import 'dart:js';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_client/common/Global.dart';
import 'package:github_client/common/funs.dart';
import 'package:github_client/common/git.dart';
import 'package:github_client/models/index.dart';
import 'package:provider/provider.dart';

import '../widgets/repo_item.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() {
    return _HomeRouteState();
  }
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('主页')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      return Center(
        child: RaisedButton(
          onPressed: () => Navigator.of(context).pushNamed('login'),
          child: Text('登录'),
        ),
      );
    } else {
      return InfiniteListView<Repo>(
        onRetrieveData: (page, items, refresh) async {
          print('list view start');
          var data = await Git(context).getRepos(
            refresh: refresh,
            queryParams: {'page': page, 'page_size': 20},
          );
          print('list view end');
          items.addAll(data);
          return data.length > 0 && data.length % 20 == 0;
        },
        itemBuilder: (list, index, ctx) {
          return RepoItem(list[index]);
        },
      );
    }
  }
}

class MyDrawer extends StatelessWidget {
  MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context, removeTop: true, child: Column()),
    );
  }

  Widget _buildHeader() {
    return Consumer<UserModel>(builder: (context, model, child) {
      return GestureDetector(
        child: Container(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipOval(
                  child: model.isLogin
                      ? gmAvatar(model.user.avatar_url, width: 80)
                      : Image.asset(
                          'imgs/avatar-default.png',
                          width: 80,
                        ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
