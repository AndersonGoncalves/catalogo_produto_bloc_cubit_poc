import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catalogo_produto_poc/app/core/module/module.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';
import 'package:catalogo_produto_poc/app/core/routes/app_routes_consts.dart';
import 'package:catalogo_produto_poc/app/modules/produto/pages/produto_page.dart';
import 'package:catalogo_produto_poc/app/services/produto/produto_service_impl.dart';
import 'package:catalogo_produto_poc/app/modules/produto/pages/produto_form_page.dart';
import 'package:catalogo_produto_poc/app/modules/produto/pages/produto_detail_page.dart';
import 'package:catalogo_produto_poc/app/modules/produto/cubit/produto_controller.dart';
import 'package:catalogo_produto_poc/app/modules/usuario/cubit/usuario_controller.dart';
import 'package:catalogo_produto_poc/app/repositories/produto/produto_repository_impl.dart';

class ProdutoModule extends Module {
  ProdutoModule()
    : super(
        routers: {
          AppRoutesConsts.produtoList: (_) =>
              const ProdutoPage(produtoPageMode: ProdutoPageMode.list),
          AppRoutesConsts.produtoGrid: (_) =>
              const ProdutoPage(produtoPageMode: ProdutoPageMode.grid),
          AppRoutesConsts.produtoForm: (_) => const ProdutoFormPage(),
          AppRoutesConsts.produtoDetail: (context) {
            final produto =
                ModalRoute.of(context)!.settings.arguments as Produto;
            return ProdutoDetailPage(produto: produto);
          },
        },
        bindings: [
          BlocProvider<ProdutoController>(
            create: (context) {
              final usuarioController = context.read<UsuarioController>();
              final currentUser = usuarioController.user;
              return ProdutoController(
                produtoService: ProdutoServiceImpl(
                  produtoRepository: ProdutoRepositoryImpl(
                    token: currentUser.refreshToken ?? '',
                    produtos: [],
                  ),
                ),
              );
            },
          ),
        ],
      );
}
