// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web/outros/paleta_cores.dart';
import 'package:whatsapp_web/rotas.dart';


final ThemeData temaPadrao = ThemeData(

);
void main() {
  
  // VERIFICAR SE O USUARIO ESTÁ LOGADO
 User? usuarioFirebase = FirebaseAuth.instance.currentUser;
        String urlInicial = "/";
        if( usuarioFirebase != null ) {
        urlInicial = "/home";
        }


  
  runApp(MaterialApp(  
    
    debugShowCheckedModeBanner: false,
    theme: temaPadrao.copyWith(
      colorScheme: temaPadrao.colorScheme.copyWith(
        primary: PaletaCores.corPrimaria,
        secondary: PaletaCores.corDestaque )
     )  ,
    title: "WhatsApp Web",
 //   home: TelaLogin(),

 initialRoute: urlInicial,
 onGenerateRoute: Rotas.gerarRota,
  ));
}
 