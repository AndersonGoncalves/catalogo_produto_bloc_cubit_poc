import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// No description provided for @idioma.
  ///
  /// In pt, this message translates to:
  /// **'pt_BR'**
  String get idioma;

  /// No description provided for @catalogoDeProdutos.
  ///
  /// In pt, this message translates to:
  /// **'Catálogo de Produtos'**
  String get catalogoDeProdutos;

  /// No description provided for @produto.
  ///
  /// In pt, this message translates to:
  /// **'Produto'**
  String get produto;

  /// No description provided for @produtos.
  ///
  /// In pt, this message translates to:
  /// **'Produtos'**
  String get produtos;

  /// No description provided for @senha.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get senha;

  /// No description provided for @pesquisarProdutos.
  ///
  /// In pt, this message translates to:
  /// **'Pesquisar produtos...'**
  String get pesquisarProdutos;

  /// No description provided for @digiteSuaPesquisa.
  ///
  /// In pt, this message translates to:
  /// **'Digite sua pesquisa...'**
  String get digiteSuaPesquisa;

  /// No description provided for @carregando.
  ///
  /// In pt, this message translates to:
  /// **'Carregando...'**
  String get carregando;

  /// No description provided for @carregandoFavoritos.
  ///
  /// In pt, this message translates to:
  /// **'Carregando favoritos...'**
  String get carregandoFavoritos;

  /// No description provided for @salvando.
  ///
  /// In pt, this message translates to:
  /// **'Salvando...'**
  String get salvando;

  /// No description provided for @poc.
  ///
  /// In pt, this message translates to:
  /// **'PoC'**
  String get poc;

  /// No description provided for @informeUmEmailEUmaSenhaDe6DigitosETenhaAcessoAoApp.
  ///
  /// In pt, this message translates to:
  /// **'Informe um email e uma senha de 6 dígitos e tenha acesso ao app'**
  String get informeUmEmailEUmaSenhaDe6DigitosETenhaAcessoAoApp;

  /// No description provided for @informeUmEmailEUmaSenhaDe6DigitosEregistreSeNoApp.
  ///
  /// In pt, this message translates to:
  /// **'Informe um email e uma senha de 6 dígitos e registre-se no app'**
  String get informeUmEmailEUmaSenhaDe6DigitosEregistreSeNoApp;

  /// No description provided for @ocorreuUmErroInesperado.
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro inesperado'**
  String get ocorreuUmErroInesperado;

  /// No description provided for @ocorreuUmErroNaAplicacao.
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro na aplicação'**
  String get ocorreuUmErroNaAplicacao;

  /// No description provided for @error.
  ///
  /// In pt, this message translates to:
  /// **'Erro'**
  String get error;

  /// No description provided for @fechar.
  ///
  /// In pt, this message translates to:
  /// **'Fechar'**
  String get fechar;

  /// No description provided for @nome.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get nome;

  /// No description provided for @email.
  ///
  /// In pt, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailInvalido.
  ///
  /// In pt, this message translates to:
  /// **'Email inválido'**
  String get emailInvalido;

  /// No description provided for @informeEmailValido.
  ///
  /// In pt, this message translates to:
  /// **'Informe um email válido'**
  String get informeEmailValido;

  /// No description provided for @informeUmaSenhaValida.
  ///
  /// In pt, this message translates to:
  /// **'Informe uma senha válida'**
  String get informeUmaSenhaValida;

  /// No description provided for @confirmarSenha.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar senha'**
  String get confirmarSenha;

  /// No description provided for @senhasInformadasNaoConferem.
  ///
  /// In pt, this message translates to:
  /// **'Senhas informadas não conferem'**
  String get senhasInformadasNaoConferem;

  /// No description provided for @aoUsarOAppVoceConcordaComNossosTermos.
  ///
  /// In pt, this message translates to:
  /// **'Ao usar o app você concorda com nossos termos'**
  String get aoUsarOAppVoceConcordaComNossosTermos;

  /// No description provided for @termosDeUsoEPoliticaDePrivacidade.
  ///
  /// In pt, this message translates to:
  /// **'Termos de uso e política de privacidade'**
  String get termosDeUsoEPoliticaDePrivacidade;

  /// No description provided for @entrar.
  ///
  /// In pt, this message translates to:
  /// **'Entrar'**
  String get entrar;

  /// No description provided for @registrar.
  ///
  /// In pt, this message translates to:
  /// **'Registrar'**
  String get registrar;

  /// No description provided for @loginComGoogle.
  ///
  /// In pt, this message translates to:
  /// **'Login com Google'**
  String get loginComGoogle;

  /// No description provided for @esqueceuASenha.
  ///
  /// In pt, this message translates to:
  /// **'Esqueceu a senha?'**
  String get esqueceuASenha;

  /// No description provided for @recuperacaoDeSenhaEnviadaParaEmailInformado.
  ///
  /// In pt, this message translates to:
  /// **'Recuperação de senha enviada para email informado'**
  String get recuperacaoDeSenhaEnviadaParaEmailInformado;

  /// No description provided for @desejaRegistrar.
  ///
  /// In pt, this message translates to:
  /// **'Deseja se registrar?'**
  String get desejaRegistrar;

  /// No description provided for @jaPossuiConta.
  ///
  /// In pt, this message translates to:
  /// **'Já possui conta?'**
  String get jaPossuiConta;

  /// No description provided for @naoQueroMeRegistrar.
  ///
  /// In pt, this message translates to:
  /// **'Não quero me registrar'**
  String get naoQueroMeRegistrar;

  /// No description provided for @ola.
  ///
  /// In pt, this message translates to:
  /// **'Olá'**
  String get ola;

  /// No description provided for @sejaBemVindo.
  ///
  /// In pt, this message translates to:
  /// **'Seja bem vindo(a)!'**
  String get sejaBemVindo;

  /// No description provided for @sobre.
  ///
  /// In pt, this message translates to:
  /// **'Sobre'**
  String get sobre;

  /// No description provided for @sistema.
  ///
  /// In pt, this message translates to:
  /// **'Sistema'**
  String get sistema;

  /// No description provided for @sair.
  ///
  /// In pt, this message translates to:
  /// **'Sair'**
  String get sair;

  /// No description provided for @nao.
  ///
  /// In pt, this message translates to:
  /// **'Não'**
  String get nao;

  /// No description provided for @sim.
  ///
  /// In pt, this message translates to:
  /// **'Sim'**
  String get sim;

  /// No description provided for @atencao.
  ///
  /// In pt, this message translates to:
  /// **'Atenção'**
  String get atencao;

  /// No description provided for @desejaExcluirORegistro.
  ///
  /// In pt, this message translates to:
  /// **'Deseja excluir o registro?'**
  String get desejaExcluirORegistro;

  /// No description provided for @und.
  ///
  /// In pt, this message translates to:
  /// **'Und'**
  String get und;

  /// No description provided for @semImagem.
  ///
  /// In pt, this message translates to:
  /// **'Sem Imagem'**
  String get semImagem;

  /// No description provided for @urlInvalida.
  ///
  /// In pt, this message translates to:
  /// **'Url Inválida'**
  String get urlInvalida;

  /// No description provided for @quantidadeMaximaPermitida.
  ///
  /// In pt, this message translates to:
  /// **'Quantidade máxima permitida'**
  String get quantidadeMaximaPermitida;

  /// No description provided for @foto.
  ///
  /// In pt, this message translates to:
  /// **'Foto'**
  String get foto;

  /// No description provided for @fotos.
  ///
  /// In pt, this message translates to:
  /// **'Fotos'**
  String get fotos;

  /// No description provided for @urlDaFoto.
  ///
  /// In pt, this message translates to:
  /// **'Url da foto'**
  String get urlDaFoto;

  /// No description provided for @nomeObrigatorio.
  ///
  /// In pt, this message translates to:
  /// **'Nome é Obrigatório'**
  String get nomeObrigatorio;

  /// No description provided for @custoObrigatorio.
  ///
  /// In pt, this message translates to:
  /// **'Custo é Obrigatório'**
  String get custoObrigatorio;

  /// No description provided for @venda.
  ///
  /// In pt, this message translates to:
  /// **'Venda'**
  String get venda;

  /// No description provided for @vendaObrigatoria.
  ///
  /// In pt, this message translates to:
  /// **'Venda é Obrigatória'**
  String get vendaObrigatoria;

  /// No description provided for @quantidadeEmEstoque.
  ///
  /// In pt, this message translates to:
  /// **'Quantidade em estoque'**
  String get quantidadeEmEstoque;

  /// No description provided for @quantidadeObrigatoria.
  ///
  /// In pt, this message translates to:
  /// **'Quantidade é Obrigatória'**
  String get quantidadeObrigatoria;

  /// No description provided for @marca.
  ///
  /// In pt, this message translates to:
  /// **'Marca'**
  String get marca;

  /// No description provided for @descricao.
  ///
  /// In pt, this message translates to:
  /// **'Descrição'**
  String get descricao;

  /// No description provided for @codigoDeBarras.
  ///
  /// In pt, this message translates to:
  /// **'Código de barras'**
  String get codigoDeBarras;

  /// No description provided for @descricaoObrigatoria.
  ///
  /// In pt, this message translates to:
  /// **'Descrição é Obrigatória'**
  String get descricaoObrigatoria;

  /// No description provided for @salvar.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get salvar;

  /// No description provided for @voltar.
  ///
  /// In pt, this message translates to:
  /// **'Voltar'**
  String get voltar;

  /// No description provided for @meusFavoritos.
  ///
  /// In pt, this message translates to:
  /// **'Meus Favoritos'**
  String get meusFavoritos;

  /// No description provided for @nenhumProdutoFavorito.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum Produto Favorito'**
  String get nenhumProdutoFavorito;

  /// No description provided for @adicioneProdutosAosFavoritosParaVeLosAqui.
  ///
  /// In pt, this message translates to:
  /// **'Adicione produtos aos favoritos para vê-los aqui'**
  String get adicioneProdutosAosFavoritosParaVeLosAqui;

  /// No description provided for @comprar.
  ///
  /// In pt, this message translates to:
  /// **'Comprar'**
  String get comprar;

  /// No description provided for @calculadoraDePreco.
  ///
  /// In pt, this message translates to:
  /// **'Calculadora de Preço'**
  String get calculadoraDePreco;

  /// No description provided for @custo.
  ///
  /// In pt, this message translates to:
  /// **'Custo'**
  String get custo;

  /// No description provided for @markup.
  ///
  /// In pt, this message translates to:
  /// **'Markup'**
  String get markup;

  /// No description provided for @lucro.
  ///
  /// In pt, this message translates to:
  /// **'Lucro'**
  String get lucro;

  /// No description provided for @margem.
  ///
  /// In pt, this message translates to:
  /// **'Margem'**
  String get margem;

  /// No description provided for @confirmar.
  ///
  /// In pt, this message translates to:
  /// **'CONFIRMAR'**
  String get confirmar;

  /// No description provided for @confirmado.
  ///
  /// In pt, this message translates to:
  /// **'Confirmado'**
  String get confirmado;

  /// No description provided for @pendente.
  ///
  /// In pt, this message translates to:
  /// **'Pendente'**
  String get pendente;

  /// No description provided for @cancelado.
  ///
  /// In pt, this message translates to:
  /// **'Cancelado'**
  String get cancelado;

  /// No description provided for @entregue.
  ///
  /// In pt, this message translates to:
  /// **'Entregue'**
  String get entregue;

  /// No description provided for @carrinhoDeCompras.
  ///
  /// In pt, this message translates to:
  /// **'Carrinho de Compras'**
  String get carrinhoDeCompras;

  /// No description provided for @seuCarrinhoEstaVazio.
  ///
  /// In pt, this message translates to:
  /// **'Seu carrinho está vazio'**
  String get seuCarrinhoEstaVazio;

  /// No description provided for @total.
  ///
  /// In pt, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @desejaRemoverItem.
  ///
  /// In pt, this message translates to:
  /// **'Deseja Remover o Item?'**
  String get desejaRemoverItem;

  /// No description provided for @registroNaoEncontrado.
  ///
  /// In pt, this message translates to:
  /// **'Registro não encontrado'**
  String get registroNaoEncontrado;

  /// No description provided for @perfil.
  ///
  /// In pt, this message translates to:
  /// **'Perfil'**
  String get perfil;

  /// No description provided for @ok.
  ///
  /// In pt, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @desejaSairDaAplicacaoIraPerderTodosOsDados.
  ///
  /// In pt, this message translates to:
  /// **'Deseja sair da Aplicaçao? Irá perder todos os seus dados.'**
  String get desejaSairDaAplicacaoIraPerderTodosOsDados;

  /// No description provided for @pedido.
  ///
  /// In pt, this message translates to:
  /// **'Pedido'**
  String get pedido;

  /// No description provided for @data.
  ///
  /// In pt, this message translates to:
  /// **'Data'**
  String get data;

  /// No description provided for @itens.
  ///
  /// In pt, this message translates to:
  /// **'Itens'**
  String get itens;

  /// No description provided for @meusPedidos.
  ///
  /// In pt, this message translates to:
  /// **'Meus Pedidos'**
  String get meusPedidos;

  /// No description provided for @criandoPedido.
  ///
  /// In pt, this message translates to:
  /// **'Criando pedido...'**
  String get criandoPedido;

  /// No description provided for @carregandoPedidos.
  ///
  /// In pt, this message translates to:
  /// **'Carregando pedidos...'**
  String get carregandoPedidos;

  /// No description provided for @seusPedidosIraoAparecerAqui.
  ///
  /// In pt, this message translates to:
  /// **'Seus pedidos irão aparecer aqui'**
  String get seusPedidosIraoAparecerAqui;

  /// No description provided for @nenhumPedidoEncontrado.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum pedido encontrado'**
  String get nenhumPedidoEncontrado;

  /// No description provided for @home.
  ///
  /// In pt, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @pedidoCriadoComSucesso.
  ///
  /// In pt, this message translates to:
  /// **'Pedido criado com sucesso!'**
  String get pedidoCriadoComSucesso;

  /// No description provided for @erroAoCriarPedido.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao criar pedido'**
  String get erroAoCriarPedido;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
