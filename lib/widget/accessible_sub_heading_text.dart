import 'package:accessibly/accessibly.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccessiblySubHeadingText extends StatelessWidget {
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

  const AccessiblySubHeadingText(this.data,
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

    final boxBorder = accessibilitySettings.cognitiveMode
        ? Border.all(color: Colors.blue, width: 2.0)
        : null;

    TextStyle? textstyle = (style ?? const TextStyle());

    if (accessibilitySettings.textBgColor != null) {
      textstyle = textstyle.copyWith(color: accessibilitySettings.textBgColor);
    }

    if (accessibilitySettings.subHeadingColor != null && style?.color == null) {
      final Color? fallbackColor = accessibilitySettings.subHeadingColor;

      textstyle = textstyle.copyWith(color: fallbackColor);
    }

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
        // textScaleFactor: textScaleFactor,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      ),
    );
  }
}
