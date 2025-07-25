import 'package:flutter/material.dart';
import 'package:catalogo_produto_poc/app/core/ui/theme_extensions.dart';

class Messages {
  final BuildContext context;

  Messages._(this.context);

  factory Messages.of(BuildContext context) {
    return Messages._(context);
  }

  void _showSnackBar(Text message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: backgroundColor, content: message),
    );
  }

  void _showSnackBarWithAction(
    Text message,
    Color backgroundColor,
    String action,
    Color actionTextColor,
    Function() onPressed,
  ) {
    Scaffold.of(context).openDrawer();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: message,
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: action,
          textColor: actionTextColor,
          onPressed: onPressed,
        ),
      ),
    );
  }

  void showError(Text message) => _showSnackBar(message, context.errorColor);

  void info(Text message, Color color) => _showSnackBar(message, color);

  void infoWithAction(
    Text message,
    Color backgroundColor,
    String action,
    Color actionTextColor,
    Function() onPressed,
  ) => _showSnackBarWithAction(
    message,
    backgroundColor,
    action,
    actionTextColor,
    onPressed,
  );
}
