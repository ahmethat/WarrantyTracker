// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appTitle": MessageLookupByLibrary.simpleMessage("GARANTYOL"),
        "brand": MessageLookupByLibrary.simpleMessage("Brand"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteConfirmation": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this product?"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "model": MessageLookupByLibrary.simpleMessage("Model"),
        "addWarrantyImage":
            MessageLookupByLibrary.simpleMessage("Add Warranty Image"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "image": MessageLookupByLibrary.simpleMessage("Warranty Certificate"),
        "noProducts":
            MessageLookupByLibrary.simpleMessage("No products added yet."),
        "productDetail": MessageLookupByLibrary.simpleMessage("Product Detail"),
        "daysRemaining": MessageLookupByLibrary.simpleMessage("Days Left"),
        "years": MessageLookupByLibrary.simpleMessage("Year"),
        "months": MessageLookupByLibrary.simpleMessage("Month"),
        "days": MessageLookupByLibrary.simpleMessage("Day"),
        "expired": MessageLookupByLibrary.simpleMessage("Time Expired"),
        "remainingWarranty":
            MessageLookupByLibrary.simpleMessage("Time Until Warranty Expires"),
        "productName": MessageLookupByLibrary.simpleMessage("Product Name"),
        "editProduct": MessageLookupByLibrary.simpleMessage("Edit Product"),
        "newProductAdd":
            MessageLookupByLibrary.simpleMessage("New Product Add"),
        "purchaseDate":
            MessageLookupByLibrary.simpleMessage("Purchase Date (DD/MM/YYYY)"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "sortByName": MessageLookupByLibrary.simpleMessage("Sort By Name"),
        "sortByWarrantyDate":
            MessageLookupByLibrary.simpleMessage("Sort By Warranty Date"),
        "themeSelection":
            MessageLookupByLibrary.simpleMessage("Theme Selection"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
        "languageSelection":
            MessageLookupByLibrary.simpleMessage("Language Selection"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "warrantyEndDate": MessageLookupByLibrary.simpleMessage(
            "Warranty End Date (DD/MM/YYYY)"),
        "yes": MessageLookupByLibrary.simpleMessage("Yes"),
        // Validation Messages
        "productNameEmpty": MessageLookupByLibrary.simpleMessage(
            "Product name cannot be empty"),
        "brandEmpty":
            MessageLookupByLibrary.simpleMessage("Brand cannot be empty"),
        "modelEmpty":
            MessageLookupByLibrary.simpleMessage("Model cannot be empty"),
        "purchaseDateEmpty": MessageLookupByLibrary.simpleMessage(
            "Purchase Date cannot be empty"),
        "warrantyDateEmpty": MessageLookupByLibrary.simpleMessage(
            "Warranty End Date cannot be empty"),
        "invalidDateFormat": MessageLookupByLibrary.simpleMessage(
            "Please enter a valid date in the format DD/MM/YYYY."),
        "warrantyBeforePurchaseError": MessageLookupByLibrary.simpleMessage(
            "The Warranty End Date cannot be earlier than Purchase."),
        "warrantySameAsPurchaseError": MessageLookupByLibrary.simpleMessage(
            "Warranty End Date and Purchase Dates cannot be the same."),
      };
}
