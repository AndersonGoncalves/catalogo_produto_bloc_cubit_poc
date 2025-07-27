import 'package:flutter/material.dart';
import 'package:catalogo_produto_poc/app/core/ui/localization_extension.dart';

class WidgetRegistroNaoEncontradoPage extends StatelessWidget {
  const WidgetRegistroNaoEncontradoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, color: Colors.grey, size: 32),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              context.localizations.registroNaoEncontrado,
              style: TextStyle(color: Colors.grey, fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
