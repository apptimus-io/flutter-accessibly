import 'package:accessibly/accessibly.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccessiblyHeadingText extends StatelessWidget {
  final String data;
  final TextStyle? style;

  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  const AccessiblyHeadingText(this.data,
      {super.key,
      this.style,
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.textHeightBehavior,
      this.selectionColor});

  @override
  Widget build(BuildContext context) {
    final accessibilitySettings = context.watch<Accessibly>();

    final Color? textColor = style?.color;
    final Color? fallbackColor =
        accessibilitySettings.stringToColor(accessibilitySettings.headingColor);

    final bool isBlackOrWhite =
        textColor == Colors.black || textColor == Colors.white;

    final Color? finalColor =
        isBlackOrWhite ? fallbackColor : textColor ?? fallbackColor;

    final boxBorder = accessibilitySettings.cognitiveMode
        ? Border.all(color: Colors.blue, width: 2.0)
        : null;

    TextStyle? textstyle = (style ?? const TextStyle()).copyWith(
      color: finalColor,
    );

    if (accessibilitySettings.textScaleFactor != 100) {
      textstyle = textstyle.copyWith(
          fontSize: (textstyle.fontSize ?? 20) *
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
      final Color? monochromeColor = accessibilitySettings
          .stringToColor(accessibilitySettings.headingColor);

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

    return Container(
      padding: accessibilitySettings.cognitiveMode
          ? const EdgeInsets.all(4.0)
          : const EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        color: style?.backgroundColor ?? accessibilitySettings.textBgColor,
        border: boxBorder,
      ),
      child: Text(
        data,
        textAlign: textAlign ?? accessibilitySettings.textAlignment,
        style: textstyle,
        strutStyle: strutStyle,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaleFactor: textScaleFactor,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      ),
    );
  }
}
