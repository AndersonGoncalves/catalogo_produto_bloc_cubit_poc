import 'package:catalogo_produto_poc/app/core/models/pedido.dart';
import 'package:catalogo_produto_poc/app/core/models/carrinho.dart';
import 'package:catalogo_produto_poc/app/services/pedido/pedido_service.dart';
import 'package:catalogo_produto_poc/app/repositories/pedido/pedido_repository.dart';

class PedidoServiceImpl implements PedidoService {
  final PedidoRepository _pedidoRepository;

  PedidoServiceImpl({required PedidoRepository pedidoRepository})
    : _pedidoRepository = pedidoRepository;

  @override
  List<Pedido> get pedidos => _pedidoRepository.pedidos;

  @override
  Future<void> get() => _pedidoRepository.get();

  @override
  Future<void> criarPedido(List<Carrinho> itens) async {
    final itensPedido = itens
        .map(
          (item) => ItemPedido(
            produtoId: item.produtoId!,
            nomeProduto: item.nome,
            preco: item.preco,
            quantidade: item.quantidade,
          ),
        )
        .toList();

    final total = itensPedido.fold(0.0, (sum, item) => sum + item.total);

    final pedido = Pedido(
      id: '',
      data: DateTime.now(),
      itens: itensPedido,
      total: total,
      status: 'Confirmado',
    );

    await _pedidoRepository.post(pedido);
  }

  @override
  Future<void> atualizarStatus(String pedidoId, String novoStatus) async {
    final pedidos = _pedidoRepository.pedidos;
    final pedido = pedidos.firstWhere((p) => p.id == pedidoId);
    final pedidoAtualizado = pedido.copyWith(status: novoStatus);
    await _pedidoRepository.patch(pedidoAtualizado);
  }
}
