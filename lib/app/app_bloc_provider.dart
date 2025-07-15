import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:catalogo_produto_poc/app/app_widget.dart';
import 'package:catalogo_produto_poc/app/modules/usuario/cubit/usuario_controller.dart';
import 'package:catalogo_produto_poc/app/services/usuario/usuario_service_impl.dart';
import 'package:catalogo_produto_poc/app/services/produto/produto_service_impl.dart';
import 'package:catalogo_produto_poc/app/modules/produto/cubit/produto_controller.dart';
import 'package:catalogo_produto_poc/app/repositories/produto/produto_repository_impl.dart';
import 'package:catalogo_produto_poc/app/repositories/usuario/usuario_repository_impl.dart';
import 'package:catalogo_produto_poc/app/repositories/carrinho/carrinho_repository_impl.dart';
import 'package:catalogo_produto_poc/app/services/carrinho/carrinho_service_impl.dart';
import 'package:catalogo_produto_poc/app/modules/carrinho/cubit/carrinho_controller.dart';

class AppBlocProvider extends StatelessWidget {
  const AppBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //Usuario
        BlocProvider<UsuarioController>(
          create: (context) {
            final usuarioRepository = UsuarioRepositoryImpl(
              firebaseAuth: FirebaseAuth.instance,
            );
            final usuarioService = UsuarioServiceImpl(
              usuarioRepository: usuarioRepository,
            );
            return UsuarioController(usuarioService: usuarioService);
          },
        ),

        //Produto
        BlocProvider<ProdutoController>(
          create: (context) {
            final usuarioRepository = UsuarioRepositoryImpl(
              firebaseAuth: FirebaseAuth.instance,
            );
            return ProdutoController(
              produtoService: ProdutoServiceImpl(
                produtoRepository: ProdutoRepositoryImpl(
                  token: usuarioRepository.user.refreshToken.toString(),
                  produtos: [],
                ),
              ),
            );
          },
        ),

        //Carrinho
        BlocProvider<CarrinhoController>(
          create: (context) {
            final carrinhoRepository = CarrinhoRepositoryImpl();
            return CarrinhoController(
              carrinhoService: CarrinhoServiceImpl(
                carrinhoRepository: carrinhoRepository,
              ),
            );
          },
        ),
      ],
      child: const AppWidget(),
    );
  }
}
