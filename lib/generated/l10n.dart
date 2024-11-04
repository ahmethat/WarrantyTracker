// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `GARANTYOL`
  String get appTitle {
    return Intl.message(
      'GARANTYOL',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `No products added yet.`
  String get noProducts {
    return Intl.message(
      'No products added yet.',
      name: 'noProducts',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Sort By Name`
  String get sortByName {
    return Intl.message(
      'Sort By Name',
      name: 'sortByName',
      desc: '',
      args: [],
    );
  }

  /// `Sort By Warranty Date`
  String get sortByWarrantyDate {
    return Intl.message(
      'Sort By Warranty Date',
      name: 'sortByWarrantyDate',
      desc: '',
      args: [],
    );
  }

  /// `Theme Selection`
  String get themeSelection {
    return Intl.message(
      'Theme Selection',
      name: 'themeSelection',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Language Selection`
  String get languageSelection {
    return Intl.message(
      'Language Selection',
      name: 'languageSelection',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this product?`
  String get deleteConfirmation {
    return Intl.message(
      'Are you sure you want to delete this product?',
      name: 'deleteConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// 'Product Detail'
  String get productDetail {
    return Intl.message(
      'Product Detail',
      name: 'productDetail',
      desc: '',
      args: [],
    );
  }

  /// 'Days Left'
  String get daysRemaining {
    return Intl.message(
      'Days Left',
      name: 'daysRemaining',
      desc: '',
      args: [],
    );
  }

  /// 'Year'
  String get years {
    return Intl.message(
      'Year',
      name: 'years',
      desc: '',
      args: [],
    );
  }

  /// 'Month'
  String get months {
    return Intl.message(
      'Month',
      name: 'months',
      desc: '',
      args: [],
    );
  }

  /// 'Day'
  String get days {
    return Intl.message(
      'Day',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// 'Time Expired'
  String get expired {
    return Intl.message(
      'Time Expired',
      name: 'expired',
      desc: '',
      args: [],
    );
  }

  /// 'Days Until Warranty Ends'
  String get remainingWarranty {
    return Intl.message(
      'Days Until Warranty Ends',
      name: 'remainingWarranty',
      desc: '',
      args: [],
    );
  }

  /// 'Edit Product'
  String get editProduct {
    return Intl.message(
      'Edit Product',
      name: 'editProduct',
      desc: '',
      args: [],
    );
  }

  /// `New Product Add`
  String get newProductAdd {
    return Intl.message(
      'New Product Add',
      name: 'newProductAdd',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get productName {
    return Intl.message(
      'Product Name',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get brand {
    return Intl.message(
      'Brand',
      name: 'brand',
      desc: '',
      args: [],
    );
  }

  /// `Model`
  String get model {
    return Intl.message(
      'Model',
      name: 'model',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Date (DD/MM/YYYY)`
  String get purchaseDate {
    return Intl.message(
      'Purchase Date (DD/MM/YYYY)',
      name: 'purchaseDate',
      desc: '',
      args: [],
    );
  }

  /// `Warranty End Date (DD/MM/YYYY)`
  String get warrantyEndDate {
    return Intl.message(
      'Warranty End Date (DD/MM/YYYY)',
      name: 'warrantyEndDate',
      desc: '',
      args: [],
    );
  }

  // Validation Messages -------------------------

  /// `Product name cannot be empty`
  String get productNameEmpty {
    return Intl.message(
      'Product name cannot be empty',
      name: 'productNameEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Brand cannot be empty`
  String get brandEmpty {
    return Intl.message(
      'Brand cannot be empty',
      name: 'brandEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Model cannot be empty`
  String get modelEmpty {
    return Intl.message(
      'Model cannot be empty',
      name: 'modelEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Date cannot be empty`
  String get purchaseDateEmpty {
    return Intl.message(
      'Purchase Date cannot be empty',
      name: 'purchaseDateEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Warranty End Date cannot be empty`
  String get warrantyDateEmpty {
    return Intl.message(
      'Warranty End Date cannot be empty',
      name: 'warrantyDateEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid date in the format DD/MM/YYYY.`
  String get invalidDateFormat {
    return Intl.message(
      'Please enter a valid date in the format DD/MM/YYYY.',
      name: 'invalidDateFormat',
      desc: '',
      args: [],
    );
  }

  /// `The Warranty End Date cannot be earlier than Purchase.`
  String get warrantyBeforePurchaseError {
    return Intl.message(
      'The Warranty End Date cannot be earlier than Purchase.',
      name: 'warrantyBeforePurchaseError',
      desc: '',
      args: [],
    );
  }

  /// `Warranty End Date and Purchase Dates cannot be the same.`
  String get warrantySameAsPurchaseError {
    return Intl.message(
      'Warranty End Date and Purchase Dates cannot be the same.',
      name: 'warrantySameAsPurchaseError',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
