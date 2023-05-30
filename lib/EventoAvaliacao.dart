import 'UnidadeCurricular.dart';

class EventoAvaliacao{
  late UnidadeCurricular unidadeCurricular;
  late String tipoDeEvento;
  late String metodoDeEntrega;
  late DateTime dateTime;
  late bool realizado;

  EventoAvaliacao({required this.unidadeCurricular, required this.tipoDeEvento,
      required this.metodoDeEntrega, required this.dateTime, required this.realizado});

  factory EventoAvaliacao.fromJson(Map<String, dynamic> json) {
    return EventoAvaliacao(
      unidadeCurricular: json['unidadeCurricular'],
      tipoDeEvento: json['tipoDeEvento'],
      metodoDeEntrega: json['metodoDeEntrega'],
      dateTime: DateTime.parse(json['data']),
      realizado: json['realizado'],
    );
  }

  bool getRealizado(){
    return DateTime.now().isAfter(dateTime);
  }
}