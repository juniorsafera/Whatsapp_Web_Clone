import 'package:flutter/material.dart';
import 'package:whatsapp_web/componetes/area_lateral_conversas.dart';
import 'package:whatsapp_web/componetes/area_lateral_mensagens.dart';
import 'package:whatsapp_web/outros/paleta_cores.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({Key? key}) : super(key: key);

  @override
  _HomeDesktopState createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
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
                top: 20,
                bottom: 20,
                left: 20,
                right: 20,
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
