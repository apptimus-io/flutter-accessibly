import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { light, dark, highContrast }

enum FontSize { small, medium, large }

enum LineHeight { compact, normal, spacious }

enum LetterSpace { compact, normal, spacious }
// enum MonochromeMode { off, on }

class Accessibly extends ChangeNotifier {
  // AppTheme _currentTheme = AppTheme.light;
  bool _colorBlindMode = false;
  bool _impairedMode = false;
  bool _cognitiveMode = false;
  bool _adhd = false;
  int _textScaleFactor = 100;
  Color? _headingColor; // Default heading color as string
  Color? _subHeadingColor;
  Color? _textColor; // Default text color
  Color? _primaryColor;
  Color? _errorTextColor;
  Color? _textBgColor; // Default text background color
  Color _scaldBgColor = Colors.white; // Default scaffold background color
  double _lineHeight = 0; // Default line height
  int _letterSpacing = 100;
  Color? _imageColor = Colors.white;
  bool _imageVisibility = true;
  TextAlign _textAlignment = TextAlign.left;
  bool _monochrome = false;
  bool _systemMode = false;
  bool _isDark = true;
  SharedPreferences? storage;

  // Getter methods for accessing properties
  // AppTheme get currentTheme => _currentTheme;
  bool get colorBlindMode => _colorBlindMode;
  bool get impairedMode => _impairedMode;
  bool get adhd => _adhd;
  bool get cognitiveMode => _cognitiveMode;
  bool get monochrome => _monochrome;
  int get textScaleFactor => _textScaleFactor;
  Color? get headingColor => _headingColor;
  Color? get subHeadingColor => _subHeadingColor;
  Color? get textColor => _textColor;
  Color? get primaryColor => _primaryColor;
  Color? get textBgColor => _textBgColor;
  Color? get errorTextColor => _errorTextColor;
  Color get scaldBgColor => _scaldBgColor;
  double get lineHeight => _lineHeight;
  int get letterSpacing => _letterSpacing;
  Color? get imageColor => _imageColor;
  bool get imageVisibility => _imageVisibility;
  TextAlign get textAlignment => _textAlignment;
  bool get systemMode => _systemMode;
  bool get isDark => _isDark;

  // Constructor to initialize the theme
  Accessibly() {
    // _currentTheme = AppTheme.light;
    // _colorBlindMode = false;
    _textScaleFactor = 100;
  }

