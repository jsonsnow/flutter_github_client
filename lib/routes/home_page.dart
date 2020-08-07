import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_client/common/Global.dart';
import 'package:github_client/common/git.dart';
import 'package:github_client/models/index.dart';
import 'package:provider/provider.dart';

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
          var data = await Git(context).getRepos(
              refresh: refresh, queryParams: {'page': page, 'page_size': 20});
          items.addAll(data);
          return data.length == 20;
        },
        itemBuilder: (list, index, ctx) {},
      );
    }
  }
}
