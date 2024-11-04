import 'package:flutter/material.dart';
import 'models/product.dart';
import 'db/database.dart';
import 'generated/l10n.dart';
// import 'package:intl/intl.dart'; // Tarih formatlaması için

class AddProductScreen extends StatelessWidget {
  final Function onProductAdded;
  final _formKey = GlobalKey<FormState>();

  AddProductScreen({required this.onProductAdded});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final brandController = TextEditingController();
    final modelController = TextEditingController();
    final purchaseDateController = TextEditingController();
    final warrantyEndDateController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).newProductAdd)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Form için GlobalKey atandı
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration:
                    InputDecoration(labelText: '${S.of(context).productName}'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).productNameEmpty;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: brandController,
                decoration:
                    InputDecoration(labelText: '${S.of(context).brand}'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).brandEmpty;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: modelController,
                decoration:
                    InputDecoration(labelText: '${S.of(context).model}'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).modelEmpty;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: purchaseDateController,
                decoration:
                    InputDecoration(labelText: '${S.of(context).purchaseDate}'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.length == 2 && !value.endsWith('/')) {
                    purchaseDateController.text = '$value/';
                    purchaseDateController.selection =
                        TextSelection.fromPosition(TextPosition(
                            offset: purchaseDateController.text.length));
                  } else if (value.length == 5 && !value.endsWith('/')) {
                    purchaseDateController.text = '$value/';
                    purchaseDateController.selection =
                        TextSelection.fromPosition(TextPosition(
                            offset: purchaseDateController.text.length));
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).purchaseDateEmpty;
                  }
                  // Tarih format kontrolü: DD/MM/YYYY
                  if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
                    return S.of(context).invalidDateFormat;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: warrantyEndDateController,
                decoration: InputDecoration(
                    labelText: '${S.of(context).warrantyEndDate}'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.length == 2 && !value.endsWith('/')) {
                    warrantyEndDateController.text = '$value/';
                    warrantyEndDateController.selection =
                        TextSelection.fromPosition(TextPosition(
                            offset: warrantyEndDateController.text.length));
                  } else if (value.length == 5 && !value.endsWith('/')) {
                    warrantyEndDateController.text = '$value/';
                    warrantyEndDateController.selection =
                        TextSelection.fromPosition(TextPosition(
                            offset: warrantyEndDateController.text.length));
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).warrantyDateEmpty;
                  }
                  // Tarih format kontrolü: DD/MM/YYYY
                  if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
                    return S.of(context).invalidDateFormat;
                  }

                  // Satın alma ve garanti bitiş tarihlerini karşılaştırma
                  final purchaseDateParts =
                      purchaseDateController.text.split('/');
                  final warrantyEndDateParts = value.split('/');

                  if (purchaseDateParts.length == 3 &&
                      warrantyEndDateParts.length == 3) {
                    final purchaseDay = int.tryParse(purchaseDateParts[0]) ?? 1;
                    final purchaseMonth =
                        int.tryParse(purchaseDateParts[1]) ?? 1;
                    final purchaseYear = int.tryParse(purchaseDateParts[2]) ??
                        DateTime.now().year;

                    final warrantyDay =
                        int.tryParse(warrantyEndDateParts[0]) ?? 1;
                    final warrantyMonth =
                        int.tryParse(warrantyEndDateParts[1]) ?? 1;
                    final warrantyYear =
                        int.tryParse(warrantyEndDateParts[2]) ??
                            DateTime.now().year;

                    final purchaseDate =
                        DateTime(purchaseYear, purchaseMonth, purchaseDay);
                    final warrantyEndDate =
                        DateTime(warrantyYear, warrantyMonth, warrantyDay);

                    if (warrantyEndDate.isBefore(purchaseDate)) {
                      return S.of(context).warrantyBeforePurchaseError;
                    }

                    if (warrantyEndDate.isAtSameMomentAs(purchaseDate)) {
                      return S.of(context).warrantySameAsPurchaseError;
                    }
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final purchaseDateParts =
                        purchaseDateController.text.split('/');
                    final warrantyEndDateParts =
                        warrantyEndDateController.text.split('/');

                    final purchaseDay = int.tryParse(purchaseDateParts[0]) ?? 1;
                    final purchaseMonth =
                        int.tryParse(purchaseDateParts[1]) ?? 1;
                    final purchaseYear = int.tryParse(purchaseDateParts[2]) ??
                        DateTime.now().year;

                    final warrantyDay =
                        int.tryParse(warrantyEndDateParts[0]) ?? 1;
                    final warrantyMonth =
                        int.tryParse(warrantyEndDateParts[1]) ?? 1;
                    final warrantyYear =
                        int.tryParse(warrantyEndDateParts[2]) ??
                            DateTime.now().year;

                    final purchaseDate =
                        DateTime(purchaseYear, purchaseMonth, purchaseDay);
                    final warrantyEndDate =
                        DateTime(warrantyYear, warrantyMonth, warrantyDay);

                    final newProduct = Product(
                      name: nameController.text,
                      brand: brandController.text,
                      model: modelController.text,
                      purchaseDate: purchaseDate,
                      warrantyEndDate: warrantyEndDate,
                    );

                    final dbHelper = DatabaseHelper();
                    await dbHelper.insertProduct(newProduct);
                    onProductAdded();
                    Navigator.pop(context);
                  }
                },
                child: Text(S.of(context).add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
