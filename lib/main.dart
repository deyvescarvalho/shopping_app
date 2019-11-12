import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "IMC Calculator",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  TextEditingController _pesoController = TextEditingController();
  TextEditingController _alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _labbelPeso = "Informe o peso em (kg)";
  String _labbelAltura = "Informe a altura em (cm)";
  String _info = "Informe seus dados!";

  double _calculoImc = 0.0;

  void _resetarCampos() {
    setState(() {
      _pesoController.text = "";
      _alturaController.text = "";
      _info = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcularImc() {
    setState(() {
      _calculoImc = double.parse(_pesoController.text) /
          (double.parse(_alturaController.text) /
              100 *
              double.parse(_alturaController.text) /
              100);
      _info = _calculoImc.toStringAsPrecision(3);
      debugPrint(_calculoImc.toStringAsPrecision(3));
      if (_calculoImc < 18.6) {
        _info = "Abaixo do peso $_info";
      } else if (_calculoImc >= 18.6 && _calculoImc < 24.9) {
        _info = "Peso ideal $_info";
      } else if (_calculoImc >= 24.9 && _calculoImc < 29.9) {
        _info = "Levemente Acima do Peso $_info";
      } else if (_calculoImc >= 29.9 && _calculoImc < 34.9) {
        _info = "Obesidade Grau I $_info";
      } else if (_calculoImc >= 34.9 && _calculoImc < 39.9) {
        _info = "Obesidade Grau II $_info";
      } else if (_calculoImc >= 40) {
        _info = "Obesidade Grau III $_info";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Calculadora IMC"),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.refresh),
//          )
//        ],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_pin,
                  size: 120,
                  color: Colors.green,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Informe o peso";
                    }
                  },
                  controller: _pesoController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      labelText: _labbelPeso,
                      labelStyle:
                          TextStyle(fontSize: 15, color: Colors.blueGrey)),
                  style: TextStyle(fontSize: 25, color: Colors.green),
                ),
                TextFormField(
                  validator: (value){
                    if(value.isEmpty){
                      return "Informe sua altura em (cm)";
                    }
                  },
                  controller: _alturaController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      labelText: _labbelAltura,
                      labelStyle:
                          TextStyle(fontSize: 15, color: Colors.blueGrey)),
                  style: TextStyle(fontSize: 25, color: Colors.green),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calcularImc();
                      }
                    },
                    color: Colors.green,
                    child: Text(
                      "Calcular IMC",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
                Text(
                  _info,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.lightGreen, fontSize: 30),
                ),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _resetarCampos();
          //teste
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
