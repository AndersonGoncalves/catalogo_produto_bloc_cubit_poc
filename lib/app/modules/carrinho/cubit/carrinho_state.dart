import 'package:catalogo_produto_poc/app/core/models/carrinho.dart';

class CarrinhoState {
  String? error;
  bool success = false;
  bool isLoading = false;
  final List<Carrinho> carrinhoItems;

  CarrinhoState({
    this.error,
    this.success = false,
    this.isLoading = false,
    this.carrinhoItems = const [],
  });

  CarrinhoState copyWith({
    String? error,
    bool? success,
    bool? isLoading,
    List<Carrinho>? carrinhoItems,
  }) {
    return CarrinhoState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      carrinhoItems: carrinhoItems ?? this.carrinhoItems,
    );
  }
}
