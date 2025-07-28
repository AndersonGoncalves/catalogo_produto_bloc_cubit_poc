import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class FormatCurrency {
  final String locale;
  final String symbol;
  final int decimalDigits;

  late final NumberFormat _formatter;

  FormatCurrency({
    this.locale = 'pt_BR',
    this.symbol = 'R\$',
    this.decimalDigits = 2,
  }) {
    _formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
  }

  String _formatByLocale(num value, Locale deviceLocale) {
    final languageCode = deviceLocale.languageCode.toLowerCase();

    switch (languageCode) {
      case 'en':
        return usa.format(value);
      case 'es':
        return euro.format(value);
      case 'pt':
        return brazil.format(value);
      default:
        return usa.format(value);
    }
  }

  String format(num value, [BuildContext? context]) {
    if (context != null) {
      final deviceLocale = Localizations.localeOf(context);
      return _formatByLocale(value, deviceLocale);
    }
    return _formatter.format(value);
  }

  String formatWithoutSymbol(num value) {
    final formatterNoSymbol = NumberFormat.currency(
      locale: locale,
      symbol: '',
      decimalDigits: decimalDigits,
    );
    return formatterNoSymbol.format(value).trim();
  }

  String formatPercentual(num value) {
    final percentFormatter = NumberFormat.currency(
      locale: locale,
      symbol: '',
      decimalDigits: decimalDigits,
    );
    return '${percentFormatter.format(value).trim()}%';
  }

  NumberFormat get formatter => _formatter;

  static final FormatCurrency brazil = FormatCurrency();

  static final FormatCurrency usa = FormatCurrency(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: 2,
  );

  static final FormatCurrency euro = FormatCurrency(
    locale: 'de_DE',
    symbol: '€',
    decimalDigits: 2,
  );

  static final FormatCurrency noSymbol = FormatCurrency(symbol: '');

  static String formatByLocale(num value, Locale deviceLocale) {
    final formatCurrency = FormatCurrency();
    return formatCurrency._formatByLocale(value, deviceLocale);
  }

  static String formatByDevice(num value, BuildContext context) {
    final deviceLocale = Localizations.localeOf(context);
    final languageCode = deviceLocale.languageCode.toLowerCase();

    switch (languageCode) {
      case 'en':
        return usa.format(value);
      case 'es':
        return euro.format(value);
      case 'pt':
        return brazil.format(value);
      default:
        return usa.format(value);
    }
  }

  static String formatBRL(num value) {
    return brazil.format(value);
  }

  static String formatBRLNoSymbol(num value) {
    return brazil.formatWithoutSymbol(value);
  }

  static String formatPercentualBRL(num value) {
    return brazil.formatPercentual(value);
  }

  static String formatUSA(num value) {
    return usa.format(value);
  }

  static String formatUSANoSymbol(num value) {
    return usa.formatWithoutSymbol(value);
  }

  static String formatPercentualUSA(num value) {
    return usa.formatPercentual(value);
  }

  static String formatEuro(num value) {
    return euro.format(value);
  }

  static String formatEuroNoSymbol(num value) {
    return euro.formatWithoutSymbol(value);
  }

  static String formatPercentualEuro(num value) {
    return euro.formatPercentual(value);
  }
}
