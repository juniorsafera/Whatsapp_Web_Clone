import 'package:flutter/material.dart';
import 'package:whatsapp_web/telas/home.dart';
import 'package:whatsapp_web/telas/login.dart';

class Rotas{
  static Route<dynamic> gerarRota(RouteSettings rs){
    // ignore: unused_local_variable
    final args = rs.arguments;

    // ROTA INICIAL
    switch(rs.name){
      case "/":
        return MaterialPageRoute(builder: (_) => TelaLogin()
        );
    }


    switch(rs.name){
      case "/login":
        return MaterialPageRoute(builder: (_) => TelaLogin()
        );
    }

    switch(rs.name){
      case "/home":
        return MaterialPageRoute(builder: (_) => TelaHome() 
        );
    }

    return _erroRota() ;
  }

  static Route<dynamic>  _erroRota(){
    return MaterialPageRoute(builder: (_){
        return Scaffold(
          appBar: AppBar(
            title: Text("Página não encontrada!"),
            ),
          body: Center(
            child: Text("Página não encontrada!"),
          ),
        );
    });
  }
}