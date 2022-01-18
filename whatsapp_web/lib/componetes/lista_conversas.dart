import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web/modelos/usuario.dart';
import 'package:whatsapp_web/outros/responsivo.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_web/provider/conversa_provider.dart';

class ListaConversas extends StatefulWidget {
  const ListaConversas({
    Key? key,
  }) : super(key: key);

  @override
  _ListaConversasState createState() => _ListaConversasState();
}

class _ListaConversasState extends State<ListaConversas> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  late ModeloUsuario _usuarioRemetente;
  // late ModeloUsuario _usuarioDestinatario;

  StreamController _stController = StreamController<QuerySnapshot>.broadcast();
  late StreamSubscription _streamConversas;

  _adicionarListenerConversas() {
    final str = _db
        .collection("conversas")
        .doc(_usuarioRemetente.idUsuario)
        .collection("ultimas_Mensagens")
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
  void dispose() {
    _streamConversas.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosIniciais();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsivo.isMobile(context);
    return StreamBuilder(
      stream: _stController.stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: [
                  Text('Carregando conversas'),
                  CircularProgressIndicator(),
                ],
              ),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    Text('erro ao carregar os dados!'),
                  ],
                ),
              );
            } else {
              QuerySnapshot qs = snapshot.data as QuerySnapshot;
              List<DocumentSnapshot> listaConversas = qs.docs.toList();

              return ListView.separated(
                separatorBuilder: (context, indice) {
                  return Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  );
                },
                itemCount: listaConversas.length,
                itemBuilder: (context, indice) {
                  DocumentSnapshot conversa_item = listaConversas[indice];
                  String perfilDestinatario =
                      conversa_item["perfilDestinatario"];
                  String nomeDestinatario = conversa_item["nomeDestinatario"];
                  String emailDestinatario = conversa_item["emailDestinatario"];
                  String ultimaMensagem = conversa_item["ultimaMensagem"];
                  String idDestinatario = conversa_item["idDestinatario"];

                  ModeloUsuario usuarioDestinatario = ModeloUsuario(
                      idDestinatario, nomeDestinatario, emailDestinatario,
                      imagemPerfil: perfilDestinatario);

                  return ListTile(
                      onTap: () {

                       if(isMobile){
                           Navigator.pushNamed(context, '/mensagens',
                            arguments: usuarioDestinatario);
                       } else{
                         context.read<ConversaProvider>().usuarioDestinatario = usuarioDestinatario;
                       }
                       
                      },
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey,
                        backgroundImage: CachedNetworkImageProvider(
                            usuarioDestinatario.imagemPerfil),
                      ),
                      contentPadding: EdgeInsets.all(8),
                      title: Text(
                        usuarioDestinatario.nome,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        ultimaMensagem,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ));
                },
              );
            }
        }
      },
    );
  }
}
