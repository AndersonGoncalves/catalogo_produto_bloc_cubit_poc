import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catalogo_produto_poc/app/core/ui/messages.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';
import 'package:catalogo_produto_poc/app/core/routes/app_routes.dart';
import 'package:catalogo_produto_poc/app/core/ui/theme_extensions.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_pesquisa.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_loading_page.dart';
import 'package:catalogo_produto_poc/app/core/ui/localization_extension.dart';
import 'package:catalogo_produto_poc/app/modules/produto/pages/produto_list.dart';
import 'package:catalogo_produto_poc/app/modules/produto/pages/produto_grid.dart';
import 'package:catalogo_produto_poc/app/modules/produto/cubit/produto_state.dart';
import 'package:catalogo_produto_poc/app/modules/produto/cubit/produto_controller.dart';

enum ProdutoPageMode { list, grid }

class ProdutoPage extends StatefulWidget {
  final bool _comAppBar;
  final ProdutoPageMode _produtoPageMode;

  const ProdutoPage({
    super.key,
    bool comAppBar = true,
    required ProdutoPageMode produtoPageMode,
  }) : _comAppBar = comAppBar,
       _produtoPageMode = produtoPageMode;

  @override
  State<ProdutoPage> createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  List<Produto> _produtosFiltrados = [];
  String _searchTerm = '';

  List<Produto> _produtos(List<Produto> produtos) {
    final produtosList = List<Produto>.from(produtos);
    produtosList.sort(
      (a, b) => a.nome.toUpperCase().compareTo(b.nome.toUpperCase()),
    );
    return produtosList;
  }

  void _onSearch(String value) {
    setState(() {
      _searchTerm = value;
      final produtoController = context.read<ProdutoController>();
      if (value.isEmpty) {
        _produtosFiltrados = _produtos(produtoController.produtos);
      } else {
        _produtosFiltrados = _produtos(produtoController.produtos)
            .where(
              (element) =>
                  element.nome.toLowerCase().contains(value.toLowerCase()),
            )
            .toList();
      }
    });
  }

  List<Produto> _getProdutosParaExibir(List<Produto> produtos) {
    if (_searchTerm.isEmpty) {
      return _produtos(produtos);
    }
    return _produtosFiltrados;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProdutoController>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProdutoController, ProdutoState>(
      listener: (context, state) {
        if (state.error != null && state.error!.isNotEmpty) {
          Messages.of(context).showError(Text(state.error!));
        }

        if (state.produtos.isNotEmpty) {
          if (_searchTerm.isEmpty) {
            _produtosFiltrados = _produtos(state.produtos);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          appBar: widget._comAppBar
              ? AppBar(
                  automaticallyImplyLeading: false,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      context.localizations.produtos,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  actions: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 1.0),
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(context),
                        icon: ClipOval(
                          child: Container(
                            width: 40,
                            height: 40,
                            color: Colors.white.withAlpha(20),
                            child: const Icon(Icons.close, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : null,
          body: SafeArea(
            child: state.isLoading
                ? WidgetLoadingPage(
                    label: context.localizations.carregando,
                    labelColor: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(context).canvasColor,
                  )
                : Column(
                    children: [
                      Container(
                        height: 65,
                        width: double.infinity,
                        color: context.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: WidgetPesquisa(
                            hintText: context.localizations.digiteSuaPesquisa,
                            fillColor: Colors.white,
                            onSearch: (value) => _onSearch(value),
                          ),
                        ),
                      ),
                      Expanded(
                        child: widget._produtoPageMode == ProdutoPageMode.list
                            ? ProdutoList(
                                produtos: _getProdutosParaExibir(
                                  state.produtos,
                                ),
                              )
                            : ProdutoGrid(
                                produtos: _getProdutosParaExibir(
                                  state.produtos,
                                ),
                              ),
                      ),
                    ],
                  ),
          ),
          floatingActionButton: widget._produtoPageMode == ProdutoPageMode.list
              ? FloatingActionButton(
                  onPressed: () => AppRoutes.goToProdutoForm(context: context),
                  child: const Icon(Icons.add),
                )
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}
