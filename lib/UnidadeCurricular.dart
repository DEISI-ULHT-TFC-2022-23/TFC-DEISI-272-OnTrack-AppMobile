
class UnidadeCurricular {
  late int id;
  late String nome;
  late String professor;
  late int ano;
  late int semestre;
  late int ects = 5;
  late List eventosDeAvaliacao = [];

  UnidadeCurricular(
      {required this.id,
      required this.nome,
      required this.professor,
      required this.ano,
      required this.semestre,
      required this.ects});

  factory UnidadeCurricular.fromJson(Map<String, dynamic> json) {
    List professores = json['professores'] as List;
    String professor = "";
    for (var prof in professores) {
      professor = prof['nome'];
    }
    return UnidadeCurricular(
        id: json['id'],
        nome: json['nome'],
        professor: professor,
        ano: json['ano'],
        semestre: json['semestre'],
        ects: json['ects']);
  }

  List getEventos() {
    eventosDeAvaliacao.sort((a, b) => a.data.compareTo(b.data));
    return eventosDeAvaliacao;
  }
}
