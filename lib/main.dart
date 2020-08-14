import 'package:flutter/material.dart';
import 'package:github_client/common/Global.dart';
import 'package:github_client/routes/login.dart';
import 'package:github_client/routes/theme_change.dart';
import 'package:provider/provider.dart';

import 'common/Global.dart';
import 'routes/home_page.dart';

void main() {
  // add this, and it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized();
  // rest of your app code
  Global.init().then((value) => runApp(MyApp()));
}

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
          // locale: local.getLocale(),
          // supportedLocales: [
          //   const Locale('en', 'US'),
          //   const Locale('zh', 'CN'),
          // ],
          routes: <String, WidgetBuilder>{
            '/': (context) => HomeRoute(),
            'login': (context) => LoginRoute(),
            'themes': (context) => ThemeChangeRoute()
          },
        );
      }),
    );
  }
}
