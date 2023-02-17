import 'dart:math';

import 'package:advanced_widgets/ui/themes/theme.dart';
import 'package:flutter/material.dart';

class WeatherIndicator extends CustomPainter {
  final double cloudiness;
  final ThemeColors colors;

  const WeatherIndicator({
    required this.cloudiness,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawSun(
      cloudiness: cloudiness,
      canvas: canvas,
      size: size,
      colors: colors,
    );

    _drawCloud(
      cloudiness: cloudiness,
      canvas: canvas,
      size: size,
      colors: colors,
    );

    _drawDrops(
      cloudiness: cloudiness,
      canvas: canvas,
      size: size,
      colors: colors,
    );
  }

  @override
  bool shouldRepaint(covariant WeatherIndicator oldDelegate) {
    return oldDelegate.cloudiness != cloudiness || oldDelegate.colors != colors;
  }
}

void _drawSun({
  required double cloudiness,
  required Canvas canvas,
  required Size size,
  required ThemeColors colors,
}) {
  if (cloudiness > 0.7) return;

  final center = size / 2;

  final sunPaint = Paint()..color = colors.sun;
  final sunRadius = max(center.width, center.height) / 2;

  canvas.drawCircle(Offset(center.width, center.height), sunRadius, sunPaint);
}

void _drawCloud({
  required double cloudiness,
  required Canvas canvas,
  required Size size,
  required ThemeColors colors,
}) {
  if (cloudiness < 0.1) return;

  final center = size / 2;
  final cloudPaint = Paint()
    ..color = getCloudColor(
      cloudiness: cloudiness,
      colors: colors,
    );

  double dy (double init) {
    return center.height / 2 + init;
  }

  final cloudPath = Path()
    ..moveTo(size.width * 0.7, dy(size.height * 0.15))
    ..arcToPoint(
      Offset(size.width * 0.7, dy(size.height * 0.15)),
      radius: Radius.elliptical(size.width * 0.18, size.height * 0.18),
      clockwise: false,
    )
    ..arcToPoint(
      Offset(size.width * 0.5, dy(size.height * 0.07)),
      radius: Radius.elliptical(size.width * 0.25, size.height * 0.25),
      clockwise: false,
    )
    ..arcToPoint(
      Offset(size.width * 0.25, dy(size.height * 0.22)),
      radius: Radius.elliptical(size.width * 0.25, size.height * 0.25),
      clockwise: false,
    )
    ..arcToPoint(
      Offset(size.width * 0.25, dy(size.height * 0.55)),
      radius: Radius.elliptical(size.width * 0.16, size.height * 0.16),
      clockwise: false,
    )
    ..lineTo(size.width * 0.7, dy(size.height * 0.55))
    ..arcToPoint(
      Offset(size.width * 0.7, dy(size.height * 0.15)),
      radius: Radius.elliptical(size.width * 0.21, size.height * 0.21),
      clockwise: false,
    )
    ..close();

  canvas.drawPath(cloudPath, cloudPaint);
}

Color getCloudColor({
  required double cloudiness,
  required ThemeColors colors,
}) {
  if (cloudiness > 0.7) {
    return colors.hardCloud;
  }

  const limit = 0.6;

  return colors.cloud.withOpacity(min(cloudiness, limit) / limit);
}

void _drawDrops({
  required double cloudiness,
  required Canvas canvas,
  required Size size,
  required ThemeColors colors,
}) {
  if (cloudiness < 0.7) return;

  final center = size / 2;

  final dropsPaint = Paint()
    ..color = colors.drops
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeCap = StrokeCap.round
    ..strokeWidth = size.width * 0.05;

  final path_0 = Path();

  if (cloudiness <= 0.8 || cloudiness > 0.9) {
    path_0
      ..moveTo(size.width * 0.54, center.height / 2 + size.height * 0.5)
      ..lineTo(size.width * 0.5, center.height / 5 + size.height * 0.75);
  }

  if (cloudiness >= 0.9) {
    path_0
      ..moveTo(size.width * 0.4, center.height / 2 + size.height * 0.5)
      ..lineTo(size.width * 0.36, center.height / 5 + size.height * 0.75)
      ..moveTo(size.width * 0.66, center.height / 2 + size.height * 0.5)
      ..lineTo(size.width * 0.62, center.height / 5 + size.height * 0.75);
  }

  canvas.drawPath(path_0, dropsPaint);
}

List<AnimateOffset> calculateCloudAnimateOffsets(Size center, double cloudiness) {
  return [
    CloudAnimateOffset(Offset(
      center.width / 10,
      center.height / 3,
    )).animate(cloudiness),
    Cloud2AnimateOffset(Offset(
      center.width / 2,
      center.height / 2,
    )).animate(cloudiness),
  ];
}

abstract class AnimateOffset {
  final Offset offset;

  const AnimateOffset(this.offset);

  AnimateOffset animate(double cloudiness);
}

class CloudAnimateOffset extends AnimateOffset {
  CloudAnimateOffset(super.offset);

  @override
  CloudAnimateOffset animate(double cloudiness) {
    const limit = 0.7;

    return CloudAnimateOffset(Offset(
      offset.dx,
      offset.dy - offset.dy * min(cloudiness, limit) / limit,
    ));
  }
}

class Cloud2AnimateOffset extends AnimateOffset {
  Cloud2AnimateOffset(super.offset);

  @override
  Cloud2AnimateOffset animate(double cloudiness) {
    const limit = 0.7;

    return Cloud2AnimateOffset(Offset(
      offset.dx,
      offset.dy - offset.dy / 2 * (min(cloudiness, limit) - 0.1) / limit,
    ));
  }
}
