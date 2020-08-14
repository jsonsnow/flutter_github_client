import 'package:flutter/material.dart';
import 'package:github_client/common/Global.dart';
import 'package:provider/provider.dart';

class ThemeChangeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('主题'),
      ),
      body: ListView(
        children: Global.themes.map<Widget>((e) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: Container(
                color: e,
                height: 40,
              ),
            ),
            onTap: () {
              Provider.of<ThemeModel>(context, listen: false).theme = e;
            },
          );
        }).toList(),
      ),
    );
  }
}
