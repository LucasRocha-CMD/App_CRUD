class Planets {
  int? id; // Permitindo id nulo
  final String nome;
  final double tamanho;
  final double distancia;
  final String apelido;

  Planets({
    this.id, // id é opcional
    required this.nome,
    required this.tamanho,
    required this.distancia,
    required this.apelido,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'tamanho': tamanho,
      'distancia': distancia,
      'apelido': apelido,
    };
  }

  factory Planets.fromMap(Map<String, dynamic> map) {
    return Planets(
      id: map['id'],
      nome: map['nome'],
      tamanho: map['tamanho'],
      distancia: map['distancia'],
      apelido: map['apelido'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Planets &&
        other.id == id &&
        other.nome == nome &&
        other.tamanho == tamanho &&
        other.distancia == distancia &&
        other.apelido == apelido;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        tamanho.hashCode ^
        distancia.hashCode ^
        apelido.hashCode;
  }
}
