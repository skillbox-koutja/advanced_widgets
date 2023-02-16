part of '../theme.dart';

class ThemeColors extends ThemeExtension<ThemeColors> {

  final Color background;
  final Color sun;
  final Color cloud;
  final Color hardCloud;
  final Color drops;

  ThemeColors({
    required this.background,
    required this.sun,
    required this.cloud,
    required this.hardCloud,
    required this.drops,
  });

  static ThemeColors get light => ThemeColors(
    background: AppColors.lightBackground,
    sun: AppColors.lightSun,
    cloud: AppColors.lightCloud,
    hardCloud: AppColors.lightHardCloud,
    drops: AppColors.lightDrops,
  );

  static ThemeColors get dark => ThemeColors(
    background: AppColors.darkBackground,
    sun: AppColors.darkSun,
    cloud: AppColors.darkCloud,
    hardCloud: AppColors.darkHardCloud,
    drops: AppColors.darkDrops,
  );

  @override
  ThemeExtension<ThemeColors> lerp(
    ThemeExtension<ThemeColors>? other,
    double t,
  ) {
    if (other is! ThemeColors) {
      return this;
    }

    return ThemeColors(
      background: Color.lerp(background, other.background, t)!,
      sun: Color.lerp(sun, other.sun, t)!,
      cloud: Color.lerp(cloud, other.cloud, t)!,
      hardCloud: Color.lerp(hardCloud, other.hardCloud, t)!,
      drops: Color.lerp(drops, other.drops, t)!,
    );
  }

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? background,
    Color? sun,
    Color? cloud,
    Color? hardCloud,
    Color? drops,
  }) {
    return ThemeColors(
      background: background ?? this.background,
      sun: sun ?? this.sun,
      cloud: cloud ?? this.cloud,
      hardCloud: cloud ?? this.hardCloud,
      drops: drops ?? this.drops,
    );
  }
}
