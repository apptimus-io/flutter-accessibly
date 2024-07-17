# Accessibly Features

## Overview
The Accessibly Features app allows users to customize their experience based on their accessibility needs. It provides options to adjust font size, line height, letter spacing, text colors, background colors, alignment, and more.
**Checkers and tools to ensure your app is accessible to all.**

Creating an accessible app is incredibly important. But too often it's forgotten about, or left to later. This package ensures your app is accessible from day one, by checking your interface as you build it.

## Features
    Accessibly Modes:
    Dark mode
    System default mode
    Monochrome
    Visually Impaired Mode
    Cognitive Disability mode
    Image visibility control
    Readable Experience:
    Font size adjustment
    Line height adjustment
    Letter spacing adjustment
    Text alignment options
    Visually Pleasing Experience:
    Adjust title colors
    Adjust text colors
    Adjust background colors
    Reset Functionality:
    Reset all settings to default
## Getting Started

Add `Accessibly` to your app's `Consumer` property:

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Accessibly>(
      builder: (context, accessibilitySettings, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Accessibly Features',
          themeMode: accessibilitySettings.systemMode
              ? ThemeMode.system
              : (accessibilitySettings.isDark
                  ? ThemeMode.dark
                  : ThemeMode.light),
          darkTheme: accessibilitySettings.darkTheme,
          theme: accessibilitySettings.lightTheme,
          home: const MyWidget(),
        );
      },
    );
  }
}
}
```
## Current accessibility checkers

To get the Accessibly Controll:

```dart
appBar: AppBar(
            title: const Text('Accessibly Features'),
            actions: [
              Builder(
                // Wrap the IconButton with Builder widget
                builder: (context) => IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    // Use the context from the Builder
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccessiblyScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
```

### widget in Accessiblity-features

Makes sure Text  (`AccessiblyHeadingText`, `AccessiblyText`,) and Images (`AccessiblyImage`) have semantic labels.

## Configuration

Checkers are enabled or disabled with properties on the `Accessibly` widget:

```dart
 AccessiblyHeadingText(
   "Hello This is Accessibly...",
    style: TextStyle(fontSize: 30),
),
```
```dart
AccessiblyText(
   "This is a simple text widget",
   style: TextStyle(fontSize: 20),
   ),
```
```dart
AccessiblyImage(
   image: AssetImage('assets/hello.png'),
   width: 200,
   height: 250,
   fit: BoxFit.cover,
   alignment: Alignment.center,
   colorBlendMode: BlendMode.colorBurn,
   filterQuality: FilterQuality.high,
  ),
```

[rebel_home]: https://rebelappstudio.com/
