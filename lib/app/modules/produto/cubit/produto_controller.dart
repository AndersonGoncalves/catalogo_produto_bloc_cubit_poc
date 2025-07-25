import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';
import 'package:catalogo_produto_poc/app/services/produto/produto_service.dart';
import 'package:catalogo_produto_poc/app/modules/produto/cubit/produto_state.dart';

class ProdutoController extends Cubit<ProdutoState> {
  final ProdutoService _produtoService;

  ProdutoController({required ProdutoService produtoService})
    : _produtoService = produtoService,
      super(ProdutoState());

  List<Produto> get produtos => state.produtos;

  List<Produto> get produtosFavoritos => _produtoService.produtosFavoritos;

  Future<void> toggleFavorito(String produtoId, bool isFavorito) async {
    try {
      await _produtoService.toggleFavorito(produtoId, isFavorito);
      emit(state.copyWith(produtos: _produtoService.produtos, success: true));
    } catch (e) {
      emit(
        state.copyWith(
          error: 'Erro ao atualizar favorito: ${e.toString()}',
          success: false,
        ),
      );
    }
  }

  Future<void> load() async {
    emit(state.copyWith(error: null, success: false, isLoading: true));
    try {
      await _produtoService.get();
      emit(
        state.copyWith(
          produtos: _produtoService.produtos,
          success: true,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: 'Erro ao carregar produtos: ${e.toString()}',
          success: false,
          isLoading: false,
        ),
      );
    }
  }

  Future<void> save(Map<String, dynamic> map) async {
    emit(state.copyWith(error: null, success: false, isLoading: true));
    try {
      await _produtoService.save(map);
      await _produtoService.get();
      emit(
        state.copyWith(
          produtos: _produtoService.produtos,
          success: true,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: 'Erro ao cadastrar produto: ${e.toString()}',
          success: false,
          isLoading: false,
        ),
      );
    }
  }

  Future<void> remove(Produto produto) async {
    emit(state.copyWith(error: null, success: false, isLoading: true));
    try {
      await _produtoService.delete(produto);
      await _produtoService.get();
      emit(
        state.copyWith(
          produtos: _produtoService.produtos,
          success: true,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: 'Erro ao remover produto: ${e.toString()}',
          success: true,
          isLoading: false,
        ),
      );
    }
  }
}
