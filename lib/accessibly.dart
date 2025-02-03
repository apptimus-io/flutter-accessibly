import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { light, dark, highContrast }

class Accessibly extends ChangeNotifier {
  // Constants for SharedPreferences keys
  static const String _isDarkKey = "isDark";
  static const String _isSystemKey = "isSystem";
  static const String _imageVisibilityKey = "imageVisibility";
  static const String _headingColorKey = "headingColor";
  static const String _subHeadingColorKey = "subHeadingColor";
  static const String _textColorKey = "textColor";
  static const String _subTextColorKey = "subTextColor";
  static const String _primaryColorKey = "primaryColor";
  static const String _errorTextColorKey = "errorTextColor";
  static const String _errorBackgroundColorKey = "errorBackgroundColor";
  static const String _errorIconColorKey = "errorIconColor";
  static const String _textBgColorKey = "textBgColor";
  static const String _iconColorKey = "iconColor";
  static const String _background1ColorKey = "background1Color";
  static const String _background2ColorKey = "background2Color";
  static const String _background3ColorKey = "background3Color";
  static const String _impairedModeKey = "impairedMode";
  static const String _adhdKey = "adhd";
  static const String _cognitiveModeKey = "cognitiveMode";
  static const String _letterSpacingKey = "letterSpacing";
  static const String _lineHeightKey = "lineHeight";
  static const String _monochromeKey = "monochrome";
  static const String _textScaleFactorKey = "textScaleFactor";

  // Properties
  bool _colorBlindMode = false;
  bool _impairedMode = false;
  bool _cognitiveMode = false;
  bool _adhd = false;
  int _textScaleFactor = 100;
  Color? _headingColor;
  Color? _subHeadingColor;
  Color? _textColor;
  Color? _subTextColor;
  Color? _primaryColor;
  Color? _errorTextColor;
  Color? _errorBackgroundColor;
  Color? _errorIconColor;
  Color? _textBgColor;
  Color? _iconColor;
  Color? _background1Color;
  Color? _background2Color;
  Color? _background3Color;
  Color _scaldBgColor = Colors.white;
  int _lineHeight = 0;
  int _letterSpacing = 100;
  Color? _imageColor = Colors.white;
  bool _imageVisibility = true;
  TextAlign _textAlignment = TextAlign.left;
  bool _monochrome = false;
  bool _systemMode = false;
  bool _isDark = false;
  SharedPreferences? _storage;

  // Getters
  bool get colorBlindMode => _colorBlindMode;
  bool get impairedMode => _impairedMode;
  bool get adhd => _adhd;
  bool get cognitiveMode => _cognitiveMode;
  bool get monochrome => _monochrome;
  int get textScaleFactor => _textScaleFactor;
  Color? get headingColor => _headingColor;
  Color? get subHeadingColor => _subHeadingColor;
  Color? get textColor => _textColor;
  Color? get subTextColor => _subTextColor;
  Color? get primaryColor => _primaryColor;
  Color? get errorTextColor => _errorTextColor;
  Color? get errorBackgroundColor => _errorBackgroundColor;
  Color? get errorIconColor => _errorIconColor;
  Color? get textBgColor => _textBgColor;
  Color? get iconColor => _iconColor;
  Color? get background1Color => _background1Color;
  Color? get background2Color => _background2Color;
  Color? get background3Color => _background3Color;
  Color get scaldBgColor => _scaldBgColor;
  int get lineHeight => _lineHeight;
  int get letterSpacing => _letterSpacing;
  Color? get imageColor => _imageColor;
  bool get imageVisibility => _imageVisibility;
  TextAlign get textAlignment => _textAlignment;
  bool get systemMode => _systemMode;
  bool get isDark => _isDark;

