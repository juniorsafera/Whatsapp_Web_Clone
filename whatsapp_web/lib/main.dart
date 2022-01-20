// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_web/outros/paleta_cores.dart';
import 'package:whatsapp_web/provider/conversa_provider.dart';
import 'package:whatsapp_web/rotas.dart';
import 'package:provider/provider.dart';

final ThemeData temaPadrao = ThemeData();
void main() {
  // VERIFICAR SE O USUARIO ESTÁ LOGADO
  User? usuarioFirebase = FirebaseAuth.instance.currentUser;
  String urlInicial = "/";
  if (usuarioFirebase != null) {
    urlInicial = "/home";
  }

 // atalho para consertar botao espaço em caixa de textos no scroll 
  final atalhos = WidgetsApp.defaultShortcuts;
  atalhos[LogicalKeySet(LogicalKeyboardKey.space)] = ActivateIntent();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ConversaProvider()  ,
            child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: temaPadrao.copyWith(
                colorScheme: temaPadrao.colorScheme.copyWith(
                    primary: PaletaCores.corPrimaria,
                    secondary: PaletaCores.corDestaque)),
                    shortcuts: atalhos,
            title: "WhatsApp Web",
            //   home: TelaLogin(),

            initialRoute: urlInicial,
            onGenerateRoute: Rotas.gerarRota,
          ),
          )
  );
}
