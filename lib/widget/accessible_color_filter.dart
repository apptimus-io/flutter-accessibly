import 'package:accessibly/accessibly.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccessiblyColorFilter extends StatelessWidget {
  final Widget child;

  const AccessiblyColorFilter({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final accessibilitySettings = context.watch<Accessibly>();
    return Visibility(
      visible: accessibilitySettings.imageVisibility,
      child: ColorFiltered(
          colorFilter: ColorFilter.mode(
              accessibilitySettings.monochrome
                  ? Colors.blue
                  : Colors.transparent,
              BlendMode.saturation),
          child: child),
    );
  }
}
