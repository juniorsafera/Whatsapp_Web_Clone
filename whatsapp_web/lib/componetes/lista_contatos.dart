import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web/modelos/usuario.dart';

class ListaContatos extends StatefulWidget {
  const ListaContatos({Key? key}) : super(key: key);

  @override
  _ListaContatosState createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _bd = FirebaseFirestore.instance;
  late String idUsuarioLogad;

  // INICIO MÉTODO RECUPERAR CONTATOS
  Future<List<ModeloUsuario>> _recuperarContatos() async {
    final _refUsuarios = _bd.collection("usuarios"); // COLEÇÃO
    QuerySnapshot qs = await _refUsuarios.get();
    List<ModeloUsuario> listaUsuarios = [];

    for (DocumentSnapshot item in qs.docs) {
      String idUsuario = item['idUsuario'];
      if(idUsuario == idUsuarioLogad) continue; // ignorar usuario logado
      String nome = item['nome'];
      String email = item['email'];
      String imagemPerfil = item['imagemPerfil'];
      ModeloUsuario usuario =
          ModeloUsuario(idUsuario, nome, email, imagemPerfil: imagemPerfil);

      listaUsuarios.add(usuario);
    }
    return listaUsuarios;
  }
  // FIM MÉTODO RECUPERAR CONTATOS


  // INICIO MÉTODO RECUPERAR USUARIO LOGADO
   _recuperarUsuarioLogado() async {
      
      User? usuarioAtual = await _auth.currentUser;

      if(usuarioAtual != null){
        idUsuarioLogad = usuarioAtual.uid;
      }


  }
  // FIM MÉTODO RECUPERAR USUARIO LOGADO

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _recuperarUsuarioLogado();
     
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ModeloUsuario>>(
      future: _recuperarContatos(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Carreganco contatos...'),
                  CircularProgressIndicator()
                ],
              ),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao carregar os dados!'),
              );
            } else {
              List<ModeloUsuario>? listaUsuarios = snapshot.data;
              if (listaUsuarios != null) {
                return ListView.separated(
                  separatorBuilder: (context, indice) {
                    return Divider(
                      color: Colors.grey,
                      thickness: 0.2,
                    );
                  },
                  itemCount: listaUsuarios.length,
                  itemBuilder: (context, indice) {
                    ModeloUsuario usuarios = listaUsuarios[indice];
                    return ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            CachedNetworkImageProvider(usuarios.imagemPerfil),
                      ),
                      contentPadding: EdgeInsets.all(8),
                      title: Text(
                        usuarios.nome,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),),
                    );
                  },
                );
              }
              return Center(
                child: Text('Erro ao carregar os dados!'),
              );
            }
        }
      },
    );
  }
}
