import 'package:flutter/material.dart';
import 'models/product.dart';
import 'db/database.dart';
import 'package:intl/intl.dart'; // intl package
import 'package:shared_preferences/shared_preferences.dart'; // Shared Preferences
import 'settings_screen.dart'; // SettingsScreen
import 'add_product_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'generated/l10n.dart';
import 'dart:io';

void main() {
  runApp(WarrantyTrackerApp());
}

class WarrantyTrackerApp extends StatefulWidget {
  @override
  _WarrantyTrackerAppState createState() => _WarrantyTrackerAppState();
}

class _WarrantyTrackerAppState extends State<WarrantyTrackerApp> {
  ThemeMode _themeMode = ThemeMode.system; // Default to system theme
  Locale _currentLocale = Locale('en', ''); // Default language is English

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
    _loadLanguagePreference();
  }

  // Load theme preference from shared preferences
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
  }

  // Load language preference from shared preferences
  Future<void> _loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('languageCode') ?? 'en';
    setState(() {
      _currentLocale = Locale(languageCode, '');
    });
  }

  // Save language preference
  Future<void> _saveLanguagePreference(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
  }

  // Save theme preference
  Future<void> _saveThemePreference(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  void _toggleTheme(bool isDarkMode) {
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
    _saveThemePreference(isDarkMode);
  }

  // Update the app's language
  void _updateLanguage(String languageCode) {
    setState(() {
      _currentLocale = Locale(languageCode, '');
    });
    _saveLanguagePreference(languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Warranty Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.orange,
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black87),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.orange,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: Colors.blue,
          secondary: Colors.orange,
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      themeMode: _themeMode, // Dynamically control theme
      locale: _currentLocale, // Dynamically control language
      localizationsDelegates: [
        S.delegate,
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      // [
      //   const Locale('en', ''), // İngilizce
      //   const Locale('tr', ''), // Türkçe
      // ],
      home: ProductListScreen(
        onThemeChange: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
        onLanguageChange: _updateLanguage, // Pass the language change method
        currentLanguage: _currentLocale.languageCode, // Current language code
      ),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  final Function(bool) onThemeChange;
  final bool isDarkMode;
  final Function(String) onLanguageChange; // Dil değiştirme fonksiyonu
  final String currentLanguage; // Geçerli dil kodu

  ProductListScreen({
    required this.onThemeChange,
    required this.isDarkMode,
    required this.onLanguageChange, // Dil değiştirme fonksiyonu
    required this.currentLanguage, // Geçerli dil kodu
  });

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Product> _products = [];
  List<Product> _filteredProducts = []; // Filtrelenmiş ürünler
  Set<int> _selectedProductIds = {}; // Seçili ürünlerin ID'leri
  bool _isSelectionMode = false; // Seçim modu aktif mi?
  bool _isSearchVisible = false; // Arama alanı görünür mü?
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProducts(); // Başlangıçta tüm ürünleri göster
  }

  void _toggleSelectionMode() {
    setState(() {
      _isSelectionMode = !_isSelectionMode;
      _selectedProductIds.clear(); // Seçim modu değiştiğinde seçimleri temizle
    });
  }

  void _toggleProductSelection(int id) {
    setState(() {
      if (_selectedProductIds.contains(id)) {
        _selectedProductIds.remove(id);
      } else {
        _selectedProductIds.add(id);
      }
    });
  }

  void _deleteSelectedProducts() {
    for (int id in _selectedProductIds) {
      _deleteProduct(id);
    }
    _toggleSelectionMode(); // Seçim modundan çık
  }

  Future<void> _loadProducts() async {
    final products = await _databaseHelper.getProducts();
    setState(() {
      _products = products;
      _filteredProducts = products;
    });
  }

  Future<void> _deleteProduct(int id) async {
    await _databaseHelper.deleteProduct(id);
    setState(() {
      _products.removeWhere((product) => product.id == id);
    });
    _loadProducts();
  }

  void _sortProductsByName() {
    setState(() {
      _products.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  void _sortProductsByWarrantyDate() {
    setState(() {
      _products.sort((a, b) => a.warrantyEndDate.compareTo(b.warrantyEndDate));
    });
  }

  void _viewProductDetails(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(
          product: product,
          onProductDeleted: () {
            // Ürün silindikten sonra yapılacak işlemler (örneğin, ürün listesini yenile)
            _loadProducts(); // Ürün listesini yeniden yükle
          },
          onProductUpdated: () {
            // Ürün güncellendikten sonra yapılacak işlemler (örneğin, ürün listesini yenile)
            _loadProducts(); // Ürün listesini yeniden yükle
          },
        ),
      ),
    );
  }

  void _navigateToEditProductScreen(Product product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductScreen(
          product: product,
          onProductUpdated: () {
            _loadProducts(); // Ürün listesini yeniden yükle
          },
        ),
      ),
    );
    // Güncelleme işlemi yapıldıktan sonra ürünleri yeniden yükle
    _loadProducts();
  }

  void _navigateToAddProductScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProductScreen(onProductAdded: _loadProducts),
      ),
    );
  }

  void _navigateToSettingsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(
          onThemeChange: widget.onThemeChange,
          isDarkMode: widget.isDarkMode,
          currentLanguage: widget.currentLanguage, // Geçerli dil
          onLanguageChange:
              widget.onLanguageChange, // Dil değiştirme fonksiyonu
        ),
      ),
    ).then((_) {
      // SettingsScreen'den dönüşte ekranı yeniden çiz
      setState(() {});
    });
  }

  void _toggleSearchBar() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
      if (!_isSearchVisible) {
        _filteredProducts = _products;
        _searchController.clear();
      }
      _searchController.clear();
      _filteredProducts = _products; // Arama kapatıldığında tüm ürünleri göster
    });
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = _products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
        actions: [
          if (_isSelectionMode)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: _deleteSelectedProducts, // Seçili ürünleri sil
            ),
          IconButton(
            icon: Icon(_isSelectionMode ? Icons.close : Icons.check_circle,
                color: Colors.white),
            onPressed: _toggleSelectionMode, // Seçim modunu aç/kapat
          ),
          PopupMenuButton<String>(
            icon:
                Icon(Icons.sort, color: Colors.white, size: 24), // İkon boyutu
            onSelected: (value) {
              if (value == 'name') {
                _sortProductsByName();
              } else if (value == 'warranty') {
                _sortProductsByWarrantyDate();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'name',
                child: Text(S.of(context).sortByName),
              ),
              PopupMenuItem(
                value: 'warranty',
                child: Text(S.of(context).sortByWarrantyDate),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: _toggleSearchBar,
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: _navigateToSettingsScreen, // Navigate to settings
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isSearchVisible)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "",
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: _filterProducts,
              ),
            ),
          Flexible(
            child: _filteredProducts.isEmpty
                ? Center(child: Text(S.of(context).noProducts))
                : ListView.builder(
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      final isSelected =
                          _selectedProductIds.contains(product.id);

                      bool isWarrantyValid =
                          product.warrantyEndDate.isAfter(DateTime.now());
                      Color iconColor =
                          isWarrantyValid ? Colors.green : Colors.red;

                      return Dismissible(
                        key: Key(product.id.toString()),
                        direction: DismissDirection.horizontal,
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            _navigateToEditProductScreen(product);
                          } else if (direction == DismissDirection.endToStart) {
                            _deleteProduct(product.id!);
                          }
                          setState(() {
                            _filteredProducts.removeAt(index);
                          });
                        },
                        background: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          color: Colors.blue,
                          child:
                              Icon(Icons.edit, color: Colors.white, size: 30),
                        ),
                        secondaryBackground: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          color: Colors.red,
                          child:
                              Icon(Icons.delete, color: Colors.white, size: 30),
                        ),
                        child: GestureDetector(
                          onLongPress: () {
                            _toggleSelectionMode();
                            _toggleProductSelection(product.id!);
                          },
                          onTap: () {
                            if (_isSelectionMode) {
                              _toggleProductSelection(product.id!);
                            } else {
                              _viewProductDetails(product);
                            }
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: Theme.of(context).cardColor,
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                              leading: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: iconColor,
                                ),
                              ),
                              title: Text(
                                product.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),
                                  Text(
                                      '${S.of(context).brand}: ${product.brand}'),
                                  SizedBox(height: 5),
                                  Text(
                                      '${S.of(context).model}: ${product.model}'),
                                ],
                              ),
                              trailing: _isSelectionMode
                                  ? Icon(
                                      isSelected
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank,
                                      color: isSelected
                                          ? Colors.blue
                                          : Colors.grey,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: _navigateToAddProductScreen,
        child: Icon(Icons.add),
      ),
    );
  }
}

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final Function onProductDeleted;
  final Function onProductUpdated;

  ProductDetailScreen({
    required this.product,
    required this.onProductDeleted,
    required this.onProductUpdated,
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Product product;
  String warrantyDuration = ''; // Boş String ile başlatıyoruz

  @override
  void initState() {
    super.initState();
    product = widget.product; // İlk başta product'ı widget'tan alıyoruz
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _calculateWarrantyDuration(); // Garanti süresini burada hesapla
  }

  // Garanti süresini hesaplama fonksiyonu
  void _calculateWarrantyDuration() {
    if (product.purchaseDate != null && product.warrantyEndDate != null) {
      // final difference =
      //     product.warrantyEndDate.difference(product.purchaseDate);
      final difference = product.warrantyEndDate.difference(DateTime.now());

      final years = difference.inDays ~/ 365; // Yıl
      final months = (difference.inDays % 365) ~/ 30; // Ay
      final days = (difference.inDays % 365) % 30; // Gün

      warrantyDuration = ''; // Önce boş bir String olarak başlat

      if (years > 0) {
        warrantyDuration += '$years ${S.of(context).years}'; // Yıl
      }
      if (months > 0) {
        warrantyDuration += (warrantyDuration.isEmpty ? '' : ' ') +
            '$months ${S.of(context).months}'; // Ay
      }
      if (days > 0) {
        warrantyDuration += (warrantyDuration.isEmpty ? '' : ' ') +
            '$days ${S.of(context).days}'; // Gün
      }

      if (warrantyDuration.isEmpty) {
        warrantyDuration = '${S.of(context).expired}'; // Süre sona erdiyse
      }
    } else {
      warrantyDuration = '${S.of(context).expired}'; // Null değer kontrolü
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedPurchaseDate = product.purchaseDate != null
        ? DateFormat('dd/MM/yyyy').format(product.purchaseDate)
        : '-'; // Null kontrolü
    String formattedWarrantyEndDate = product.warrantyEndDate != null
        ? DateFormat('dd/MM/yyyy').format(product.warrantyEndDate)
        : '-'; // Null kontrolü

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).productDetail)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${S.of(context).productName}: ${product.name}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 2, color: Colors.blueGrey),
            SizedBox(height: 8),
            Text('${S.of(context).brand}: ${product.brand}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('${S.of(context).model}: ${product.model}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('${S.of(context).purchaseDate}: $formattedPurchaseDate',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('${S.of(context).warrantyEndDate}: $formattedWarrantyEndDate',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            if (warrantyDuration != null) ...[
              Text(
                '${S.of(context).remainingWarranty}: $warrantyDuration',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
            SizedBox(height: 2),
            // Fotoğraf gösterme alanı
            if (product.warrantyImage != null) ...[
              SizedBox(height: 16),
              Text("deneme",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenImageScreen(
                            imageFile: File(product.warrantyImage!),
                          ),
                        ),
                      );
                    },
                    child: Image.file(
                      File(product.warrantyImage!),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
            ],
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _deleteProduct(context),
                  icon: Icon(Icons.delete),
                  label: Text(S.of(context).delete),
                  style: ElevatedButton.styleFrom(iconColor: Colors.red),
                ),
                TextButton.icon(
                  icon: Icon(Icons.edit),
                  label: Text(S.of(context).edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProductScreen(
                          product: product,
                          onProductUpdated: () {
                            setState(() {
                              product = widget.product; // Güncelleme sonrası
                              _calculateWarrantyDuration(); // Güncellemeden sonra süreyi tekrar hesapla
                            });
                            widget.onProductUpdated();
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _deleteProduct(BuildContext context) async {
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(S.of(context).deleteConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(S.of(context).no),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(S.of(context).yes),
          ),
        ],
      ),
    );

    if (confirm) {
      await DatabaseHelper().deleteProduct(product.id!);
      widget.onProductDeleted();
      Navigator.pop(context);
    }
  }

  void _navigateToEditScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductScreen(
          product: product,
          onProductUpdated: widget.onProductUpdated,
        ),
      ),
    );
  }
}

class FullScreenImageScreen extends StatelessWidget {
  final File imageFile;

  FullScreenImageScreen({required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.file(imageFile),
        ),
      ),
    );
  }
}

