import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web/modelos/usuario.dart';

class ListaConversas extends StatefulWidget {
    
  const ListaConversas({ Key? key,
   
   }) : super(key: key);

  @override
  _ListaConversasState createState() => _ListaConversasState();
}

class _ListaConversasState extends State<ListaConversas> {

  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  late ModeloUsuario _usuarioRemetente;
  late ModeloUsuario _usuarioDestinatario;

  StreamController _stController = StreamController<QuerySnapshot>.broadcast();
  late StreamSubscription _streamConversas;

   _adicionarListenerConversas() {
    final str = _db
        .collection("conversas")
        .doc(_usuarioRemetente.idUsuario)
        .collection("ultimas_mensagens")
        .snapshots();

    _streamConversas = str.listen((dados) {
      _stController.add(dados);
       
    });
  }

  _recuperarDadosIniciais() {
     

    User? usuarioLogado = _auth.currentUser;
    if (usuarioLogado != null) {
      String idUsuario = usuarioLogado.uid;
      String? nome = usuarioLogado.displayName ?? "";
      String? email = usuarioLogado.email ?? "";
      String? imagemPerfil = usuarioLogado.photoURL ?? "";

      _usuarioRemetente =
          ModeloUsuario(idUsuario, nome, email, imagemPerfil: imagemPerfil);
    }

   _adicionarListenerConversas();
  }
   

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recuperarDadosIniciais();
     
  }

  
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}