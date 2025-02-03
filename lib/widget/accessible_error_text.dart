import 'package:accessibly/accessibly.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccessiblyErrorText extends StatelessWidget {
  final String data;
  final TextStyle? style;

  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  const AccessiblyErrorText(
    this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  });

  @override
  Widget build(BuildContext context) {
    final accessibilitySettings = context.watch<Accessibly>();

    TextStyle? textstyle = (style ?? const TextStyle());

    if (accessibilitySettings.textBgColor != null) {
      textstyle = textstyle.copyWith(
          backgroundColor: accessibilitySettings.textBgColor);
    }

    if (accessibilitySettings.errorTextColor != null) {
      final Color? fallbackColor = accessibilitySettings.errorTextColor;

      textstyle = textstyle.copyWith(color: fallbackColor);
    }

    if (accessibilitySettings.textScaleFactor != 100) {
      textstyle = textstyle.copyWith(
          fontSize: (textstyle.fontSize ?? 14) *
              accessibilitySettings.textScaleFactor /
              100);
    }

    if (accessibilitySettings.impairedMode) {
      textstyle = textstyle.copyWith(
        fontSize: (textstyle.fontSize ?? 14) * 1.2,
        fontWeight: style?.fontWeight ??
            (accessibilitySettings.impairedMode
                ? FontWeight.bold
                : FontWeight.normal),
      );
    }

    if (accessibilitySettings.monochrome) {
      final Color monochromeColor =
          accessibilitySettings.isDark ? Colors.white : Colors.grey;

      textstyle =
          textstyle.copyWith(color: monochromeColor, backgroundColor: null);
    }

    if (accessibilitySettings.letterSpacing != 100) {
      textstyle = textstyle.copyWith(
        letterSpacing: (accessibilitySettings.letterSpacing - 100) / 10,
      );
    }

    if (accessibilitySettings.lineHeight > 0) {
      textstyle = textstyle.copyWith(
        height: (accessibilitySettings.lineHeight) / 10,
      );
    }

    return Text(
      data,
      textAlign: accessibilitySettings.textAlignment,
      style: textstyle,
      strutStyle: strutStyle,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      // textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}
