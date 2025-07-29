import 'module_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/single_child_widget.dart';

abstract class Module {
  final Map<String, WidgetBuilder> _routers;
  final List<SingleChildWidget>? _bindings;

  Module({
    required Map<String, WidgetBuilder> routers,
    required List<SingleChildWidget>? bindings,
  }) : _routers = routers,
       _bindings = bindings;

  Map<String, WidgetBuilder> get routers {
    return _routers.map(
      (key, pageBuilder) => MapEntry(
        key,
        (_) => ModulePage(bindings: _bindings, page: pageBuilder),
      ),
    );
  }
}
