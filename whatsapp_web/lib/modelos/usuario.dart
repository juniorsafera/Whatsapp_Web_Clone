

class ModeloUsuario{

  String idUsuario;
  String nome;
  String email;
  String imagemPerfil;

  ModeloUsuario(
    this.idUsuario,
    this.nome,
    this.email,
    {this.imagemPerfil = ""}   //opcional
  );


  Map<String, dynamic> toMap(){

       Map<String, dynamic> map = {
         "idUsuario" : this.idUsuario,
         "nome" : this.nome,
         "email" : this.email,
         "imagemPerfil" : this.imagemPerfil,
       };

       return map;

  }
}