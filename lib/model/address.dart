class Address {
  final int id;
  final String nomeUsuario;
  final String cep;
  final String logradouro;
  final String bairro;
  final String cidade;
  final String uf;

  Address({
    required this.id,
    required this.nomeUsuario,
    required this.cep,
    required this.logradouro,
    required this.bairro,
    required this.cidade,
    required this.uf,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        id: json['id'],
        nomeUsuario: json['nomeUsuario'],
        cep: json['cep'],
        logradouro: json['logradouro'],
        bairro: json['bairro'],
        uf: json['uf'],
        tipo: json['tipo']
    );
  }
}