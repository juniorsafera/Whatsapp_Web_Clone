import 'package:flutter/material.dart';
import 'package:whatsapp_web/outros/responsivo.dart';
import 'package:whatsapp_web/telas/home_desktop.dart';
import 'package:whatsapp_web/telas/home_mobile.dart';
// ignore: unused_import
import 'package:whatsapp_web/telas/home_tablet.dart';

class TelaHome extends StatelessWidget {
  const TelaHome({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsivo(
      mobile: HomeMobile(),
      tablet: HomeTablet(),
      desktop: HomeDesktop(),
     //tablet: HomeTablet(),
      );
  }
}