  // Theme Data
  final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    primaryColorDark: Colors.black,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
    ),
  );

  final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    primaryColorDark: Colors.white,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
    ),
  );

  // Initialize the provider
  Future<void> init() async {
    _storage = await SharedPreferences.getInstance();
    _isDark = _storage?.getBool(_isDarkKey) ?? false;
    _systemMode = _storage?.getBool(_isSystemKey) ?? false;
    _imageVisibility = _storage?.getBool(_imageVisibilityKey) ?? true;
    _headingColor = _stringToColor(_storage?.getString(_headingColorKey));
    _subHeadingColor = _stringToColor(_storage?.getString(_subHeadingColorKey));
    _textColor = _stringToColor(_storage?.getString(_textColorKey));
    _subTextColor = _stringToColor(_storage?.getString(_subTextColorKey));
    _primaryColor = _stringToColor(_storage?.getString(_primaryColorKey));
    _errorTextColor = _stringToColor(_storage?.getString(_errorTextColorKey));
    _errorBackgroundColor =
        _stringToColor(_storage?.getString(_errorBackgroundColorKey));
    _errorIconColor = _stringToColor(_storage?.getString(_errorIconColorKey));
    _textBgColor = _stringToColor(_storage?.getString(_textBgColorKey));
    _iconColor = _stringToColor(_storage?.getString(_iconColorKey));
    _background1Color =
        _stringToColor(_storage?.getString(_background1ColorKey));
    _background2Color =
        _stringToColor(_storage?.getString(_background2ColorKey));
    _background3Color =
        _stringToColor(_storage?.getString(_background3ColorKey));
    _impairedMode = _storage?.getBool(_impairedModeKey) ?? false;
    _adhd = _storage?.getBool(_adhdKey) ?? false;
    _cognitiveMode = _storage?.getBool(_cognitiveModeKey) ?? false;
    _letterSpacing = _storage?.getInt(_letterSpacingKey) ?? 100;
    _lineHeight = _storage?.getInt(_lineHeightKey) ?? 0;
    _monochrome = _storage?.getBool(_monochromeKey) ?? false;
    _textScaleFactor = _storage?.getInt(_textScaleFactorKey) ?? 100;

    notifyListeners();
  }

  // Helper method to convert string to Color
  Color? _stringToColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) return null;
    return Color(int.parse(colorString));
  }

  // Helper method to convert Color to string
  String? _colorToString(Color? color) {
    if (color == null) return null;
    return color.value.toString();
  }

  // Toggle dark/light theme
  void changeTheme() {
    _isDark = !_isDark;
    _storage?.setBool(_isDarkKey, _isDark);
    _imageColor = Colors.white;
    notifyListeners();
  }

  // Toggle impaired mode
  void toggleImpairedMode() {
    _impairedMode = !_impairedMode;
    _storage?.setBool(_impairedModeKey, _impairedMode);
    notifyListeners();
  }

  // Toggle cognitive mode
  void toggleCognitiveMode() {
    _cognitiveMode = !_cognitiveMode;
    _storage?.setBool(_cognitiveModeKey, _cognitiveMode);
    notifyListeners();
  }

  // Toggle ADHD mode
  void toggleADHDMode() {
    _adhd = !_adhd;
    _storage?.setBool(_adhdKey, _adhd);
    notifyListeners();
  }

  // Toggle monochrome mode
  void toggleMonochrome() {
    _monochrome = !_monochrome;
    _storage?.setBool(_monochromeKey, _monochrome);
    notifyListeners();
  }

  // Toggle system mode
  void toggleSystem() {
    _systemMode = !_systemMode;
    _storage?.setBool(_isSystemKey, _systemMode);
    notifyListeners();
  }

  // Adjust text size
  void adjustTextSize(int newTextScaleFactor) {
    _textScaleFactor = newTextScaleFactor;
    _storage?.setInt(_textScaleFactorKey, _textScaleFactor);
    notifyListeners();
  }

  // Increase font size
  void increaseFontSize() {
    if (_textScaleFactor <= 160) {
      _textScaleFactor += 20;
      _storage?.setInt(_textScaleFactorKey, _textScaleFactor);
      notifyListeners();
    }
  }

  // Decrease font size
  void decreaseFontSize() {
    if (_textScaleFactor >= 60) {
      _textScaleFactor -= 20;
      _storage?.setInt(_textScaleFactorKey, _textScaleFactor);
      notifyListeners();
    }
  }

  // Toggle image visibility
  void hideImage() {
    _imageVisibility = !_imageVisibility;
    _storage?.setBool(_imageVisibilityKey, _imageVisibility);
    notifyListeners();
  }

  // Set heading color
  void setHeadingColor(Color color) {
    _headingColor = color;
    _storage?.setString(_headingColorKey, _colorToString(color)!);
    notifyListeners();
  }

  // Set subheading color
  void setSubHeadingColor(Color color) {
    _subHeadingColor = color;
    _storage?.setString(_subHeadingColorKey, _colorToString(color)!);
    notifyListeners();
  }

  // Set text color
  void setTextColor(Color color) {
    _textColor = color;
    _storage?.setString(_textColorKey, _colorToString(color)!);
    notifyListeners();
  }

  // Set subtext color
  void setSubTextColor(Color color) {
    _subTextColor = color;
    _storage?.setString(_subTextColorKey, _colorToString(color)!);
    notifyListeners();
  }

  // Set primary color
  void setPrimaryColor(Color color) {
    _primaryColor = color;
    _storage?.setString(_primaryColorKey, _colorToString(color)!);
    notifyListeners();
  }

  // Set error text color
  void setErrorTextColor(Color color) {
    _errorTextColor = color;
    _storage?.setString(_errorTextColorKey, _colorToString(color)!);
    notifyListeners();
  }

  // Set error background color
  void setErrorBackgroundColor(Color color) {
    _errorBackgroundColor = color;
    _storage?.setString(_errorBackgroundColorKey, _colorToString(color)!);
    notifyListeners();
  }

  // Set error icon color
  void setErrorIconColor(Color color) {
    _errorIconColor = color;
    _storage?.setString(_errorIconColorKey, _colorToString(color)!);
    notifyListeners();
  }

  // Set text background color
  void setTextBgColor(Color color) {
    _textBgColor = color;
    _storage?.setString(_textBgColorKey, _colorToString(color)!);
    notifyListeners();
  }

  // Set icon color
  void setIconColor(Color color) {
    _iconColor = color;
    _storage?.setString(_iconColorKey, _colorToString(color)!);
    notifyListeners();
  }

  // Set background 1 color
  void setBackground1Color(Color color) {
    _background1Color = color;
    _storage?.setString(_background1ColorKey, _colorToString(color)!);
    notifyListeners();
  }

  // Set background 2 color
  void setBackground2Color(Color color) {
    _background2Color = color;
    _storage?.setString(_background2ColorKey, _colorToString(color)!);
    notifyListeners();
  }

  // Set background 3 color
  void setBackground3Color(Color color) {
    _background3Color = color;
    _storage?.setString(_background3ColorKey, _colorToString(color)!);
    notifyListeners();
  }

  // Set scaffold background color
  void setScaffoldColor(Color color) {
    _scaldBgColor = color;
    notifyListeners();
  }

  // Increase line height
  void increaseLineHeight() {
    if (_lineHeight <= 80) {
      _lineHeight += 5;
      _storage?.setInt(_lineHeightKey, _lineHeight);
      notifyListeners();
    }
  }

  // Decrease line height
  void decreaseLineHeight() {
    if (_lineHeight >= 5) {
      _lineHeight -= 5;
      _storage?.setInt(_lineHeightKey, _lineHeight);
      notifyListeners();
    }
  }

  // Increase letter spacing
  void increaseLetterSpace() {
    if (_letterSpacing <= 150) {
      _letterSpacing += 5;
      _storage?.setInt(_letterSpacingKey, _letterSpacing);
      notifyListeners();
    }
  }

  // Decrease letter spacing
  void decreaseLetterSpace() {
    if (_letterSpacing >= 90) {
      _letterSpacing -= 5;
      _storage?.setInt(_letterSpacingKey, _letterSpacing);
      notifyListeners();
    }
  }

  // Reset all settings
  void reset() {
    _impairedMode = false;
    _adhd = false;
    _cognitiveMode = false;
    _monochrome = false;
    _colorBlindMode = false;
    _textScaleFactor = 100;
    _textBgColor = null;
    _scaldBgColor = Colors.white;
    _imageColor = Colors.white;
    _lineHeight = 0;
    _letterSpacing = 100;
    _imageVisibility = true;
    _textAlignment = TextAlign.left;
    _isDark = false;
    _systemMode = false;
    _headingColor = null;
    _subHeadingColor = null;
    _textColor = null;
    _subTextColor = null;
    _primaryColor = null;
    _errorTextColor = null;
    _errorBackgroundColor = null;
    _errorIconColor = null;
    _iconColor = null;
    _background1Color = null;
    _background2Color = null;
    _background3Color = null;

    // Save reset values to SharedPreferences
    _storage?.setBool(_impairedModeKey, _impairedMode);
    _storage?.setBool(_adhdKey, _adhd);
    _storage?.setBool(_cognitiveModeKey, _cognitiveMode);
    _storage?.setBool(_isDarkKey, _isDark);
    _storage?.setBool(_isSystemKey, _systemMode);
    _storage?.setBool(_imageVisibilityKey, _imageVisibility);
    _storage?.setString(_headingColorKey, _colorToString(_headingColor) ?? "");
    _storage?.setString(
        _subHeadingColorKey, _colorToString(_subHeadingColor) ?? "");
    _storage?.setString(_textColorKey, _colorToString(_textColor) ?? "");
    _storage?.setString(_subTextColorKey, _colorToString(_subTextColor) ?? "");
    _storage?.setString(_primaryColorKey, _colorToString(_primaryColor) ?? "");
    _storage?.setString(
        _errorTextColorKey, _colorToString(_errorTextColor) ?? "");
    _storage?.setString(
        _errorBackgroundColorKey, _colorToString(_errorBackgroundColor) ?? "");
    _storage?.setString(
        _errorIconColorKey, _colorToString(_errorIconColor) ?? "");
    _storage?.setString(_textBgColorKey, _colorToString(_textBgColor) ?? "");
    _storage?.setString(_iconColorKey, _colorToString(_iconColor) ?? "");
    _storage?.setString(
        _background1ColorKey, _colorToString(_background1Color) ?? "");
    _storage?.setString(
        _background2ColorKey, _colorToString(_background2Color) ?? "");
    _storage?.setString(
        _background3ColorKey, _colorToString(_background3Color) ?? "");
    _storage?.setInt(_lineHeightKey, _lineHeight);
    _storage?.setInt(_letterSpacingKey, _letterSpacing);
    _storage?.setInt(_textScaleFactorKey, _textScaleFactor);
    _storage?.setBool(_monochromeKey, _monochrome);

    notifyListeners();
  }
}
