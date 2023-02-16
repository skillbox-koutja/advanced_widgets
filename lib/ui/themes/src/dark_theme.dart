part of '../theme.dart';

ThemeData createDarkTheme() {
  return ThemeData(
    colorScheme: const ColorScheme.dark(),
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    ),
    extensions: [
      ThemeColors.dark,
    ],
  );
}