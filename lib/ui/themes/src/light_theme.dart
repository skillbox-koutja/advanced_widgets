part of '../theme.dart';

ThemeData createLightTheme() {
  return ThemeData(
    colorScheme: const ColorScheme.light(),
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightBackground,
      actionsIconTheme: const IconThemeData(
        color: Colors.black,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    ),
    extensions: [
      ThemeColors.light,
    ],
  );
}