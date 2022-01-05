import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web/componetes/lista_contatos.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({ Key? key }) : super(key: key);

  @override
  _HomeMobileState createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  @override
  Widget build(BuildContext context) {

    FirebaseAuth _auth = FirebaseAuth.instance;


    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('WhatsApp'),
          actions: [

            IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.search)
              ),

              IconButton(
              onPressed: (){
                _auth.signOut();
              }, 
              icon: Icon(Icons.logout)
              ),

          ],

        bottom: TabBar(
          indicatorColor: Colors.white,
          indicatorWeight: 4,
          labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
          ),
          tabs: [
            Tab(text: 'Conversas',),
            Tab(text: 'Contatos',),
          ],
        ),

        ),

        body: SafeArea(child: TabBarView(children: [
          Center(child: Text('Conversas'),),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:8),
            child: ListaContatos(),
            )
        ]),),
        
      )
      );
  }
}