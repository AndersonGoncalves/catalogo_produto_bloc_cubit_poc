import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

class ModulePage extends StatelessWidget {
  final WidgetBuilder _page;
  final List<SingleChildWidget>? _bindings;

  const ModulePage({
    super.key,
    required WidgetBuilder page,
    required List<SingleChildWidget>? bindings,
  }) : _page = page,
       _bindings = bindings;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _bindings ?? [],
      child: Builder(builder: (context) => _page(context)),
    );
  }
}
