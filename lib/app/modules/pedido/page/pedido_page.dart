import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catalogo_produto_poc/app/core/models/pedido.dart';
import 'package:catalogo_produto_poc/app/core/ui/format_currency.dart';
import 'package:catalogo_produto_poc/app/core/ui/theme_extensions.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_loading_page.dart';
import 'package:catalogo_produto_poc/app/modules/pedido/cubit/pedido_state.dart';
import 'package:catalogo_produto_poc/app/modules/pedido/cubit/pedido_controller.dart';

class PedidoPage extends StatefulWidget {
  const PedidoPage({super.key});

  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmado':
        return Colors.green;
      case 'Pendente':
        return Colors.orange;
      case 'Cancelado':
        return Colors.red;
      case 'Entregue':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Widget _buildPedidoCard(Pedido pedido) {
    FormatCurrency formatCurrency = FormatCurrency();
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pedido #${pedido.id.substring(0, 8)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(pedido.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    pedido.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Data: ${DateFormat('dd/MM/yyyy HH:mm').format(pedido.data)}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Total: ${formatCurrency.format(pedido.total)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),
            const Text('Itens:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            ...pedido.itens.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${item.quantidade} x ${item.nomeProduto}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Text(
                      ' ${formatCurrency.format(item.total)}',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _carregarPedidos() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PedidoController>().load();
    });
  }

  @override
  void initState() {
    super.initState();
    _carregarPedidos();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _carregarPedidos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PedidoController, PedidoState>(
      builder: (context, state) {
        return Column(
          children: [
            state.pedidos.isEmpty
                ? SizedBox.shrink()
                : Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    color: context.primaryColor.withOpacity(0.1),
                    child: Text(
                      '📦 Meus Pedidos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: context.primaryColor,
                      ),
                    ),
                  ),
            Expanded(
              child: state.isLoading || state.isCreatingOrder
                  ? WidgetLoadingPage(
                      label: state.isCreatingOrder
                          ? 'Criando pedido...'
                          : 'Carregando pedidos...',
                      labelColor: context.primaryColor,
                      backgroundColor: context.canvasColor,
                    )
                  : state.pedidos.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Nenhum pedido encontrado',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Seus pedidos irão aparecer aqui',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        context.read<PedidoController>().load();
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.pedidos.length,
                        itemBuilder: (context, index) {
                          final pedido = state.pedidos[index];
                          return _buildPedidoCard(pedido);
                        },
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
