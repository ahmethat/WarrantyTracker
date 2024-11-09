import 'package:flutter/material.dart';
import 'models/product.dart';
import 'db/database.dart';
import 'generated/l10n.dart';
import 'dart:io'; // Dosya işlemleri için
import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart'; // Tarih formatlaması için

class AddProductScreen extends StatefulWidget {
  final Function onProductAdded;

  AddProductScreen({required this.onProductAdded});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final nameController = TextEditingController();
  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final purchaseDateController = TextEditingController();
  final warrantyEndDateController = TextEditingController();
  String? warrantyImagePath;

  @override
  Widget build(BuildContext context) {
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
                readOnly: true, // Klavye açılmasını engeller
                decoration:
                    InputDecoration(labelText: '${S.of(context).purchaseDate}'),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000), // Başlangıç tarihi
                    lastDate: DateTime(2101), // Bitiş tarihi
                  );
                  if (pickedDate != null) {
                    // Tarih seçildiyse, formatını düzenleyip TextFormField'a yazdır
                    purchaseDateController.text =
                        "${pickedDate.day.toString().padLeft(2, '0')}/"
                        "${pickedDate.month.toString().padLeft(2, '0')}/"
                        "${pickedDate.year}";
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
                readOnly: true,
                decoration: InputDecoration(
                    labelText: '${S.of(context).warrantyEndDate}'),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    warrantyEndDateController.text =
                        "${pickedDate.day.toString().padLeft(2, '0')}/"
                        "${pickedDate.month.toString().padLeft(2, '0')}/"
                        "${pickedDate.year}";
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
              SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  final pickedFile =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      warrantyImagePath = pickedFile.path;
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: warrantyImagePath == null
                      ? Center(
                          child: Text(S.of(context).addWarrantyImage,
                              style: TextStyle(color: Colors.grey[600])),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(warrantyImagePath!),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
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
                      warrantyImage: warrantyImagePath,
                    );

                    final dbHelper = DatabaseHelper();
                    await dbHelper.insertProduct(newProduct);
                    widget.onProductAdded();
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
