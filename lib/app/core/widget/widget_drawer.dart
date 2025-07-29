import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:catalogo_produto_poc/app/core/routes/app_routes.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_dialog.dart';
import 'package:catalogo_produto_poc/app/core/ui/localization_extension.dart';
import 'package:catalogo_produto_poc/app/modules/usuario/page/usuario_form_page.dart';
import 'package:catalogo_produto_poc/app/modules/usuario/cubit/usuario_controller.dart';

class WidgetDrawer extends StatefulWidget {
  final String? userName;
  final String? userEmail;
  final Widget? userImage;

  const WidgetDrawer({
    this.userName,
    this.userEmail,
    this.userImage,
    super.key,
  });

  @override
  State<WidgetDrawer> createState() => _WidgetDrawerState();
}

class _WidgetDrawerState extends State<WidgetDrawer> {
  Widget _createItem(IconData icon, String label, Function() onTap) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, size: 22, color: Colors.black54),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black54,
        ),
      ),
      onTap: onTap,
    );
  }

  Future<void> _sair(BuildContext context) async {
    context.read<UsuarioController>().logout().then((value) {
      if (!context.mounted) return;
      AppRoutes.goToHome(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).canvasColor,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: widget.userImage,
            ),
            accountName: Text(
              '${context.localizations.ola}, ${widget.userName == 'null' ? '' : widget.userName}',
              style: const TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              context.localizations.sejaBemVindo,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          _createItem(Icons.home, context.localizations.home, () {
            AppRoutes.goToHome(context);
          }),
          const Divider(),
          _createItem(Icons.local_offer, context.localizations.produtos, () {
            AppRoutes.goToProdutoList(context);
          }),
          const Divider(),
          _createItem(Icons.account_circle, context.localizations.perfil, () {
            if (context.read<UsuarioController>().user.isAnonymous) {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                CupertinoPageRoute(
                  maintainState: true,
                  fullscreenDialog: false,
                  allowSnapshotting: true,
                  builder: (_) {
                    return const UsuarioFormPage(usuarioAnonimo: true);
                  },
                ),
              );
            } else {
              AppRoutes.goToPerfil(context);
            }
          }),
          _createItem(Icons.error_outline, context.localizations.sobre, () {
            AppRoutes.goToAbout(context);
          }),
          const Divider(),
          _createItem(Icons.exit_to_app, context.localizations.sair, () {
            if (context.read<UsuarioController>().user.isAnonymous) {
              WidgetDialog(
                context,
                context.localizations.nao,
                context.localizations.sim,
              ).confirm(
                titulo: context.localizations.atencao,
                pergunta: context
                    .localizations
                    .desejaSairDaAplicacaoIraPerderTodosOsDados,
                onConfirm: () {
                  _sair(context);
                },
              );
            } else {
              _sair(context);
            }
          }),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
