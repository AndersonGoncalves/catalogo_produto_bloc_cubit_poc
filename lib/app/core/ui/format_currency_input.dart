import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:catalogo_produto_poc/app/core/ui/localization_extension.dart';

class FormatCurrencyInput {
  static MoneyMaskedTextController currency({
    BuildContext? context,
    int precision = 2,
    String? locale,
  }) {
    String decimalSeparator;
    String thousandSeparator;
    String leftSymbol;

    if (context != null) {
      final localizations = context.localizations;
      switch (localizations.localeCode) {
        case 'pt_BR':
          decimalSeparator = ',';
          thousandSeparator = '.';
          leftSymbol = 'R\$ ';
          break;
        case 'en_US':
        default:
          decimalSeparator = '.';
          thousandSeparator = ',';
          leftSymbol = '\$ ';
          break;
      }
    } else {
      decimalSeparator = ',';
      thousandSeparator = '.';
      leftSymbol = 'R\$ ';
    }

    return MoneyMaskedTextController(
      decimalSeparator: decimalSeparator,
      thousandSeparator: thousandSeparator,
      leftSymbol: leftSymbol,
      precision: precision,
    );
  }

  static MoneyMaskedTextController currencyNoSymbol({
    String decimalSeparator = ',',
    String thousandSeparator = '.',
    int precision = 2,
  }) {
    return MoneyMaskedTextController(
      decimalSeparator: decimalSeparator,
      thousandSeparator: thousandSeparator,
      precision: precision,
    );
  }

  static MoneyMaskedTextController percentage({
    String decimalSeparator = ',',
    String thousandSeparator = '.',
    String rightSymbol = ' %',
    int precision = 2,
  }) {
    return MoneyMaskedTextController(
      decimalSeparator: decimalSeparator,
      thousandSeparator: thousandSeparator,
      rightSymbol: rightSymbol,
      precision: precision,
    );
  }

  static MoneyMaskedTextController withLeftSymbol({
    required String leftSymbol,
    String decimalSeparator = ',',
    String thousandSeparator = '.',
    int precision = 2,
  }) {
    return MoneyMaskedTextController(
      decimalSeparator: decimalSeparator,
      thousandSeparator: thousandSeparator,
      leftSymbol: leftSymbol,
      precision: precision,
    );
  }
}
