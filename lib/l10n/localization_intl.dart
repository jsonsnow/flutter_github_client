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
}

class GmLocalizationDelegate extends LocalizationsDelegate<GmLocalization> {
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
