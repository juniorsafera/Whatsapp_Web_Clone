import 'package:flutter/material.dart';
import 'package:whatsapp_web/rotas.dart';

void main() {
  runApp(MaterialApp(  
    debugShowCheckedModeBanner: false,
    title: "WhatsApp Web",
 //   home: TelaLogin(),

 initialRoute: "/login",
 onGenerateRoute: Rotas.gerarRota,
  ));
}
 