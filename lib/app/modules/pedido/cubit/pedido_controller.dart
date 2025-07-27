import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catalogo_produto_poc/app/core/models/pedido.dart';
import 'package:catalogo_produto_poc/app/core/models/carrinho.dart';
import 'package:catalogo_produto_poc/app/services/pedido/pedido_service.dart';
import 'package:catalogo_produto_poc/app/modules/pedido/cubit/pedido_state.dart';

class PedidoController extends Cubit<PedidoState> {
  final PedidoService _pedidoService;

  PedidoController({required PedidoService pedidoService})
    : _pedidoService = pedidoService,
      super(PedidoState());

  List<Pedido> get pedidos => state.pedidos;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _pedidoService.get();
      emit(
        state.copyWith(
          pedidos: _pedidoService.pedidos,
          isLoading: false,
          success: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Erro ao carregar pedidos: ${e.toString()}',
          success: false,
        ),
      );
    }
  }

  Future<void> criarPedido(List<Carrinho> itens, String status) async {
    emit(
      state.copyWith(isCreatingOrder: true, error: null, orderCreated: false),
    );

    try {
      await _pedidoService.criarPedido(itens, status);
      await _pedidoService.get();

      emit(
        state.copyWith(
          pedidos: _pedidoService.pedidos,
          isCreatingOrder: false,
          success: true,
          orderCreated: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isCreatingOrder: false,
          error: 'Erro ao criar pedido: ${e.toString()}',
          success: false,
          orderCreated: false,
        ),
      );
    }
  }

  Future<void> atualizarStatus(String pedidoId, String novoStatus) async {
    try {
      await _pedidoService.atualizarStatus(pedidoId, novoStatus);
      await _pedidoService.get();
      emit(state.copyWith(pedidos: _pedidoService.pedidos, success: true));
    } catch (e) {
      emit(
        state.copyWith(
          error: 'Erro ao atualizar status: ${e.toString()}',
          success: false,
        ),
      );
    }
  }

  void resetOrderCreated() {
    emit(state.copyWith(orderCreated: false));
  }
}
