import 'package:flutter/material.dart';
import 'package:whatsapp_web/outros/paleta_cores.dart';
import 'package:whatsapp_web/rotas.dart';


final ThemeData temaPadrao = ThemeData(
  primaryColor: PaletaCores.corPrimaria,
  accentColor: PaletaCores.corDestaque,
);
void main() {
  runApp(MaterialApp(  
    debugShowCheckedModeBanner: false,
    theme: temaPadrao,
    title: "WhatsApp Web",
 //   home: TelaLogin(),

 initialRoute: "/login",
 onGenerateRoute: Rotas.gerarRota,
  ));
}
 