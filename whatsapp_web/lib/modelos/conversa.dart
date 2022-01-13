class ModeloConversa {
  String idRemetente;
  String idDestinatario;
  String ultimaMensagem;
  String nomeDestinatario;
  String emailDestinatario;
  String perfilDestinatario;

  ModeloConversa(
    this.idRemetente,
    this.idDestinatario,
    this.ultimaMensagem,
    this.nomeDestinatario,
    this.emailDestinatario,
    this.perfilDestinatario,
  );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idRemetente": this.idRemetente,
      "idDestinatario": this.idDestinatario,
      "ultimaMensagem": this.ultimaMensagem,
      "nomeDestinatario": this.nomeDestinatario,
      "emailDestinatario": this.emailDestinatario,
      "perfilDestinatario": this.perfilDestinatario,
    };

    return map;
  }
}
