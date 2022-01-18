

import 'package:flutter/cupertino.dart';
import 'package:whatsapp_web/modelos/usuario.dart';

class ConversaProvider with ChangeNotifier {

    ModeloUsuario? _usuarioDestinatario;

    ModeloUsuario? get usuarioDestinatario => _usuarioDestinatario;

    set usuarioDestinatario (ModeloUsuario? usuario){
      _usuarioDestinatario = usuario;
    }

}