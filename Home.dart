import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controlerCep = TextEditingController();

  String _resultado = "Resultado:";

  String cep = "03533003";

  _recuperarCep() async {

    cep = _controlerCep.text;

    var url = Uri.parse('https://viacep.com.br/ws/${cep}/json/');

    http.Response response;

    response = await http.get(url);
    
    Map<String, dynamic> retorno = jsonDecode(response.body);

    String bairro = retorno["bairro"];
    String estado = retorno["uf"];
    String cidade = retorno["localidade"];
    String ddd = retorno["ddd"];
    String logradouro = retorno["logradouro"];


    String dadosCep = "Cidade: $cidade, Estado: $estado, Bairro: $bairro, DDD: $ddd, Rua: $logradouro";

    setState(() {
      _resultado = dadosCep;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar CEP'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
              child:TextField(
                autofocus: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Digite seu CEP"
                ),
                style: TextStyle(
                    fontSize: 15
                ),
                controller: _controlerCep,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 10, right: 10,top: 20),
              child: ElevatedButton(
                  onPressed: _recuperarCep,
                  child: Text('Clique aqui')
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Text(_resultado,
                style: TextStyle(
                  fontSize: 14,
                    height: 1.3
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
