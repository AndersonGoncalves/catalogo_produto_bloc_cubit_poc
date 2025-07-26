import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catalogo_produto_poc/app/core/ui/messages.dart';
import 'package:catalogo_produto_poc/app/core/models/carrinho.dart';
import 'package:catalogo_produto_poc/app/core/ui/format_currency.dart';
import 'package:catalogo_produto_poc/app/core/ui/theme_extensions.dart';
import 'package:catalogo_produto_poc/app/modules/carrinho/page/carrinho_item.dart';
import 'package:catalogo_produto_poc/app/modules/pedido/cubit/pedido_controller.dart';
import 'package:catalogo_produto_poc/app/modules/carrinho/cubit/carrinho_controller.dart';

class CarrinhoPage extends StatelessWidget {
  const CarrinhoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FormatCurrency formatCurrency = FormatCurrency();
    final carrinhoController = Provider.of<CarrinhoController>(context);
    final items = carrinhoController.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: context.canvasColor,
        surfaceTintColor: context.canvasColor,
        foregroundColor: context.primaryColor,
        title: Padding(
          padding: EdgeInsets.only(bottom: 2),
          child: Text(
            carrinhoController.items.isEmpty ? '' : 'Carrinho de Compras',
            style: TextStyle(color: context.primaryColor),
          ),
        ),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 6.0),
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(context),
              icon: ClipOval(
                child: Container(
                  width: 40,
                  height: 40,
                  color: context.primaryColor.withAlpha(20),
                  child: Icon(Icons.close, color: context.primaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            carrinhoController.items.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Seu carrinho está vazio',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true, // Para funcionar dentro da Column
                        physics:
                            const NeverScrollableScrollPhysics(), // Desabilita scroll próprio
                        itemCount: items.length,
                        itemBuilder: (ctx, i) =>
                            CarrinhoItem(carrinho: items[i]),
                      ),

                      Card(
                        color: Colors.white,
                        elevation: 0,
                        margin: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: 25,
                          top: 5,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total:',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                formatCurrency.format(
                                  carrinhoController.valorTotal,
                                ),
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              CartButton(cart: carrinhoController),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class CartButton extends StatefulWidget {
  const CartButton({super.key, required this.cart});

  final CarrinhoController cart;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool _isLoading = false;

  Future<void> _criarPedido() async {
    setState(() => _isLoading = true);

    try {
      final carrinhoItems = widget.cart.items.values
          .map(
            (carrinho) => Carrinho(
              id: carrinho.id,
              produto: carrinho.produto,
              produtoId: carrinho.produtoId,
              nome: carrinho.nome,
              preco: carrinho.preco,
              quantidade: carrinho.quantidade,
            ),
          )
          .toList();

      final pedidoController = context.read<PedidoController>();
      await pedidoController.criarPedido(carrinhoItems);

      widget.cart.clear();

      if (mounted) {
        Messages.of(
          context,
        ).info(const Text('Pedido criado com sucesso!'), Colors.green);
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        Messages.of(context).showError(Text('Erro ao criar pedido: $e'));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator()
        : TextButton(
            onPressed: widget.cart.quantidadeItem == 0 ? null : _criarPedido,
            child: Text(
              'CONFIRMAR',
              style: TextStyle(color: context.primaryColor),
            ),
          );
  }
}
