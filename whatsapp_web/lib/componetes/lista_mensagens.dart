import 'package:flutter/material.dart';


class ListaMensagens extends StatefulWidget {
  const ListaMensagens({ Key? key }) : super(key: key);

  @override
  _ListaMensagensState createState() => _ListaMensagensState();
}

class _ListaMensagensState extends State<ListaMensagens> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg.png"),
          fit: BoxFit.cover
          )
        ),

        child: Column(children: [
          
          // LISTA DE MENSAGENS

          // CAIXA DE TEXTO
        ],),
    );
  }
}
