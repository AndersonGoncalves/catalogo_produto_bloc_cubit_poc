import 'package:catalogo_produto_poc/app/core/models/pedido.dart';

abstract interface class PedidoRepository {
  List<Pedido> get pedidos;
  Future<void> get();
  Future<void> post(Pedido pedido);
  Future<void> patch(Pedido pedido);
  Future<void> delete(Pedido pedido);
}
