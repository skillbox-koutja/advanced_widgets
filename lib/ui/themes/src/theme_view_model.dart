part of '../theme.dart';

class ThemeViewModel extends InheritedWidget {
  final ThemeMode themeMode;

  const ThemeViewModel({
    required this.themeMode,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(ThemeViewModel oldWidget) => oldWidget.themeMode != themeMode;

  static ThemeViewModel? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<ThemeViewModel>();
}
