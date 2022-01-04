import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web/modelos/usuario.dart';
import 'package:whatsapp_web/outros/paleta_cores.dart';


class TelaLogin extends StatefulWidget {
  const TelaLogin({ Key? key }) : super(key: key);

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {

      TextEditingController _controllerNome  = TextEditingController(text: 'Junior Santos');
      TextEditingController _controllerEmail = TextEditingController(text: 'junior@gmail.com');
      TextEditingController _controllerSenha = TextEditingController(text: '1234567');
      bool _cadastroUsuario = false;

      Uint8List? _imagemSelecionada;

      FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseStorage _storage = FirebaseStorage.instance;
      FirebaseFirestore _db = FirebaseFirestore.instance;


      _verificarUsuarioLogado() async {
        User? usuarioLogado = await _auth.currentUser;

        if(usuarioLogado != null){
          // Direcionar para tela principal
          Navigator.pushReplacementNamed(context, "/home");
        }
      }


      _selecionarImagem() async {
        
        // Selecionar imagem
        FilePickerResult? resultado = await FilePicker.platform.pickFiles(
          type: FileType.image
        );

        // Recuperar imagem
        setState(() {
          _imagemSelecionada = resultado?.files.single.bytes;
        });

      }
      
      // UPLOAD DE IMAGEM DE PERFIL E SALVAR USUARIO NO BD
      _uploadImagem(ModeloUsuario usuario){

      Uint8List? imagem = _imagemSelecionada;

      if(imagem != null){

        Reference imagemPerfilRef = _storage.ref("imagens/perfil/${usuario.idUsuario}.jpg");
        UploadTask upload = imagemPerfilRef.putData(imagem);

        upload.whenComplete(() async {
          String linkImagem = await upload.snapshot.ref.getDownloadURL();
          usuario.imagemPerfil = linkImagem;
          print("link da imagem: $linkImagem");
          final usuariosRef = _db.collection("usuarios");
          usuariosRef.doc("idUsuario")
          .set(usuario.toMap())
          .then((value){
            // DIRECIONAR PARA TELA PRINCIPAL
            Navigator.pushReplacementNamed(context, "/home");
          }).onError( (e,v){
              if(e != null){
                  print("ERRO!!");
              }
          }
          );
        });

      }


      }
       


      _validarCampos() async{

        String nome = _controllerNome.text;
        String email = _controllerEmail.text;
        String senha = _controllerSenha.text;

        if(email.isNotEmpty && email.contains("@")) {
          if(senha.isNotEmpty && senha.length > 6)  {


            if(_cadastroUsuario){

              if(_imagemSelecionada != null){
                  // Cadastro
                if(nome.isNotEmpty && nome.length > 2){

                  await _auth.createUserWithEmailAndPassword(
                    email: email, 
                    password: senha

                    ).then((auth){
                       
                      // Cadastrar usuário
                      String? idUsuario = auth.user?.uid;
                      // Upload imagem perfil
                      if(idUsuario != null){
                        ModeloUsuario usuario = ModeloUsuario(
                          idUsuario, 
                          nome, 
                          email
                          );
                        _uploadImagem(usuario);
                      }
                     // print("Usuário cadastrado: $idUsuario");
                    });

                } else {
                  print("Nome inválido!");
                }
              } else {
                print("Selecione uma imagem de perfil!");
              }
               
            } else{
              // Login
              await _auth.signInWithEmailAndPassword(
                email: email, 
                password: senha).then((auth){
                  
                  // TELA PRINCIPAL
                  Navigator.pushReplacementNamed(context, "/home");
                }).onError((e,s){
                  if(e != null){
                    print("Usuario não encontrado!");
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) => 

                      AlertDialog(
                          //title: Text('Atenção'),
                          content: Text('Usuário não encontrado!'),
                          actions: [
                             
                            // ignore: deprecated_member_use
                            FlatButton(
                              onPressed: (){
                                 Navigator.pop(context, 'Ok');
                              }, 
                              child: Text("OK"),
                              ),
                          ],
                        )
                        
                      )
                      .then((value) => null);
                  }
                });
            }
          }      // senha
          else {
            print("Senha inválida!");
                 }
        }  // email
        else {
          print("Email inválido!");
        }
      }


  // ignore: must_call_super
  void initState(){
    super.initState();
    _verificarUsuarioLogado();
  }
  
  @override
  Widget build(BuildContext context) {

    double larguraTela = MediaQuery.of(context).size.width;
    double alturaTela = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
          color: PaletaCores.corFundo,
          width: larguraTela,
          height: alturaTela,
          child: Stack(
            children: [

              Positioned(child: 
              Container(
                width: larguraTela,
                height: alturaTela * 0.4, // 40%
                color: PaletaCores.corPrimaria,
              )
              ),

              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Card(
                          
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10)
                            )
                          ),
                          child: Container(
                            padding: EdgeInsets.all(40),
                            width: 500,
                             
                            child: Column(
                              children: [
                                  
                                  // Imagem perfil com botão

                                   
                                  Visibility(
                                    visible: _cadastroUsuario,
                                    child: ClipOval(
                                        child:  _imagemSelecionada != null
                                              ? Image.memory(
                                                _imagemSelecionada!,
                                                width: 120,
                                                height: 120,
                                                fit: BoxFit.cover,
                                                )
                                              : Image.asset("assets/perfil.png",
                                                width: 120,
                                                height: 120,
                                                fit: BoxFit.cover,
                                         ), 
                                                                              
                                    ),
                                  ),

                                  SizedBox(height: 8,),
                                
                                // Botão selecione foto
                                  Visibility(
                                    visible: _cadastroUsuario,
                                    // ignore: deprecated_member_use
                                    child: OutlineButton(
                                      onPressed: _selecionarImagem,
                                      child: Text("Selecione foto"),
                                      ),
                                      ),
                              
                                  SizedBox(height: 8,),

                                  // Caixa nome
                                  Visibility(
                                    visible: _cadastroUsuario,
                                    child: TextField(
                                        keyboardType: TextInputType.emailAddress,
                                        controller: _controllerNome,
                                        decoration: InputDecoration(
                                          hintText: "Nome",
                                          labelText: "Nome",
                                          suffixIcon: Icon(Icons.person_outline)
                                        ),
                                      ),
                                 ),




                                // Caixa email
                                TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _controllerEmail,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    labelText: "Email",
                                    suffixIcon: Icon(Icons.email_outlined)
                                  ),
                                ),


                                // Caixa Senha
                                TextField(
                                  keyboardType: TextInputType.text,
                                  controller: _controllerSenha,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Senha",
                                    labelText: "Senha",
                                    suffixIcon: Icon(Icons.lock_outlined)
                                  ),
                                ),

                                SizedBox(height: 20,),

                                Container(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                  onPressed: _validarCampos, 
                                  style: ElevatedButton.styleFrom(
                                    primary: PaletaCores.corPrimaria,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                     _cadastroUsuario ? "Cadastrar" 
                                     :  "Entrar"
                                      ),
                                    ),
                                    ),
                                ),


                              // Caixa opções 'Entrar/Cadastrar'
                                Row(
                                  children: [
                                    Text("Login"),
                                    Switch(
                                      value: _cadastroUsuario , 
                                      onChanged: (bool valor){
                                        setState(() {
                                          _cadastroUsuario = valor;
                                        }
                                        );
                                      }
                                      ),
                                    Text("Cadastrar"),
                                  ],
                                ),

           
                              ],
                            ),
                          ),

                          ),
                  ),
                ),)
            ],
          ),
        ),
    );
  }
}