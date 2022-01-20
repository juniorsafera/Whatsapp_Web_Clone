import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web/modelos/conversa.dart';
//import 'package:flutter/widgets.dart';
import 'package:whatsapp_web/modelos/mensagem.dart';
import 'package:whatsapp_web/modelos/usuario.dart';
import 'package:whatsapp_web/outros/paleta_cores.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_web/provider/conversa_provider.dart';

class ListaMensagens extends StatefulWidget {
  final ModeloUsuario usuarioRemetente;
  final ModeloUsuario usuarioDestinatario;

  const ListaMensagens({
    Key? key,
    required this.usuarioRemetente,
    required this.usuarioDestinatario,
  }) : super(key: key);

  @override
  _ListaMensagensState createState() => _ListaMensagensState();
}

class _ListaMensagensState extends State<ListaMensagens> {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  TextEditingController _controllerMensagem = TextEditingController();
  ScrollController _scController = ScrollController();
  late ModeloUsuario _usuarioRemetente;
  late ModeloUsuario _usuarioDestinatario;

  StreamController _stController = StreamController<QuerySnapshot>.broadcast();
  late StreamSubscription _streamMensagens;

  _enviarMensagem() {
    String textoMensagem = _controllerMensagem.text;
    if (textoMensagem.isNotEmpty) {
      String idUsuarioRemetente = _usuarioRemetente.idUsuario;
      ModeloMensagem mensagem = ModeloMensagem(
          idUsuarioRemetente, textoMensagem, Timestamp.now().toString());

      // SALVANDO MENSAGEM E CONVERSA PARA REMETENTE
      String idUsuarioDestinatario = _usuarioDestinatario.idUsuario;
      _salvarMensagem(idUsuarioRemetente, idUsuarioDestinatario, mensagem);

      ModeloConversa conversaRemetente = ModeloConversa(
          _usuarioRemetente.idUsuario,
          _usuarioDestinatario.idUsuario,
          mensagem.texto,
          _usuarioDestinatario.nome,
          _usuarioDestinatario.email,
          _usuarioDestinatario.imagemPerfil);
      _salvarConversa(conversaRemetente);

      // SALVANDO MENSAGEM E CONVERSA PARA DESTINATARIO
      _salvarMensagem(idUsuarioDestinatario, idUsuarioRemetente, mensagem);

      ModeloConversa conversaDestinatario = ModeloConversa(
          _usuarioDestinatario.idUsuario,
          _usuarioRemetente.idUsuario,
          mensagem.texto,
          _usuarioDestinatario.nome,
          _usuarioDestinatario.email,
          _usuarioDestinatario.imagemPerfil);
      _salvarConversa(conversaDestinatario);
    }
  }

  _salvarMensagem(
      String idRemetente, String idDestinatario, ModeloMensagem mensagem) {
    _db
        .collection('mensagens')
        .doc(idRemetente)
        .collection(idDestinatario)
        .add(mensagem.toMap());

    _controllerMensagem.clear();
  }

  _salvarConversa(ModeloConversa conversa) {
    _db
        .collection('conversas')
        .doc(conversa.idRemetente)
        .collection('ultimas_Mensagens')
        .doc(conversa.idDestinatario)
        .set(conversa.toMap());
  }

  _recuperarDadosIniciais() {
    _usuarioRemetente = widget.usuarioRemetente;
    _usuarioDestinatario = widget.usuarioDestinatario;
    _adicionarListenerMensagens();
  }

  _adicionarListenerMensagens() {
    final str = _db
        .collection("mensagens")
        .doc(_usuarioRemetente.idUsuario)
        .collection(_usuarioDestinatario.idUsuario)
        .orderBy("data", descending: false)
        .snapshots();

    _streamMensagens = str.listen((dados) {
      _stController.add(dados);
      Timer(Duration(seconds: 1), () {
        _scController.jumpTo(_scController.position.maxScrollExtent);
      });
    });
  }

  _atualizarListenerMensagens() {
    ModeloUsuario? usuarioDestinatario =
        context.watch<ConversaProvider>().usuarioDestinatario;
    if (usuarioDestinatario != null) {
      _usuarioDestinatario = usuarioDestinatario;
      _recuperarDadosIniciais();
    }
  }

  @override
  void dispose() {
    _scController.dispose();
    _streamMensagens.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosIniciais();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _atualizarListenerMensagens();
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
          StreamBuilder(
            stream: _stController.stream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text('Carregando dados'),
                          CircularProgressIndicator(),
                        ],
                      ),
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
                    List<DocumentSnapshot> listaMensagens = qs.docs.toList();
                    return Expanded(
                      child: ListView.builder(
                        controller: _scController,
                        itemCount: qs.docs.length,
                        itemBuilder: (context, indice) {
                          DocumentSnapshot itemMensagem =
                              listaMensagens[indice];

                          Alignment alinhamento = Alignment.bottomLeft;
                          Color cor = Colors.white;
                          Size largura =
                              MediaQuery.of(context).size * 0.8; // 80%

                          if (_usuarioRemetente.idUsuario ==
                              itemMensagem["idUsuario"]) {
                            alinhamento = Alignment.bottomRight;
                            cor = Color(0xffd2ffa5);
                          }

                          return Align(
                            alignment: alinhamento,
                            child: Container(
                              constraints: BoxConstraints.loose(largura),
                              decoration: BoxDecoration(
                                  color: cor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.all(6),
                              child: Text(itemMensagem["texto"]),
                            ),
                          );
                        },
                      ),
                    );
                  }
              }
            },
          ),
          // CAIXA DE TEXTO
          Container(
              padding: EdgeInsets.all(8),
              color: PaletaCores.corFundoBarraTexto,
              child: Row(
                children: [
                  // CAIXA DE TEXTO ARREDONDADA
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.insert_emoticon),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _controllerMensagem,
                              decoration: InputDecoration(
                                  hintText: 'Digite uma mensagem',
                                  border: InputBorder.none),
                            ),
                          ),
                          Icon(Icons.attach_file),
                          Icon(Icons.camera_alt),
                        ],
                      ),
                    ),
                  ),

                  // BOTÃO ENVIAR
                  FloatingActionButton(
                    backgroundColor: Color(0xff075E54),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _enviarMensagem();
                    },
                    mini: true,
                  )
                ],
              )),
        ],
      ),
    );
  }
}
