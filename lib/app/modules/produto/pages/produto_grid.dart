import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';
import 'package:catalogo_produto_poc/app/modules/produto/pages/produto_grid_item.dart';
import 'package:catalogo_produto_poc/app/modules/produto/cubit/produto_controller.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_registro_nao_encontrado_page.dart';

class ProdutoGrid extends StatefulWidget {
  final List<Produto> _produtos;

  const ProdutoGrid({super.key, required List<Produto> produtos})
    : _produtos = produtos;

  @override
  State<ProdutoGrid> createState() => _ProdutoGridState();
}

class _ProdutoGridState extends State<ProdutoGrid> {
  Future<void> _refresh(BuildContext context) {
    return context.read<ProdutoController>().load();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refresh(context),
      child: widget._produtos.isEmpty
          ? const Center(child: WidgetRegistroNaoEncontradoPage())
          : widget._produtos.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GridView.builder(
                itemCount: widget._produtos.length,
                padding: const EdgeInsets.all(7),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (ctx, index) => ProdutoGridItem(
                  key: Key('grid_${widget._produtos[index].id}'),
                  produto: widget._produtos[index],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
