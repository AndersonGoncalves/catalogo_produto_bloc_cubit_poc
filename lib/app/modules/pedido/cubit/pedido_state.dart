import 'package:catalogo_produto_poc/app/core/models/pedido.dart';

class PedidoState {
  final List<Pedido> pedidos;
  final bool isLoading;
  final bool isCreatingOrder;
  final String? error;
  final bool success;
  final bool orderCreated;

  PedidoState({
    this.pedidos = const [],
    this.isLoading = false,
    this.isCreatingOrder = false,
    this.error,
    this.success = false,
    this.orderCreated = false,
  });

  PedidoState copyWith({
    List<Pedido>? pedidos,
    bool? isLoading,
    bool? isCreatingOrder,
    String? error,
    bool? success,
    bool? orderCreated,
  }) {
    return PedidoState(
      pedidos: pedidos ?? this.pedidos,
      isLoading: isLoading ?? this.isLoading,
      isCreatingOrder: isCreatingOrder ?? this.isCreatingOrder,
      error: error,
      success: success ?? this.success,
      orderCreated: orderCreated ?? this.orderCreated,
    );
  }
}
