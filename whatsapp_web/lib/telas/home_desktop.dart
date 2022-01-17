import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web/componetes/area_lateral_conversas.dart';
import 'package:whatsapp_web/componetes/area_lateral_mensagens.dart';
import 'package:whatsapp_web/modelos/usuario.dart';
import 'package:whatsapp_web/outros/paleta_cores.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({Key? key}) : super(key: key);

  @override
  _HomeDesktopState createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late ModeloUsuario _usuarioLogado;

  _recuperarDadosUsuarioLogado() {
    User? usuarioLogado = _auth.currentUser;
    if (usuarioLogado != null) {
      String idUsuario = usuarioLogado.uid;
      String? nome = usuarioLogado.displayName ?? "";
      String? email = usuarioLogado.email ?? "";
      String? imagemPerfil = usuarioLogado.photoURL ?? "";

      _usuarioLogado =
          ModeloUsuario(idUsuario, nome, email, imagemPerfil: imagemPerfil);
    }
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: PaletaCores.corFundo,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                color: PaletaCores.corPrimaria,
                width: largura,
                height: altura * 0.2, // 20%
              ),
            ),
            Positioned(
                top: 20,
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: AreaLateralConversas(
                          usuarioLogado: _usuarioLogado,
                        )),
                    Expanded(flex: 6, child: AreaLateralMensagens()),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
