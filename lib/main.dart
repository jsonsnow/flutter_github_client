import 'package:flutter/material.dart';
import 'package:github_client/common/Global.dart';
import 'package:provider/provider.dart';

void main() => Global.init().then((value) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocaleModel())
      ],
      child: Consumer2<ThemeModel, LocaleModel>(
          builder: (BuildContext context, theme, local, Widget child) {
        return MaterialApp(
          theme: ThemeData(primarySwatch: theme.theme),
          onGenerateTitle: (context) {
            return "test";
          },
          locale: local.getLocale(),
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('zh', 'CN'),
          ],
        );
      }),
    );
  }
}
