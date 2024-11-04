import 'package:flutter/material.dart';
import 'generated/l10n.dart';

class SettingsScreen extends StatefulWidget {
  final Function(bool) onThemeChange;
  final bool isDarkMode;
  final String currentLanguage;
  final Function(String) onLanguageChange;

  SettingsScreen({
    required this.onThemeChange,
    required this.isDarkMode,
    required this.currentLanguage,
    required this.onLanguageChange,
  });

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool? _isDarkMode;
  String? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _selectedLanguage = widget.currentLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: Text(S.of(context).settings)),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${S.of(context).themeSelection}:',
                  style: TextStyle(fontSize: 18),
                ),
                SwitchListTile(
                  title: Text(S.of(context).darkMode),
                  value: _isDarkMode!,
                  onChanged: (value) {
                    setState(() {
                      _isDarkMode = value;
                    });
                    widget.onThemeChange(value); // Tema değiştir
                  },
                ),
                SizedBox(height: 20),
                Text(
                  '${S.of(context).languageSelection}:',
                  style: TextStyle(fontSize: 18),
                ),
                DropdownButton<String>(
                  value: _selectedLanguage,
                  onChanged: (String? newValue) {
                    if (newValue != null && newValue != _selectedLanguage) {
                      setState(() {
                        _selectedLanguage = newValue;
                      });
                      widget.onLanguageChange(newValue); // Dil değiştir
                    }
                  },
                  items: <String>['en', 'tr'] // Desteklenen diller
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value == 'en' ? 'English' : 'Türkçe'),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
