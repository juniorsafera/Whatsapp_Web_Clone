import 'package:flutter/material.dart';
import 'package:whatsapp_web/outros/paleta_cores.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({Key? key}) : super(key: key);

  @override
  _HomeDesktopState createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: PaletaCores.corFundo,
        child: Container(),
      ),
    );
  }
}
