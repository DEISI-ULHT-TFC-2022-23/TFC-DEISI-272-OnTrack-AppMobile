import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tfc_ontack/EventoAvaliacao.dart';
import 'package:tfc_ontack/User.dart';

import '../UnidadeCurricular.dart';


const _servidorOnTrackAPIEndpoint = '';

Future<List<UnidadeCurricular>> fetchUnidadesFromAPI() async {
  final response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/aluno/unidades-curriculares'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    List<UnidadeCurricular> unidades = [];
    for (var unidadeData in data) {
      UnidadeCurricular unidade = UnidadeCurricular.fromJson(unidadeData);
      unidades.add(unidade);
    }
    return unidades;
  } else {
    throw Exception('Erro ao buscar unidades da API');
  }
}

Future<User> fetchUserFromAPI(String id) async {
  var idAluno = id;

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/aluno/$idAluno'));
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    User user = User.fromJson(jsonResponse);
    return user;
  } else {
    throw Exception('Erro ao buscar user da API');
  }
}

Future<List<EventoAvaliacao>> fetchAvaliacoesFromAPI() async {
  final response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/aluno/avaliacoes'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    List<EventoAvaliacao> avaliacoes = [];
    for (var avaliacaoData in data) {
      EventoAvaliacao unidade = EventoAvaliacao.fromJson(avaliacaoData);
      avaliacoes.add(unidade);
    }
    return avaliacoes;
  } else {
    throw Exception('Erro ao buscar unidades da API');
  }
}