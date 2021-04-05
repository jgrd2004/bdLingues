import 'package:flutter/material.dart';
import 'categoria.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de categorias',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Lista de categorias'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Categoria> categorias = [];
  Future<Categoria> futureCategoria;


  @override
  void initState() {
    super.initState();
    futureCategoria = fetchCategoria();
    /*redacoes.add(new Redacao(
        id: 1,
        escola: "Colegio Stella Maris",
        serie: 3,
        mes: 3,
        ano: 2021,
        arquivo: "Arquivo 1"));
    redacoes.add(new  Redacao(
        id: 2,
        escola: "Colegio Stella Maris",
        serie: 3,
        mes: 3,
        ano: 2021,
         arquivo: "Arquivo 2"));
    redacoes.add(new  Redacao(
        id: 3,
        escola: "Colegio Stella Maris",
        serie: 3,
        mes: 3,
        ano: 2021,
         arquivo: "Arquivo 3"));*/
  
    categorias.sort((a, b) => a.nome.compareTo(b.nome));
  }
  Future<Categoria> fetchCategoria() async {
  final response = await http.get(Uri.https('bdlingues-service.herokuapp.com/','categoria/14'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Categoria.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load categoria');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
            itemBuilder: (context, index) {
              var categoria = categorias[index];
              return ListTile(
                title: Text(categoria.id.toString()),
                subtitle: Text(categoria.nome),
                );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: categorias.length));
  }
}

class Contato {
  final String nome;
  final String telefone;
  final ContatoType tipo;

  Contato({@required this.nome, @required this.telefone, @required this.tipo});
}

enum ContatoType { CELULAR, TRABALHO, FAVORITO, CASA }

class ContatoHelper {
  static Icon getIconByContatoType(ContatoType tipo) {
    switch (tipo) {
      case ContatoType.CELULAR:
        return Icon(Icons.phone_android, color: Colors.green[700]);
      case ContatoType.TRABALHO:
        return Icon(Icons.work, color: Colors.brown[600]);
      case ContatoType.FAVORITO:
        return Icon(Icons.star, color: Colors.yellow[600]);
      case ContatoType.CASA:
        return Icon(Icons.home, color: Colors.purple[700]);
    }
  }
}
