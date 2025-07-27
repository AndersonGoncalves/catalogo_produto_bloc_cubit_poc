import 'package:flutter/material.dart';
import 'package:catalogo_produto_poc/app/core/l10n/app_localizations.dart';

extension LocalizationExtensions on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}
