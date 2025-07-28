import 'package:flutter/material.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';
import 'package:catalogo_produto_poc/app/core/constants/rotas.dart';
import 'package:catalogo_produto_poc/app/modules/home/roteador_page.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_error_page.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_about_page.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_perfil_page.dart';
import 'package:catalogo_produto_poc/app/modules/produto/page/produto_page.dart';
import 'package:catalogo_produto_poc/app/modules/carrinho/page/carrinho_page.dart';
import 'package:catalogo_produto_poc/app/modules/produto/page/produto_form_page.dart';
import 'package:catalogo_produto_poc/app/modules/produto/page/produto_detail_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
    Rotas.home: (_) => const RoteadorPage(),
    Rotas.about: (_) => const WidgetAboutPage(),
    Rotas.perfil: (_) => const WidgetPerfilPage(),
    Rotas.carrinho: (_) => const CarrinhoPage(),
    Rotas.produtoList: (_) =>
        const ProdutoPage(produtoPageMode: ProdutoPageMode.list),
    Rotas.produtoGrid: (_) =>
        const ProdutoPage(produtoPageMode: ProdutoPageMode.grid),
    Rotas.produtoForm: (_) => const ProdutoFormPage(),
    Rotas.produtoDetail: (context) {
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
    return Navigator.of(context).pushReplacementNamed(Rotas.home);
  }

  static Future<void> goToAbout(BuildContext context) {
    return Navigator.of(context).popAndPushNamed(Rotas.about);
  }

  static Future<void> goToPerfil(BuildContext context) {
    return Navigator.of(context).popAndPushNamed(Rotas.perfil);
  }

  static Future<void> goToProdutoList(BuildContext context) {
    return Navigator.of(context).popAndPushNamed(Rotas.produtoList);
  }

  static Future<void> goToCarrinho(BuildContext context) {
    return Navigator.of(context).pushNamed(Rotas.carrinho);
  }

  static Future<void> goToProdutoForm({
    required BuildContext context,
    Produto? produto,
  }) {
    if (produto == null) {
      return Navigator.of(context).pushNamed(Rotas.produtoForm);
    } else {
      return Navigator.of(
        context,
      ).pushNamed(Rotas.produtoForm, arguments: produto);
    }
  }

  static Future<void> goToProdutoDetail({
    required BuildContext context,
    Produto? produto,
  }) {
    if (produto == null) {
      return Navigator.of(context).pushNamed(Rotas.produtoDetail);
    } else {
      return Navigator.of(
        context,
      ).pushNamed(Rotas.produtoDetail, arguments: produto);
    }
  }
}
