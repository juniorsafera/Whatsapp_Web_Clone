import 'package:flutter/material.dart';
import 'package:whatsapp_web/outros/paleta_cores.dart';

class AreaLateralMensagens extends StatelessWidget {
  const AreaLateralMensagens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;
    return Container(
      width: largura,
      height: altura,
      color: PaletaCores.corFundoBarraClaro,
    );
  }
}
