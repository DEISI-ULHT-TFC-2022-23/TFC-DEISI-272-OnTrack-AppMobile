import 'UnidadeCurricular.dart';

class EventoAvaliacao{
  late UnidadeCurricular unidadeCurricular;
  late String tipoDeEvento;
  late String metodoDeEntrega;
  late DateTime dateTime;
  late bool realizado;

  EventoAvaliacao({required this.unidadeCurricular, required this.tipoDeEvento,
      required this.metodoDeEntrega, required this.dateTime});

  bool getRealizado(){
    return DateTime.now().isAfter(dateTime);
  }
}