import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:warranty_tracker/generated/intl/messages_all.dart';

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static Future<AppLocalizations> load(Locale locale) async {
    final String name = locale.countryCode?.isEmpty ?? true
        ? locale.languageCode
        : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    await initializeMessages(localeName);
    Intl.defaultLocale = localeName;
    return AppLocalizations();
  }

  // Uygulamanızda kullanmak istediğiniz metinler için getter'lar tanımlayın.
  String get title {
    return Intl.message(
      'Warranty Tracker',
      name: 'title',
      desc: 'The title of the application',
    );
  }

  String get welcome {
    return Intl.message(
      'Welcome to the Warranty Tracker!',
      name: 'welcome',
      desc: 'Welcome message on the home screen',
    );
  }

  // Diğer metinler için de benzer getter'lar ekleyebilirsiniz.
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'tr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
