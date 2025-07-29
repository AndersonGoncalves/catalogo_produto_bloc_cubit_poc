import 'package:dio/dio.dart';
import 'package:catalogo_produto_poc/app/core/ui/url_consts.dart';
import 'package:catalogo_produto_poc/app/core/models/pedido.dart';
import 'package:catalogo_produto_poc/app/core/exceptions/http_exception.dart';
import 'package:catalogo_produto_poc/app/repositories/pedido/pedido_repository.dart';

class PedidoRepositoryImpl implements PedidoRepository {
  final String _token;
  final String _userId;
  final List<Pedido> _pedidos = [];
  late final Dio _dio;

  PedidoRepositoryImpl({required String token, required String userId})
    : _token = token,
      _userId = userId {
    _dio = Dio();
  }

  @override
  List<Pedido> get pedidos => [..._pedidos];

  @override
  Future<void> get() async {
    try {
      final response = await _dio.get(
        '${UrlConsts.firebase(userId: _userId).pedido}.json',
        queryParameters: {'auth': _token},
      );

      _pedidos.clear();
      final Map<String, dynamic>? data = response.data;

      if (data != null) {
        data.forEach((pedidoId, pedidoData) {
          _pedidos.add(Pedido.fromMap(pedidoId, pedidoData));
        });
      }
    } on DioException catch (e) {
      throw HttpException(
        msg: 'Erro ao carregar pedidos',
        statusCode: e.response?.statusCode ?? 500,
      );
    } catch (e) {
      throw HttpException(msg: 'Erro ao carregar pedidos: $e', statusCode: 500);
    }
  }

  @override
  Future<void> post(Pedido pedido) async {
    try {
      final response = await _dio.post(
        '${UrlConsts.firebase(userId: _userId).pedido}.json',
        queryParameters: {'auth': _token},
        data: pedido.toMap(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      final responseData = response.data;
      final novoPedido = pedido.copyWith(id: responseData['name']);
      _pedidos.add(novoPedido);
    } on DioException catch (e) {
      throw HttpException(
        msg: 'Erro ao salvar pedido',
        statusCode: e.response?.statusCode ?? 500,
      );
    } catch (e) {
      throw HttpException(msg: 'Erro ao salvar pedido: $e', statusCode: 500);
    }
  }

  @override
  Future<void> patch(Pedido pedido) async {
    try {
      await _dio.patch(
        '${UrlConsts.firebase(userId: _userId).pedido}/${pedido.id}.json',
        queryParameters: {'auth': _token},
        data: pedido.toMap(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      final index = _pedidos.indexWhere((p) => p.id == pedido.id);
      if (index >= 0) {
        _pedidos[index] = pedido;
      }
    } on DioException catch (e) {
      throw HttpException(
        msg: 'Erro ao atualizar pedido',
        statusCode: e.response?.statusCode ?? 500,
      );
    } catch (e) {
      throw HttpException(msg: 'Erro ao atualizar pedido: $e', statusCode: 500);
    }
  }

  @override
  Future<void> delete(Pedido pedido) async {
    try {
      await _dio.delete(
        '${UrlConsts.firebase(userId: _userId).pedido}/${pedido.id}.json',
        queryParameters: {'auth': _token},
      );

      _pedidos.removeWhere((p) => p.id == pedido.id);
    } on DioException catch (e) {
      throw HttpException(
        msg: 'Erro ao deletar pedido',
        statusCode: e.response?.statusCode ?? 500,
      );
    } catch (e) {
      throw HttpException(msg: 'Erro ao deletar pedido: $e', statusCode: 500);
    }
  }
}
