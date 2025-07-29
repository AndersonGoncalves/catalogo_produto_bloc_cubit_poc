import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';
import 'package:catalogo_produto_poc/app/modules/produto/pages/produto_list_item.dart';
import 'package:catalogo_produto_poc/app/modules/produto/cubit/produto_controller.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_registro_nao_encontrado_page.dart';

class ProdutoList extends StatefulWidget {
  final List<Produto> _produtos;

  const ProdutoList({super.key, required List<Produto> produtos})
    : _produtos = produtos;

  @override
  State<ProdutoList> createState() => _ProdutoListState();
}

class _ProdutoListState extends State<ProdutoList> {
  Future<void> _refresh(BuildContext context) {
    return context.read<ProdutoController>().load();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refresh(context),
      child: widget._produtos.isEmpty
          ? const Center(child: WidgetRegistroNaoEncontradoPage())
          : widget._produtos.isEmpty
          ? const Center(child: WidgetRegistroNaoEncontradoPage())
          : ListView.builder(
              itemCount: widget._produtos.length,
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ProdutoListItem(
                  key: Key('list_${widget._produtos[index].id}'),
                  produto: widget._produtos[index],
                ),
              ),
            ),
    );
  }
}
