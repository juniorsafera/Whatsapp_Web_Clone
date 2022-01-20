import 'package:cached_network_image/cached_network_image.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web/componetes/lista_mensagens.dart';
import 'package:whatsapp_web/modelos/usuario.dart';
import 'package:whatsapp_web/outros/paleta_cores.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_web/provider/conversa_provider.dart';

class AreaLateralMensagens extends StatelessWidget {
  final ModeloUsuario usuarioLogado;
  const AreaLateralMensagens({Key? key, required this.usuarioLogado})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;
    ModeloUsuario? usuarioDestinatario =
        context.watch<ConversaProvider>().usuarioDestinatario;
    /* return Container(
        width: largura,
        height: altura,
        color: PaletaCores.corFundoBarraClaro,
        child: usuarioDestinatario != null
            ? Text(usuarioDestinatario.nome)
            : Text("Nenhum usuário selecionado!")
            );
            */

    return usuarioDestinatario != null
        ? Column(
            children: [
              // BARRA SUPERIOR
              Container(
                color: PaletaCores.corFundo,
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey,
                      backgroundImage: CachedNetworkImageProvider(
                          usuarioDestinatario.imagemPerfil),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      usuarioDestinatario.nome,
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    IconButton(onPressed: (() {}), icon: Icon(Icons.search)),
                    IconButton(onPressed: (() {}), icon: Icon(Icons.more_vert)),
                  ],
                ),
              ),

              // LISTAGEM DE MENSAGENS
              Expanded(
                  child: ListaMensagens(
                      usuarioRemetente: usuarioLogado,
                      usuarioDestinatario: usuarioDestinatario))
            ],
          )
        : Container(
            width: largura,
            height: altura,
            color: PaletaCores.corFundoBarraClaro,
            child: Center(
              child: usuarioDestinatario != null
                  ? Text(usuarioDestinatario.nome)
                  : Text("Nenhuma conversa selecionada!"),
            ));
  }
}
