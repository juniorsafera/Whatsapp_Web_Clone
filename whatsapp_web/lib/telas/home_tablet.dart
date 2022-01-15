import 'package:flutter/material.dart';
import 'package:whatsapp_web/componetes/area_lateral_conversas.dart';
import 'package:whatsapp_web/componetes/area_lateral_mensagens.dart';
import 'package:whatsapp_web/outros/paleta_cores.dart';

class HomeTablet extends StatelessWidget {
  const HomeTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: PaletaCores.corFundo,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                color: PaletaCores.corPrimaria,
                width: largura,
                height: altura * 0.2, // 20%
              ),
            ),
            Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  children: [
                    Expanded(flex: 4, child: AreaLateralConversas()),
                    Expanded(flex: 6, child: AreaLateralMensagens()),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
