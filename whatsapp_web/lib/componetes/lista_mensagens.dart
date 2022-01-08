import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web/modelos/mensagem.dart';
import 'package:whatsapp_web/modelos/usuario.dart';
import 'package:whatsapp_web/outros/paleta_cores.dart';

class ListaMensagens extends StatefulWidget {

  final ModeloUsuario usuarioRemetente;
  final ModeloUsuario usuarioDestinatario;

  const ListaMensagens({Key? key,
    required this.usuarioRemetente,
    required this.usuarioDestinatario,
  }) : super(key: key);

  @override
  _ListaMensagensState createState() => _ListaMensagensState();
}

class _ListaMensagensState extends State<ListaMensagens> {

  FirebaseFirestore _db = FirebaseFirestore.instance;

  TextEditingController _controllerMensagem = TextEditingController();
  late ModeloUsuario _usuarioRemetente;
  late ModeloUsuario _usuarioDestinatario;

  _enviarMensagem(){
        String textoMensagem = _controllerMensagem.text;
        if(textoMensagem.isNotEmpty){
          String idUsuarioRemetente = _usuarioRemetente.idUsuario;
          ModeloMensagem mensagem = ModeloMensagem(
            idUsuarioRemetente,
            textoMensagem,
            Timestamp.now().toString()
          );

          // SALVANDO MENSAGEM
          String idUsuarioDestinatario = _usuarioDestinatario.idUsuario;
          _salvarMensagem(
            idUsuarioRemetente,
            idUsuarioDestinatario,
            mensagem
          );
            
        }

  }

  _salvarMensagem(String idRemetente, String idDestinatario, ModeloMensagem mensagem){

      _db.collection('mensagens')
      .doc(idRemetente)
      .collection(idDestinatario)
      .add( mensagem.toMap() );

      _controllerMensagem.clear();

  }


  _recuperarDadosIniciais(){
        _usuarioRemetente = widget.usuarioRemetente;
        _usuarioDestinatario = widget.usuarioDestinatario;
  }


  @override
  void initState() {
   
    super.initState();
     _recuperarDadosIniciais();
  }

  
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
                      controller: _controllerMensagem,
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
                onPressed: (){
                  _enviarMensagem();
                },
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
