import 'package:flutter/material.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';
import 'package:catalogo_produto_poc/app/modules/home/roteador_page.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_error_page.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_about_page.dart';
import 'package:catalogo_produto_poc/app/core/routes/app_routes_consts.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_perfil_page.dart';
import 'package:catalogo_produto_poc/app/modules/pedido/page/pedido_page.dart';
import 'package:catalogo_produto_poc/app/modules/produto/page/produto_page.dart';
import 'package:catalogo_produto_poc/app/modules/carrinho/page/carrinho_page.dart';
import 'package:catalogo_produto_poc/app/modules/produto/page/produto_form_page.dart';
import 'package:catalogo_produto_poc/app/modules/produto/page/produto_detail_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
    AppRoutesConsts.home: (_) => const RoteadorPage(),
    AppRoutesConsts.about: (_) => const WidgetAboutPage(),
    AppRoutesConsts.perfil: (_) => const WidgetPerfilPage(),
    AppRoutesConsts.carrinho: (_) => const CarrinhoPage(),
    AppRoutesConsts.pedidoList: (_) => const PedidoPage(),
    AppRoutesConsts.produtoList: (_) =>
        const ProdutoPage(produtoPageMode: ProdutoPageMode.list),
    AppRoutesConsts.produtoGrid: (_) =>
        const ProdutoPage(produtoPageMode: ProdutoPageMode.grid),
    AppRoutesConsts.produtoForm: (_) => const ProdutoFormPage(),
    AppRoutesConsts.produtoDetail: (context) {
      final produto = ModalRoute.of(context)!.settings.arguments as Produto;
      return ProdutoDetailPage(produto: produto);
    },
  };

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const WidgetErrorPage(),
      settings: settings,
    );
  }

  static Future<void> goToHome(BuildContext context) {
    return Navigator.of(context).pushReplacementNamed(AppRoutesConsts.home);
  }

  static Future<void> goToAbout(BuildContext context) {
    return Navigator.of(context).popAndPushNamed(AppRoutesConsts.about);
  }

  static Future<void> goToPerfil(BuildContext context) {
    return Navigator.of(context).popAndPushNamed(AppRoutesConsts.perfil);
  }

  static Future<void> goToPedidoList(BuildContext context) {
    return Navigator.of(context).popAndPushNamed(AppRoutesConsts.pedidoList);
  }

  static Future<void> goToProdutoList(BuildContext context) {
    return Navigator.of(context).popAndPushNamed(AppRoutesConsts.produtoList);
  }

  static Future<void> goToCarrinho(BuildContext context) {
    return Navigator.of(context).pushNamed(AppRoutesConsts.carrinho);
  }

  static Future<void> goToProdutoForm({
    required BuildContext context,
    Produto? produto,
  }) {
    if (produto == null) {
      return Navigator.of(context).pushNamed(AppRoutesConsts.produtoForm);
    } else {
      return Navigator.of(
        context,
      ).pushNamed(AppRoutesConsts.produtoForm, arguments: produto);
    }
  }

  static Future<void> goToProdutoDetail({
    required BuildContext context,
    Produto? produto,
  }) {
    if (produto == null) {
      return Navigator.of(context).pushNamed(AppRoutesConsts.produtoDetail);
    } else {
      return Navigator.of(
        context,
      ).pushNamed(AppRoutesConsts.produtoDetail, arguments: produto);
    }
  }
}
