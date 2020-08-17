import 'package:flutter/material.dart';
import 'package:github_client/common/Global.dart';
import 'package:github_client/l10n/localization_intl.dart';
import 'package:provider/provider.dart';

class LanguageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    var localeModel = Provider.of<LocaleModel>(context);
    var gm = GmLocalization.of(context);

    Widget _buildLanguageItem(String lan, value) {
      return ListTile(
        title: Text(
          lan,
          style: TextStyle(color: localeModel.local == value ? color : null),
        ),
        trailing: localeModel.local == value
            ? Icon(
                Icons.done,
                color: color,
              )
            : null,
        onTap: () {
          print('on tap locale:$value');
          localeModel.locale = value;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(gm.language),
      ),
      body: ListView(
        children: [
          _buildLanguageItem('中文简体', 'zh_CN'),
          _buildLanguageItem('English', 'en_US'),
          _buildLanguageItem(gm.auto, null)
        ],
      ),
    );
  }
}
