import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catalogo_produto_poc/app/core/ui/theme_extensions.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_loading_page.dart';
import 'package:catalogo_produto_poc/app/modules/produto/page/produto_grid.dart';
import 'package:catalogo_produto_poc/app/modules/produto/cubit/produto_state.dart';
import 'package:catalogo_produto_poc/app/modules/produto/cubit/produto_controller.dart';

class ProdutoFavoritosPage extends StatefulWidget {
  const ProdutoFavoritosPage({super.key});

  @override
  State<ProdutoFavoritosPage> createState() => _ProdutoFavoritosPageState();
}

class _ProdutoFavoritosPageState extends State<ProdutoFavoritosPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProdutoController>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProdutoController, ProdutoState>(
      builder: (context, state) {
        if (state.isLoading) {
          return WidgetLoadingPage(
            label: 'Carregando favoritos...',
            labelColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).canvasColor,
          );
        }

        final produtosFavoritos = context
            .read<ProdutoController>()
            .produtosFavoritos;

        return Column(
          children: [
            produtosFavoritos.isEmpty
                ? const SizedBox.shrink()
                : Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Seus Produtos Favoritos estão aqui!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: context.primaryColor,
                      ),
                    ),
                  ),
            Expanded(
              child: produtosFavoritos.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Nenhum produto favorito',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Adicione produtos aos favoritos para vê-los aqui',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ProdutoGrid(produtos: produtosFavoritos),
            ),
          ],
        );
      },
    );
  }
}
