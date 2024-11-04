// lib/models/product.dart

class Product {
  final int? id; // Ürün ID'si (otomatik artacak)
  final String name; // Ürün adı
  final String brand; // Marka
  final String model; // Model
  final DateTime purchaseDate; // Satın alma tarihi
  final DateTime warrantyEndDate; // Garanti bitiş tarihi
  final String? warrantyImage; // Garanti belgesi fotoğrafı

  Product({
    this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.purchaseDate,
    required this.warrantyEndDate,
    this.warrantyImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'model': model,
      'purchaseDate': purchaseDate.toIso8601String(),
      'warrantyEndDate': warrantyEndDate.toIso8601String(),
      'warrantyImage': warrantyImage,
    };
  }

  // Map'ten Product nesnesi oluşturma
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      brand: map['brand'],
      model: map['model'],
      purchaseDate: DateTime.parse(map['purchaseDate']),
      warrantyEndDate: DateTime.parse(map['warrantyEndDate']),
      warrantyImage: map['warrantyImage'],
    );
  }
}
