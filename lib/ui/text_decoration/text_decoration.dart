import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class InnerShadowText extends SingleChildRenderObjectWidget {
  final double blur;
  final Color color;
  final Offset offset;

  const InnerShadowText({
    this.blur = 2,
    this.color = Colors.blueAccent,
    this.offset = const Offset(0, 5),
    Key? key,
    Widget? child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    final renderObject = RenderInnerShadowText();
    updateRenderObject(context, renderObject);

    return renderObject;
  }

  @override
  void updateRenderObject(BuildContext context, RenderInnerShadowText renderObject) {
    renderObject
      ..color = color
      ..blur = blur
      ..dx = offset.dx
      ..dy = offset.dy;
  }
}

class RenderInnerShadowText extends RenderProxyBox {
  late double blur;
  late Color color;
  late double dx;
  late double dy;

  @override
  void paint(PaintingContext context, Offset offset) {
    final childBox = child;
    if (childBox == null) return;

    final rectOuter = offset & size;
    final rectInner = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      size.width - dx,
      size.height - dy,
    );
    final canvas = context.canvas..saveLayer(rectOuter, Paint());
    context.paintChild(childBox, offset);
    final shadowPaint = Paint()
      ..blendMode = BlendMode.srcATop
      ..imageFilter = ImageFilter.blur(sigmaX: blur, sigmaY: blur)
      ..colorFilter = ColorFilter.mode(color, BlendMode.srcOut);

    canvas
      ..saveLayer(rectOuter, shadowPaint)
      ..saveLayer(rectInner, Paint())
      ..translate(dx, dy);
    context.paintChild(childBox, offset);
    context.canvas
      ..restore()
      ..restore()
      ..restore();
  }
}
