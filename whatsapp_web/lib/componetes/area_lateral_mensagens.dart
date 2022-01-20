import 'package:flutter/material.dart';
import 'package:whatsapp_web/modelos/usuario.dart';
import 'package:whatsapp_web/outros/paleta_cores.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_web/provider/conversa_provider.dart';

class AreaLateralMensagens extends StatelessWidget {
  const AreaLateralMensagens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;
    ModeloUsuario? usuarioDestinatario =
        context.watch<ConversaProvider>().usuarioDestinatario;
    return Container(
        width: largura,
        height: altura,
        color: PaletaCores.corFundoBarraClaro,
        child: usuarioDestinatario != null
            ? Text(usuarioDestinatario.nome)
            : Text("Nenhum usuário selecionado!"));
  }
}
