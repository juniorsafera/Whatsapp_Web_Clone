import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web/componetes/lista_mensagens.dart';
import 'package:whatsapp_web/modelos/usuario.dart';

class TelaMensagens extends StatefulWidget {
  final ModeloUsuario usuarioDestinatario;

  const TelaMensagens(
    this.usuarioDestinatario, {
    Key? key,
  }) : super(key: key);

  @override
  _TelaMensagensState createState() => _TelaMensagensState();
}

class _TelaMensagensState extends State<TelaMensagens> {
  late ModeloUsuario _usuarioRemetente;
  late ModeloUsuario _usuarioDestinatario;
  FirebaseAuth _auth = FirebaseAuth.instance;

  _recuperarDadosIniciais() {
    _usuarioDestinatario = widget.usuarioDestinatario;

    User? usuarioLogado = _auth.currentUser;
    if (usuarioLogado != null) {
      String idUsuario = usuarioLogado.uid;
      String? nome = usuarioLogado.displayName ?? "";
      String? email = usuarioLogado.email ?? "";
      String? imagemPerfil = usuarioLogado.photoURL ?? "";

      _usuarioRemetente =
          ModeloUsuario(idUsuario, nome, email, imagemPerfil: imagemPerfil);
    }
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosIniciais();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // FOTO USUARIO DESTINATARIO
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey,
              backgroundImage:
                  CachedNetworkImageProvider(_usuarioDestinatario.imagemPerfil),
            ),

            SizedBox(
              width: 8,
            ),

            //  NOME USUARIO DESTINATARIO
            Text(
              _usuarioDestinatario.nome,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),

        // MENU OPÇÕES
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: ListaMensagens(
          usuarioRemetente: _usuarioRemetente,
          usuarioDestinatario: _usuarioDestinatario,
        ),
      ),
    );
  }
}