  final darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    primaryColorDark: Colors.black,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
    ),
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    primaryColorDark: Colors.white,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
    ),
  );

  changeTheme() {
    _isDark = !isDark;
    storage?.setBool("isDark", _isDark);
    _imageColor = Colors.white;
    notifyListeners();
  }

  //Init method of provider
  init() async {
    // After we re run the appS
    storage = await SharedPreferences.getInstance();
    _isDark = storage?.getBool("isDark") ?? true;
    _systemMode = storage?.getBool("isSystem") ?? false;
    _imageVisibility = storage?.getBool("imageVisibility") ?? true;
    _headingColor = stringToColor(storage?.getString("headingColor"));
    _subHeadingColor = stringToColor(storage?.getString("subHeadingColor"));
    _textColor = stringToColor(storage?.getString("textColor"));
    _primaryColor = stringToColor(storage?.getString("primaryColor"));
    _errorTextColor = stringToColor(storage?.getString("errorTextColor"));
    _textBgColor = stringToColor(storage?.getString("textBgColor"));
    _impairedMode = storage?.getBool("impairedMode") ?? false;
    _adhd = storage?.getBool("adhd") ?? false;
    _cognitiveMode = storage?.getBool("cognitiveMode") ?? false;
    _letterSpacing = storage!.getInt("letterSpacing") ?? 100;
    _lineHeight = storage!.getDouble("lineHeight") ?? 0.0;
    _monochrome = storage?.getBool("monochrome") ?? false;
    _textScaleFactor = storage?.getInt("textScaleFactor") ?? 100;

    notifyListeners();
  }

  Color? stringToColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) {
      return null;
    }
    return Color(int.parse(colorString));
  }

  String? colorToString(Color? color) {
    if (color == null) {
      return null;
    }
    return color.value.toString();
  }

  ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
  );
  ThemeData darkMode = ThemeData(brightness: Brightness.dark);

  // Method to increase font size
  void increaseFontSize() {
    if (_textScaleFactor <= 160) {
      _textScaleFactor += 20;
      updateTextScaleFactor();
    }
  }

  void changeFontSize(FontSize size) {
    if (size == FontSize.small) {
      _textScaleFactor = 80;
    } else if (size == FontSize.large) {
      _textScaleFactor = 120;
    } else if (size == FontSize.medium) {
      _textScaleFactor = 100;
    }
    updateTextScaleFactor();
  }

  // Getter for Text Size
  FontSize get fontSizeMode {
    if (_textScaleFactor == 80) {
      return FontSize.small;
    } else if (_textScaleFactor == 120) {
      return FontSize.large;
    }
    return FontSize.medium; // Default
  }

  // Method to decrease font size
  void decreaseFontSize() {
    if (_textScaleFactor >= 60) {
      _textScaleFactor -= 20;
      updateTextScaleFactor();
    }
  }

  // Method to toggle impaired mode
  void toggleimpairedMode() {
    _impairedMode = !_impairedMode;
    storage!.setBool("impairedMode", _impairedMode);
    notifyListeners(); // Notify listeners to update UI
  }

  void togglecognitiveModeMode() {
    _cognitiveMode = !_cognitiveMode;
    storage!.setBool("cognitiveMode", _cognitiveMode);
    notifyListeners(); // Notify listeners to update UI
  }

  // Method to toggle impaired mode
  void toggleADHDMode() {
    _adhd = !_adhd;
    storage!.setBool("adhd", _adhd);
    notifyListeners(); // Notify listeners to update UI
  }

  void toggleMonochrome() {
    _monochrome = !_monochrome;
    storage?.setBool("monochrome", _monochrome);
    notifyListeners();
  }

  void toggleSystem() {
    _systemMode = !_systemMode; // Toggle system mode
    if (_systemMode) {
      // If system mode is on, adjust theme mode based on system brightness
      // final Brightness brightness =
      PlatformDispatcher.instance.platformBrightness;
    }
    storage?.setBool("isSystem", _systemMode);
    notifyListeners();
  }

  // Method to adjust text size
  void adjustTextSize(int newTextScaleFactor) {
    _textScaleFactor = newTextScaleFactor;

    notifyListeners(); // Notify listeners to update UI
  }

  // Method to update text scale factor
  void updateTextScaleFactor() {
    // Calculate text scale factor based on current font size
    storage?.setInt("textScaleFactor", _textScaleFactor);
    notifyListeners(); // Notify listeners to update UI
  }

  void hideImage() {
    // Calculate text scale factor based on current font size
    _imageVisibility = !_imageVisibility; // Assuming 16.0 is the base font size
    storage?.setBool("imageVisibility", _imageVisibility);
    notifyListeners(); // Notify listeners to update UI
  }

  // Method to set heading color
  void setHeadingColor(Color? color) {
    _headingColor = color;
    storage!.setString("headingColor", colorToString(color) ?? "");
    notifyListeners();
  }

  void setSubHeadingColor(Color? color) {
    _subHeadingColor = color;
    storage!.setString("subHeadingColor", colorToString(color) ?? "");
    notifyListeners();
  }

  // Method to set text color
  void setTextAlignment(TextAlign align) {
    _textAlignment = align;
    notifyListeners();
  }

  // Method to set text color
  void setTextColor(Color? color) {
    _textColor = color;
    storage!.setString("textColor", colorToString(color) ?? "");
    notifyListeners();
  }

  void setPrimaryColor(Color? color) {
    _primaryColor = color;
    storage!.setString("primaryColor", colorToString(color) ?? "");
    notifyListeners();
  }

  void setErrorTextColor(Color? color) {
    _errorTextColor = color;
    storage!.setString("errorTextColor", colorToString(color) ?? "");
    notifyListeners();
  }

  // Method to set text background color
  void setTextBgColor(Color? color) {
    _textBgColor = color;

    notifyListeners();
  }

  // Method to set scaffold background color
  void setScalfoldColor(Color color) {
    _scaldBgColor = color;
    notifyListeners();
  }

  void increaseLineHeight() async {
    if (_lineHeight <= 80) {
      _lineHeight += 5;
      storage?.setDouble("lineHeight", _lineHeight);

      notifyListeners();
    }
  }

  void decreaseLineHeight() async {
    if (_lineHeight >= 5) {
      _lineHeight -= 5;
      storage?.setDouble("lineHeight", _lineHeight);

      notifyListeners();
    }
  }

  void changeLineHeight(LineHeight size) {
    if (size == LineHeight.compact) {
      _lineHeight = 12;
    } else if (size == LineHeight.normal) {
      _lineHeight = 0;
    } else if (size == LineHeight.spacious) {
      _lineHeight = 16;
    }
    storage?.setDouble("lineHeight", _lineHeight);
    notifyListeners();
  }

  // Getter for Line Height
  LineHeight get lineHeightMode {
    if (_lineHeight == 12) {
      return LineHeight.compact;
    } else if (_lineHeight == 16) {
      return LineHeight.spacious;
    }
    return LineHeight.normal; // Default
  }

  void increaseLetterSpace() {
    if (_letterSpacing <= 150) {
      _letterSpacing += 5;
      storage!.setInt("letterSpacing", _letterSpacing);
      notifyListeners();
    }
  }

  void decreaseLetterSpace() {
    if (_letterSpacing >= 90) {
      _letterSpacing -= 5;
      storage!.setInt("letterSpacing", _letterSpacing);
      notifyListeners();
    }
  }

  void changeLetterSpace(LetterSpace size) {
    if (size == LetterSpace.compact) {
      _letterSpacing = 110;
    } else if (size == LetterSpace.normal) {
      _letterSpacing = 100;
    } else if (size == LetterSpace.spacious) {
      _letterSpacing = 95;
    }
    storage!.setInt("letterSpacing", _letterSpacing);
    notifyListeners();
  }

  LetterSpace get letterSpacingMode {
    if (_letterSpacing == 110) {
      return LetterSpace.compact;
    } else if (_letterSpacing == 100) {
      return LetterSpace.normal;
    } else if (_letterSpacing == 95) {
      return LetterSpace.spacious;
    }
    return LetterSpace.normal; // Default to normal
  }

  // Method to reset all settings
  void reset() {
    // _currentTheme = AppTheme.light;
    _impairedMode = false;
    _adhd = false;
    _cognitiveMode = false;
    _monochrome = false;
    _colorBlindMode = false;
    _textScaleFactor = 100;
    _textBgColor = null;
    _scaldBgColor = Colors.white;
    _imageColor = Colors.white;
    _lineHeight = 0.0;
    _letterSpacing = 100;
    _imageVisibility = true;
    _textAlignment = TextAlign.left;
    _isDark = true;
    _systemMode = false;
    _headingColor = null;
    _subHeadingColor = null;
    _textColor = null;
    _primaryColor = null;
    _errorTextColor = null;
    storage!.setBool("impairedMode", _impairedMode);
    storage!.setBool("adhd", _adhd);
    storage!.setBool("cognitiveMode", _cognitiveMode);
    storage?.setBool("isDark", _isDark);
    storage?.setBool("isSystem", _systemMode);
    storage?.setBool("imageVisibility", _imageVisibility);
    storage?.setString("headingColor", colorToString(_headingColor) ?? "");
    storage?.setString(
        "subHeadingColor", colorToString(_subHeadingColor) ?? "");
    storage?.setString("textColor", colorToString(_textColor) ?? "");
    storage?.setString("primaryColor", colorToString(_primaryColor) ?? "");
    storage?.setString("errorTextColor", colorToString(_errorTextColor) ?? "");
    storage?.setDouble("lineHeight", _lineHeight);
    storage!.setInt("letterSpacing", _letterSpacing);
    storage!.setInt("textScaleFactor", _textScaleFactor);
    storage?.setBool("monochrome", _monochrome);
    notifyListeners();
  }
}
