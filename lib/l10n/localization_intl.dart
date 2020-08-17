import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart';

class GmLocalization {
  static Future<GmLocalization> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localName = Intl.canonicalizedLocale(name);
    return initializeMessages(localName).then((value) {
      Intl.defaultLocale = localName;
      return new GmLocalization();
    });
  }

  static GmLocalization of(BuildContext context) {
    return Localizations.of<GmLocalization>(context, GmLocalization);
  }

  String get title {
    return Intl.message('Flutter APP',
        name: 'title', desc: 'Title for them my application');
  }

  String get home => Intl.message('主页', name: 'home');

  String get language => Intl.message('Language', name: 'language');

  String get login => Intl.message('Login', name: 'login');

  String get auto => Intl.message('Auto', name: 'auto');

  String get setting => Intl.message('Setting', name: 'setting');

  String get theme => Intl.message('Theme', name: 'theme');

  String get noDescription =>
      Intl.message('No description yet !', name: 'noDescription');

  String get userName => Intl.message('User Name', name: 'userName');

  String get userNameRequired =>
      Intl.message("User name required!", name: 'userNameRequired');

  String get password => Intl.message('Password', name: 'password');

  String get passwordRequired =>
      Intl.message('Password required!', name: 'passwordRequired');

  String get userNameOrPasswordWrong =>
      Intl.message('User name or password is not correct!',
          name: 'userNameOrPasswordWrong');

  String get logout => Intl.message('logout', name: 'logout');

  String get logoutTip =>
      Intl.message('Are you sure you want to quit your current account?',
          name: 'logoutTip');

  String get yes => Intl.message('yes', name: 'yes');

  String get cancel => Intl.message('cancel', name: 'cancel');
}

class GmLocalizationDelegate extends LocalizationsDelegate<GmLocalization> {
  const GmLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<GmLocalization> load(Locale locale) {
    return GmLocalization.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<GmLocalization> old) {
    return false;
  }
}
