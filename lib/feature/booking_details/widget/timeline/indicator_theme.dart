import 'dart:ui' show lerpDouble;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'indicators.dart';
import 'timeline_theme.dart';

@immutable
class IndicatorThemeData with Diagnosticable {
  const IndicatorThemeData({
    this.color,
    this.size,
    this.position,
  });

  final Color? color;
  final double? size;
  final double? position;

  IndicatorThemeData copyWith({
    Color? color,
    double? size,
    double? position,
  }) {
    return IndicatorThemeData(
      color: color ?? this.color,
      size: size ?? this.size,
      position: position ?? this.position,
    );
  }

  static IndicatorThemeData lerp(
      IndicatorThemeData? a, IndicatorThemeData? b, double t) {
    return IndicatorThemeData(
      color: Color.lerp(a?.color, b?.color, t),
      size: lerpDouble(a?.size, b?.size, t),
      position: lerpDouble(a?.position, b?.position, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color, defaultValue: null))
      ..add(DoubleProperty('size', size, defaultValue: null))
      ..add(DoubleProperty('position', size, defaultValue: null));
  }
}

class IndicatorTheme extends InheritedTheme {
  const IndicatorTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final IndicatorThemeData data;

  static IndicatorThemeData of(BuildContext context) {
    final indicatorTheme =
    context.dependOnInheritedWidgetOfExactType<IndicatorTheme>();
    return indicatorTheme?.data ?? TimelineTheme.of(context).indicatorTheme;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final ancestorTheme =
    context.findAncestorWidgetOfExactType<IndicatorTheme>();
    return identical(this, ancestorTheme)
        ? child
        : IndicatorTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(IndicatorTheme oldWidget) => data != oldWidget.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

mixin ThemedIndicatorComponent on PositionedIndicator {
  Color? get color;

  Color getEffectiveColor(BuildContext context) {
    return color ??
        IndicatorTheme.of(context).color ??
        TimelineTheme.of(context).color;
  }

  double? get size;

  double? getEffectiveSize(BuildContext context) {
    return size ?? IndicatorTheme.of(context).size;
  }
}
