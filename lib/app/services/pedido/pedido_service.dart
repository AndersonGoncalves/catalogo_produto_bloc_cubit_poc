import 'package:catalogo_produto_poc/app/core/models/carrinho.dart';
import 'package:catalogo_produto_poc/app/core/models/pedido.dart';

abstract class PedidoService {
  List<Pedido> get pedidos;
  Future<void> get();
  Future<void> criarPedido(List<Carrinho> itens);
  Future<void> atualizarStatus(String pedidoId, String novoStatus);
}
