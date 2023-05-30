import 'EventoAvaliacao.dart';

class UnidadeCurricular {
  late String nome;
  late String docenteTeoricas;
  late String docentePraticas;
  late int ano;
  late int semestre;
  late int ects;
  late List eventosDeAvaliacao = [];

  UnidadeCurricular(
      {required this.nome,
      required this.docenteTeoricas,
      required this.docentePraticas,
      required this.ano,
      required this.semestre,
      required this.ects,
      required this.eventosDeAvaliacao});

  factory UnidadeCurricular.fromJson(Map<String, dynamic> json) {
    List<EventoAvaliacao> eventos = [];
    if (json['eventosAvaliacao'] != null) {
      for (var eventoData in json['eventosAvaliacao']) {
        EventoAvaliacao evento = EventoAvaliacao.fromJson(eventoData);
        eventos.add(evento);
      }
    }
    return UnidadeCurricular(
      nome: json['nome'],
      docenteTeoricas: json['docenteTeoricas'],
      docentePraticas: json['docentePraticas'],
      ano: json['ano'],
      semestre: json['semestre'],
      ects: json['ects'],
      eventosDeAvaliacao: eventos,
    );
  }

  List getEventos() {
    eventosDeAvaliacao.sort((a, b) => a.data.compareTo(b.data));
    return eventosDeAvaliacao;
  }
}
