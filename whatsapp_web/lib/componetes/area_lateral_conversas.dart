import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web/componetes/lista_conversas.dart';
import 'package:whatsapp_web/modelos/usuario.dart';
import 'package:whatsapp_web/outros/paleta_cores.dart';

class AreaLateralConversas extends StatelessWidget {
  final ModeloUsuario usuarioLogado;
  const AreaLateralConversas({Key? key, required this.usuarioLogado})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: PaletaCores.corFundoBarraClaro,
          border: Border(
            right: BorderSide(color: PaletaCores.corFundo, width: 1),
          )),
      child: Column(
        children: [
          // BARRA SUPERIOR
          Container(
            color: PaletaCores.corFundoBarraTexto,
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      CachedNetworkImageProvider(usuarioLogado.imagemPerfil),
                ),
                Spacer(),
                IconButton(onPressed: (() {}), icon: Icon(Icons.message)),
                IconButton(
                    onPressed: (() async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(context, "/login");
                    }),
                    icon: Icon(Icons.logout)),
              ],
            ),
          ),

          // BARRA DE PESQUISA
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              children: [
                IconButton(onPressed: (() {}), icon: Icon(Icons.search)),
                Expanded(
                    child: TextField(
                  decoration: InputDecoration.collapsed(
                      hintText: "Pesquisar uma conversa"),
                ))
              ],
            ),
          ),

          // LISTA DE CONVERSAS
          Expanded(
              child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: ListaConversas(),
          )),
        ],
      ),
    );
  }
}
