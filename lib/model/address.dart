class Address {
  final int id;
  final String nomeUsuario;
  final String cep;
  final String logradouro;
  final String bairro;
  final String uf;
  final String tipo;

  Address({
    required this.id,
    required this.nomeUsuario,
    required this.cep,
    required this.logradouro,
    required this.bairro,
    required this.uf,
    required this.tipo
  });
}