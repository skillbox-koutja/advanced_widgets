import 'package:advanced_widgets/ui/home/screen.dart';
import 'package:advanced_widgets/ui/themes/theme.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode themeMode = ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return ThemeViewModel(
      themeMode: themeMode,
      child: Builder(
        builder: (innerContext) {
          debugPrint('$themeMode');

          return MaterialApp(
            theme: themeMode == ThemeMode.light ? createLightTheme() : createDarkTheme(),
            home: Material(
              child: HomeScreen(
                toLight: toLight,
                toDark: toDark,
              ),
            ),
          );
        },
      ),
    );
  }

  void toLight () {
    setState(() {
      themeMode = ThemeMode.light;
    });
  }

  void toDark () {
    setState(() {
      themeMode = ThemeMode.dark;
    });
  }
}