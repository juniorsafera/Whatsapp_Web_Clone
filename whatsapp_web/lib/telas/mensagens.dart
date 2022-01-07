import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web/modelos/usuario.dart';

class TelaMensagens extends StatefulWidget {
  
  final ModeloUsuario usuarioDestinatario;
  const TelaMensagens(

    this.usuarioDestinatario,

    { Key? key,
    
   }) : super(key: key);

  @override
  _TelaMensagensState createState() => _TelaMensagensState();
}

class _TelaMensagensState extends State<TelaMensagens> {

  late ModeloUsuario _usuarioDestinatario;

  _recuperarDadosIniciais(){
    _usuarioDestinatario = widget.usuarioDestinatario;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recuperarDadosIniciais();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          // FOTO USUARIO DESTINATARIO
           CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            CachedNetworkImageProvider(
                              _usuarioDestinatario.imagemPerfil
                              ),
                      ),

            SizedBox(width: 8,),

            //  NOME USUARIO DESTINATARIO
            Text(_usuarioDestinatario.nome, style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),),
        ],
        ),
         

         // MENU OPÇÕES
         actions: [
           IconButton(
             onPressed: (){},
             icon: Icon(Icons.more_vert ,color: Colors.white,),
           )
         ],
      ),

    );
  }
}