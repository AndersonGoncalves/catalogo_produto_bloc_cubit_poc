import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:catalogo_produto_poc/app/modules/usuario/cubit/usuario_controller.dart';
import 'package:catalogo_produto_poc/app/modules/usuario/pages/usuario_form_page.dart';
import 'package:catalogo_produto_poc/app/repositories/usuario/usuario_repository.dart';
import 'package:catalogo_produto_poc/app/services/usuario/usuario_service_impl.dart';
import 'package:catalogo_produto_poc/app/core/l10n/localizations/app_localizations.dart';

class FakeUsuarioRepository implements UsuarioRepository {
  @override
  Stream<User?> get authState => throw UnimplementedError();

  @override
  Future<User?> converterContaAnonimaEmPermanente(
    String email,
    String password,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<void> esqueceuSenha(String email) {
    throw UnimplementedError();
  }

  @override
  Future<User?> googleLogin() {
    throw UnimplementedError();
  }

  @override
  Future<User?> login(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<User?> loginAnonimo() {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  Future<User?> register(String name, String email, String password) {
    throw UnimplementedError();
  }

  @override
  User get user => throw UnimplementedError();
}

class MockUsuarioServiceImpl extends UsuarioServiceImpl {
  MockUsuarioServiceImpl() : super(usuarioRepository: FakeUsuarioRepository());
}

void main() {
  late UsuarioController usuarioController;

  setUp(() {
    usuarioController = UsuarioController(
      usuarioService: MockUsuarioServiceImpl(),
    );
  });

  tearDown(() {
    usuarioController.close();
  });

  Future<void> buildWidget(
    WidgetTester widgetTester, {
    bool usuarioAnonimo = false,
  }) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        locale: const Locale('pt', 'BR'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
        home: BlocProvider<UsuarioController>.value(
          value: usuarioController,
          child: UsuarioFormPage(usuarioAnonimo: usuarioAnonimo),
        ),
      ),
    );
  }

  Finder findEmailField() => find.byKey(const Key('email_key'));
  Finder findEntrarButton() => find.byKey(const Key('usuario_form_entrar_key'));
  Finder findEmailValidationError() => find.text('Informe um email válido');

  group('testes do campo email', () {
    testWidgets(
      'deve exibir o campo de email na tela quando estiver com usuario anônimo',
      (tester) async {
        await buildWidget(tester, usuarioAnonimo: true);

        expect(findEmailField(), findsOneWidget);
      },
    );

    testWidgets('deve exibir a mensagem de email inválido', (tester) async {
      await buildWidget(tester, usuarioAnonimo: true);
      await tester.pumpAndSettle();

      await tester.tap(findEntrarButton());
      await tester.pumpAndSettle();

      expect(findEmailValidationError(), findsOneWidget);
    });
  });
}
