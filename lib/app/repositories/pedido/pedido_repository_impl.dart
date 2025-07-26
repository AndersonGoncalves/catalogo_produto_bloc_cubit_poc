import 'dart:convert';
import 'dart:io' as io;
import 'package:catalogo_produto_poc/app/core/constants/url.dart';
import 'package:catalogo_produto_poc/app/core/models/pedido.dart';
import 'package:catalogo_produto_poc/app/core/exceptions/http_exception.dart';
import 'package:catalogo_produto_poc/app/repositories/pedido/pedido_repository.dart';
import 'package:http/http.dart' as http;

class PedidoRepositoryImpl implements PedidoRepository {
  final String _token;
  final String _userId;
  final List<Pedido> _pedidos = [];

  PedidoRepositoryImpl({required String token, required String userId})
    : _token = token,
      _userId = userId;

  @override
  List<Pedido> get pedidos => [..._pedidos];

  @override
  Future<void> get() async {
    try {
      final response = await http.get(
        Uri.parse('${Url.firebase(userId: _userId).pedido}.json?auth=$_token'),
      );

      if (response.statusCode == 200) {
        _pedidos.clear();
        final Map<String, dynamic>? data = json.decode(response.body);

        if (data != null) {
          data.forEach((pedidoId, pedidoData) {
            _pedidos.add(Pedido.fromMap(pedidoId, pedidoData));
          });
        }
      } else {
        throw HttpException(
          msg: 'Erro ao carregar pedidos',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw io.HttpException('Erro ao carregar pedidos: $e');
    }
  }

  @override
  Future<void> post(Pedido pedido) async {
    try {
      final response = await http.post(
        Uri.parse('${Url.firebase(userId: _userId).pedido}.json?auth=$_token'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(pedido.toMap()),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final novoPedido = pedido.copyWith(id: responseData['name']);
        _pedidos.add(novoPedido);
      } else {
        throw HttpException(
          msg: 'Erro ao salvar pedido',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw io.HttpException('Erro ao salvar pedido: $e');
    }
  }

  @override
  Future<void> patch(Pedido pedido) async {
    try {
      final response = await http.patch(
        Uri.parse(
          '${Url.firebase(userId: _userId).pedido}/${pedido.id}.json?auth=$_token',
        ),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(pedido.toMap()),
      );

      if (response.statusCode == 200) {
        final index = _pedidos.indexWhere((p) => p.id == pedido.id);
        if (index >= 0) {
          _pedidos[index] = pedido;
        }
      } else {
        throw HttpException(
          msg: 'Erro ao atualizar pedido',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw io.HttpException('Erro ao atualizar pedido: $e');
    }
  }

  @override
  Future<void> delete(Pedido pedido) async {
    try {
      final response = await http.delete(
        Uri.parse(
          '${Url.firebase(userId: _userId).pedido}/${pedido.id}.json?auth=$_token',
        ),
      );

      if (response.statusCode == 200) {
        _pedidos.removeWhere((p) => p.id == pedido.id);
      } else {
        throw HttpException(
          msg: 'Erro ao deletar pedido',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw io.HttpException('Erro ao deletar pedido: $e');
    }
  }
}
