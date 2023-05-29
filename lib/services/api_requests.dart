import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


const _servidorOnTrackAPIEndpoint = '';


Future<Map<String, dynamic>> getAluno(String id) async {
  // Id do aluno
  var idAluno = id;

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/aluno/$idAluno'));
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return {};
  }
}


Future<List<Widget>> getUCByAlunoID(BuildContext context) async {
  // Id do aluno
  var idAluno = 1;

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/aluno/$idAluno/unidades-curriculares/list'));
  if (response.statusCode == 200) {
    var resultados = jsonDecode(response.body) as List;
    var jsonResponse = resultados.map((uc) => getUCWidgetFromJSON(context, uc)).toList();
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return [];
  }
}

Future<List<Widget>> getAvaliacoes(BuildContext context, String estado) async {
  // Id do professor
  var idProf = 1;

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/$idProf/evento_avaliacao'));
  if(response.statusCode == 200) {
    var resultados = jsonDecode(response.body) as List;
    var jsonResponse = resultados.where((avaliacao) => avaliacao['estado'] == estado)
        .map((avaliacao) => getAvaliacoesWidgetFromJSON(context, avaliacao))
        .toList();
    return jsonResponse;
  }else {
    print('Request failed with status: ${response.statusCode}.');
    return [];
  }
}

Future<List<Widget>> getEventosProfessorDiaX(DateTime selectedDay) async{
  // Id do professor
  var idProf = 1;

  var response = await http.get(Uri.parse('https://6419c06ec152063412cb0109.mockapi.io/professor/$idProf/evento_avaliacao'));
  if (response.statusCode == 200) {
    List<Widget> output = [];
    var resultados = jsonDecode(response.body) as List;
    resultados.map((evento)  {
      if(evento['data_realizacao'] == DateFormat('dd/MM/yyyy').format(DateTime(selectedDay.year, selectedDay.month, selectedDay.day))){
        output.add(getHomeAvaliacoesWidgetFromJSON(evento, Colors.grey[300]));
      }
    }).toList();
    return output;
  } else {
    print('Erro ao carregar os eventos do dia');
    return [];
  }
}