import 'package:flutter/material.dart';

class Redacao {

final int id;
final String escola;
final int serie;
final int mes;
final int ano;
final String arquivo;


Redacao({@required this.id, @required this.escola, @required this.serie, @required this.mes, @required this.ano, @required this.arquivo});
 factory Redacao.fromJson(Map<String, dynamic> json) {
    return Redacao(
      id: json['id'],
      escola: json['escola'],
      serie: json['serie'],
      mes: json['mes'],
      ano: json['ano'],
      arquivo: json['arquivo'],
    );
  }
}
