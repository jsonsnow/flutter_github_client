import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:github_client/common/Global.dart';
import 'package:github_client/l10n/localization_intl.dart';
import 'package:github_client/routes/language.dart';
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
          locale: local.getLocale(),
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('zh', 'CN'),
          ],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GmLocalizationDelegate()
          ],
          localeListResolutionCallback: (list, supportList) {
            if (local.getLocale() != null) {
              return local.getLocale();
            }
            Locale locale;
            list.forEach((element) {
              if (supportList.contains(element)) {
                locale = element;
              }
            });
            if (locale == null) {
              locale = Locale('en', 'US');
            }
            return locale;
          },
          routes: <String, WidgetBuilder>{
            '/': (context) => HomeRoute(),
            'login': (context) => LoginRoute(),
            'themes': (context) => ThemeChangeRoute(),
            'language': (context) => LanguageRoute()
          },
        );
      }),
    );
  }
}
