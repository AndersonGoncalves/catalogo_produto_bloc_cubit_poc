import 'package:flutter/material.dart';
import 'package:catalogo_produto_poc/app/core/ui/theme_extensions.dart';

class Badgee extends StatelessWidget {
  final Widget child;
  final String value;
  final Color? color;
  final double? right;
  final double? top;

  const Badgee({
    super.key,
    required this.child,
    required this.value,
    this.color,
    this.right,
    this.top,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: right ?? -4,
          top: top ?? -6,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color ?? context.tertiaryColor,
            ),
            constraints: const BoxConstraints(minHeight: 16, minWidth: 16),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
