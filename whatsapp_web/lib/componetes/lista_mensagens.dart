import 'package:flutter/material.dart';
import 'package:whatsapp_web/outros/paleta_cores.dart';

class ListaMensagens extends StatefulWidget {
  const ListaMensagens({Key? key}) : super(key: key);

  @override
  _ListaMensagensState createState() => _ListaMensagensState();
}

class _ListaMensagensState extends State<ListaMensagens> {

  
  @override
  Widget build(BuildContext context) {

    double largura = MediaQuery.of(context).size.width;

    return Container(
      width: largura,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.png"), fit: BoxFit.cover)),
      child: Column(
        children: [

          // LISTA DE MENSAGENS
          Expanded(child: Container(
            width: largura,
            child: Text('Lista mensagens')
            )
            ),



          // CAIXA DE TEXTO
          Container(
            padding: EdgeInsets.all(8),
            color: PaletaCores.corFundoBarraTexto,
            child:Row(children: [

              // CAIXA DE TEXTO ARREDONDADA
              Expanded(child: Container(

                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(children: [
                    Icon(Icons.insert_emoticon),
                    SizedBox(width: 4,),
                    Expanded(child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Digite uma mensagem',
                        border: InputBorder.none
                      ),
                    ) ,),
                    Icon(Icons.attach_file),
                    Icon(Icons.camera_alt),                    
                  ],),
              ) ,
              ),
              
              // BOTÃO ENVIAR
              FloatingActionButton(
                backgroundColor: Color(0xff075E54),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onPressed: (){},
                mini: true,
              )
            ],
            )
            ),          
        ],
      ),
    );
  }
}
