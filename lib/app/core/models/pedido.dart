class Pedido {
  final String id;
  final DateTime data;
  final List<ItemPedido> itens;
  final double total;
  final String status;

  Pedido({
    required this.id,
    required this.data,
    required this.itens,
    required this.total,
    this.status = 'Pendente',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data.toIso8601String(),
      'itens': itens.map((item) => item.toMap()).toList(),
      'total': total,
      'status': status,
    };
  }

  factory Pedido.fromMap(String id, Map<String, dynamic> map) {
    return Pedido(
      id: id,
      data: map['id'] == ''
          ? DateTime.now()
          : DateTime.tryParse(map['data'].toString())!,
      itens:
          (map['itens'] as List<dynamic>?)
              ?.map((item) => ItemPedido.fromMap(item))
              .toList() ??
          [],
      total: map['total']?.toDouble() ?? 0.0,
      status: map['status'] ?? 'Pendente',
    );
  }

  Pedido copyWith({
    String? id,
    DateTime? data,
    List<ItemPedido>? itens,
    double? total,
    String? status,
  }) {
    return Pedido(
      id: id ?? this.id,
      data: data ?? this.data,
      itens: itens ?? this.itens,
      total: total ?? this.total,
      status: status ?? this.status,
    );
  }
}

class ItemPedido {
  final String produtoId;
  final String nomeProduto;
  final double preco;
  final double quantidade;

  ItemPedido({
    required this.produtoId,
    required this.nomeProduto,
    required this.preco,
    required this.quantidade,
  });

  double get total => preco * quantidade;

  Map<String, dynamic> toMap() {
    return {
      'produtoId': produtoId,
      'nomeProduto': nomeProduto,
      'preco': preco,
      'quantidade': quantidade,
    };
  }

  factory ItemPedido.fromMap(Map<String, dynamic> map) {
    return ItemPedido(
      produtoId: map['produtoId'] ?? '',
      nomeProduto: map['nomeProduto'] ?? '',
      preco: map['preco']?.toDouble() ?? 0.0,
      quantidade: map['quantidade']?.toDouble() ?? 0.0,
    );
  }
}
