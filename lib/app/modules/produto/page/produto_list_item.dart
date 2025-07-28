import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catalogo_produto_poc/app/core/ui/app_routes.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';
import 'package:catalogo_produto_poc/app/core/ui/theme_extensions.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_dialog.dart';
import 'package:catalogo_produto_poc/app/core/ui/format_currency.dart';
import 'package:catalogo_produto_poc/app/core/ui/localization_extension.dart';
import 'package:catalogo_produto_poc/app/modules/produto/cubit/produto_controller.dart';

class ProdutoListItem extends StatefulWidget {
  final Produto _produto;

  const ProdutoListItem({super.key, required Produto produto})
    : _produto = produto;

  @override
  State<ProdutoListItem> createState() => _ProdutoListItemState();
}

class _ProdutoListItemState extends State<ProdutoListItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget._produto.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: context.tertiaryColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      confirmDismiss: (_) async {
        bool? confirmed =
            await WidgetDialog(
              context,
              context.localizations.nao,
              context.localizations.sim,
            ).confirm(
              titulo: context.localizations.atencao,
              pergunta: context.localizations.desejaExcluirORegistro,
              onConfirm: () async {
                return await context.read<ProdutoController>().remove(
                  widget._produto,
                );
              },
            );
        return confirmed ?? false;
      },
      child: Card(
        color: context.canvasColor,
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
        child: ListTile(
          horizontalTitleGap: 6,
          contentPadding: EdgeInsets.only(right: 15, left: 7),
          onTap: () {
            AppRoutes.goToProdutoForm(
              context: context,
              produto: widget._produto,
            );
          },
          leading:
              widget._produto.fotos == null || widget._produto.fotos!.isEmpty
              ? CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.black12,
                  child: Icon(
                    Icons.local_offer_outlined,
                    color: Colors.black54,
                    size: 24,
                  ),
                )
              : CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(widget._produto.fotos![0]),
                ),
          title: Text(
            widget._produto.nome,
            maxLines: 1,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            widget._produto.descricao!,
            maxLines: 2,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                FormatCurrency.formatByDevice(
                  widget._produto.precoDeVenda,
                  context,
                ),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${widget._produto.quantidadeEmEstoque} ${context.localizations.und}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
