class Url {
  static const String _firebaseUrl =
      'https://catalogo-produto-cdbaf-default-rtdb.firebaseio.com/';

  final String? userId;
  Url.firebase({this.userId});

  String get produto => '$_firebaseUrl/produto';
  String get pedido => '$_firebaseUrl/${userId!}/pedido';
}
