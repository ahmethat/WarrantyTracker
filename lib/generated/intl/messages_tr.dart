// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a tr locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'tr';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appTitle": MessageLookupByLibrary.simpleMessage("GARANTYOL"),
        "brand": MessageLookupByLibrary.simpleMessage("Marka"),
        "delete": MessageLookupByLibrary.simpleMessage("Sil"),
        "deleteConfirmation": MessageLookupByLibrary.simpleMessage(
            "Bu ürünü silmek istediğinize emin misiniz?"),
        "edit": MessageLookupByLibrary.simpleMessage("Düzenle"),
        "add": MessageLookupByLibrary.simpleMessage("Ekle"),
        "model": MessageLookupByLibrary.simpleMessage("Model"),
        "no": MessageLookupByLibrary.simpleMessage("Hayır"),
        "noProducts":
            MessageLookupByLibrary.simpleMessage("Henüz ürün eklenmedi."),
        "productDetail": MessageLookupByLibrary.simpleMessage("Ürün Detayları"),
        "daysRemaining": MessageLookupByLibrary.simpleMessage("Gün kaldı"),
        "years": MessageLookupByLibrary.simpleMessage("Yıl"),
        "months": MessageLookupByLibrary.simpleMessage("Ay"),
        "days": MessageLookupByLibrary.simpleMessage("Gün"),
        "expired": MessageLookupByLibrary.simpleMessage("Süre Doldu"),
        "remainingWarranty": MessageLookupByLibrary.simpleMessage(
            "Garantinin Bitmesine Kalan Süre"),
        "productName": MessageLookupByLibrary.simpleMessage("Ürün Adı"),
        "editProduct": MessageLookupByLibrary.simpleMessage("Ürünü Düzenle"),
        "newProductAdd": MessageLookupByLibrary.simpleMessage("Yeni Ürün Ekle"),
        "purchaseDate": MessageLookupByLibrary.simpleMessage(
            "Satın Alma Tarihi (GG/AA/YYYY)"),
        "settings": MessageLookupByLibrary.simpleMessage("Ayarlar"),
        "sortByName": MessageLookupByLibrary.simpleMessage("İsme Göre Sırala"),
        "sortByWarrantyDate": MessageLookupByLibrary.simpleMessage(
            "Garanti süresine göre sırala"),
        "themeSelection": MessageLookupByLibrary.simpleMessage("Tema Seçimi"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Karanlık Mod"),
        "languageSelection": MessageLookupByLibrary.simpleMessage("Dil Seçimi"),
        "update": MessageLookupByLibrary.simpleMessage("Güncelle"),
        "warrantyEndDate": MessageLookupByLibrary.simpleMessage(
            "Garanti Bitiş Tarihi (GG/AA/YYYY)"),
        "yes": MessageLookupByLibrary.simpleMessage("Evet"),
        // Validation Messages
        "productNameEmpty":
            MessageLookupByLibrary.simpleMessage("Ürün adı boş olamaz"),
        "brandEmpty":
            MessageLookupByLibrary.simpleMessage("Marka boş bırakılamaz"),
        "modelEmpty":
            MessageLookupByLibrary.simpleMessage("Model boş bırakılamaz"),
        "purchaseDateEmpty": MessageLookupByLibrary.simpleMessage(
            "Satın Alma Tarihi boş olamaz"),
        "warrantyDateEmpty": MessageLookupByLibrary.simpleMessage(
            "Garanti Bitiş Tarihi boş olamaz"),
        "invalidDateFormat": MessageLookupByLibrary.simpleMessage(
            "Lütfen (GG/AA/YYYY) formatında geçerli bir tarih girin."),
        "warrantyBeforePurchaseError": MessageLookupByLibrary.simpleMessage(
            "Garanti Bitiş Tarihi, Satın Alma Tarihinden önce olamaz."),
        "warrantySameAsPurchaseError": MessageLookupByLibrary.simpleMessage(
            "Garanti Bitiş Tarihi ile Satın Alma Tarihleri aynı tarih olamaz."),
      };
}
