import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catalogo_produto_poc/app/core/ui/messages.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';
import 'package:catalogo_produto_poc/app/core/ui/app_routes.dart';
import 'package:catalogo_produto_poc/app/core/ui/format_currency.dart';
import 'package:catalogo_produto_poc/app/core/ui/theme_extensions.dart';
import 'package:catalogo_produto_poc/app/core/ui/localization_extension.dart';
import 'package:catalogo_produto_poc/app/modules/produto/cubit/produto_state.dart';
import 'package:catalogo_produto_poc/app/modules/carrinho/page/carrinho_badgee.dart';
import 'package:catalogo_produto_poc/app/modules/carrinho/cubit/carrinho_state.dart';
import 'package:catalogo_produto_poc/app/modules/produto/cubit/produto_controller.dart';
import 'package:catalogo_produto_poc/app/modules/carrinho/cubit/carrinho_controller.dart';

class ProdutoDetailPage extends StatefulWidget {
  final Produto produto;

  const ProdutoDetailPage({super.key, required this.produto});

  @override
  State<ProdutoDetailPage> createState() => _ProdutoDetailPageState();
}

class _ProdutoDetailPageState extends State<ProdutoDetailPage> {
  final PageController _pageController = PageController();
  int _currentPhotoIndex = 0;

  Widget _buildImagePlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 8),
          Text(
            context.localizations.semImagem,
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCarousel() {
    final fotos = widget.produto.fotos;

    if (fotos == null || fotos.isEmpty) {
      return _buildImagePlaceholder();
    }

    if (fotos.length == 1) {
      return fotos[0].isNotEmpty
          ? Image.network(
              fotos[0],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  _buildImagePlaceholder(),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            )
          : _buildImagePlaceholder();
    }

    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPhotoIndex = index;
            });
          },
          itemCount: fotos.length,
          itemBuilder: (context, index) {
            return fotos[index].isNotEmpty
                ? Image.network(
                    fotos[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildImagePlaceholder(),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  )
                : _buildImagePlaceholder();
          },
        ),

        // Seta esquerda
        if (_currentPhotoIndex > 0)
          Positioned(
            left: 8,
            top: 0,
            bottom: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(100),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),

        // Seta direita
        if (_currentPhotoIndex < fotos.length - 1)
          Positioned(
            right: 8,
            top: 0,
            bottom: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(100),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),

        // Contador de fotos
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(150),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${_currentPhotoIndex + 1}/${fotos.length}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageIndicator() {
    final fotos = widget.produto.fotos!;

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          fotos.length,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPhotoIndex == index
                  ? context.primaryColor
                  : Colors.grey.shade300,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarrinhoController, CarrinhoState>(
      listener: (context, state) {
        if (state.error != null && state.error!.isNotEmpty) {
          Messages.of(context).showError(Text(state.error!));
        }
      },

      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(widget.produto.nome),
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(20),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            actions: [
              BlocBuilder<ProdutoController, ProdutoState>(
                builder: (context, state) {
                  final produto = state.produtos.firstWhere(
                    (p) => p.id == widget.produto.id,
                    orElse: () => widget.produto,
                  );

                  return IconButton(
                    onPressed: () {
                      context.read<ProdutoController>().toggleFavorito(
                        produto.id,
                        !produto.isFavorito,
                      );
                    },
                    icon: Icon(
                      produto.isFavorito
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: produto.isFavorito ? context.tertiaryColor : null,
                    ),
                  );
                },
              ),

              BlocBuilder<CarrinhoController, CarrinhoState>(
                builder: (context, state) {
                  if (state.error != null && state.error!.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.error!)));
                    });
                  }

                  final quantidade = state.items.length;
                  return IconButton(
                    onPressed: () {
                      AppRoutes.goToCarrinho(context);
                    },
                    padding: const EdgeInsets.all(12.0),
                    icon: quantidade > 0
                        ? Badgee(
                            value: quantidade.toString(),
                            child: Icon(Icons.shopping_cart),
                          )
                        : const Icon(Icons.shopping_cart),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _buildImageCarousel(),
                    ),
                  ),
                ),

                if (widget.produto.fotos != null &&
                    widget.produto.fotos!.length > 1)
                  _buildImageIndicator(),

                const SizedBox(height: 20),

                Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.produto.nome,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        widget.produto.descricao!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        FormatCurrency.formatByDevice(
                          widget.produto.precoDeVenda,
                          context,
                        ),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.read<CarrinhoController>().add(
                              widget.produto,
                            );
                          },
                          icon: const Icon(Icons.shopping_cart),
                          label: Text(context.localizations.comprar),
                        ),
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(
                            Icons.arrow_back,
                            color: context.secondaryColor,
                          ),
                          label: Text(
                            context.localizations.voltar,
                            style: TextStyle(color: context.secondaryColor),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: context.secondaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
