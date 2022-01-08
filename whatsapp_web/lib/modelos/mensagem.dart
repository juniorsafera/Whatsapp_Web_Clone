class ModeloMensagem {

  String idUsuario;
  String texto;
  String data;


  ModeloMensagem(
    this.idUsuario,
    this.texto,
    this.data
  );


  Map<String, dynamic> toMap(){

       Map<String, dynamic> map = {
         "idUsuario" : this.idUsuario,
         "texto" : this.texto,
         "data" : this.data,
         
       };

       return map;

  }
}