class EditProductScreen extends StatefulWidget {
  final Product product;
  final Function onProductUpdated;

  EditProductScreen({required this.product, required this.onProductUpdated});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>(); // Formun anahtarı
  late TextEditingController nameController;
  late TextEditingController brandController;
  late TextEditingController modelController;
  late TextEditingController purchaseDateController;
  late TextEditingController warrantyEndDateController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.name);
    brandController = TextEditingController(text: widget.product.brand);
    modelController = TextEditingController(text: widget.product.model);
    purchaseDateController = TextEditingController(
        text: DateFormat('dd/MM/yyyy').format(widget.product.purchaseDate));
    warrantyEndDateController = TextEditingController(
        text: DateFormat('dd/MM/yyyy').format(widget.product.warrantyEndDate));
  }

  @override
  void dispose() {
    nameController.dispose();
    brandController.dispose();
    modelController.dispose();
    purchaseDateController.dispose();
    warrantyEndDateController.dispose();
    super.dispose();
  }

  // Tarihleri doğrulama ve karşılaştırma
  String? _validateAndCompareDates(String? value, String errorMsg) {
    if (value == null || value.isEmpty) {
      return errorMsg;
    }

    // Tarih formatı kontrolü (dd/MM/yyyy formatında olmalı)
    String pattern = r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/([0-9]{4})$';
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return S.of(context).invalidDateFormat; // Hatalı formatta ise hata mesajı
    }

    // Satın alma ve garanti bitiş tarihlerini karşılaştırma
    final purchaseDateParts = purchaseDateController.text.split('/');
    final warrantyEndDateParts = warrantyEndDateController.text.split('/');

    if (purchaseDateParts.length == 3 && warrantyEndDateParts.length == 3) {
      final purchaseDay = int.tryParse(purchaseDateParts[0]) ?? 1;
      final purchaseMonth = int.tryParse(purchaseDateParts[1]) ?? 1;
      final purchaseYear =
          int.tryParse(purchaseDateParts[2]) ?? DateTime.now().year;

      final warrantyDay = int.tryParse(warrantyEndDateParts[0]) ?? 1;
      final warrantyMonth = int.tryParse(warrantyEndDateParts[1]) ?? 1;
      final warrantyYear =
          int.tryParse(warrantyEndDateParts[2]) ?? DateTime.now().year;

      final purchaseDate = DateTime(purchaseYear, purchaseMonth, purchaseDay);
      final warrantyEndDate =
          DateTime(warrantyYear, warrantyMonth, warrantyDay);

      if (warrantyEndDate.isBefore(purchaseDate)) {
        return S
            .of(context)
            .warrantyBeforePurchaseError; // Garanti tarihi satın almadan önce olamaz
      }

      if (warrantyEndDate.isAtSameMomentAs(purchaseDate)) {
        return S
            .of(context)
            .warrantySameAsPurchaseError; // Garanti tarihi satın alma ile aynı olamaz
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).editProduct)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Form doğrulaması için anahtar
          child: ListView(
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
                readOnly: true,
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
                validator: (value) => _validateAndCompareDates(
                    value, S.of(context).purchaseDateEmpty),
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
                validator: (value) => _validateAndCompareDates(
                    value, S.of(context).warrantyDateEmpty),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Eğer form geçerli ise güncelleme işlemi
                    final updatedProduct = Product(
                      id: widget.product.id,
                      name: nameController.text,
                      brand: brandController.text,
                      model: modelController.text,
                      purchaseDate: DateFormat('dd/MM/yyyy')
                          .parse(purchaseDateController.text),
                      warrantyEndDate: DateFormat('dd/MM/yyyy')
                          .parse(warrantyEndDateController.text),
                    );

                    // Veritabanında güncelleme işlemi
                    DatabaseHelper().updateProduct(updatedProduct);
                    widget.onProductUpdated(); // Ana sayfayı güncelle
                    Navigator.pop(context);
                  }
                },
                child: Text(S.of(context).update),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
