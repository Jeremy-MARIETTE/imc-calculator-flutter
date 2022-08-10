//import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gauges/gauges.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {


  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Calcul IMC',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calculez votre IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController poidsController = TextEditingController();
  TextEditingController tailleController = TextEditingController();
  String poids = "";
  String taille = "";
  String resultat = "";
  int currentIndex = 0;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Container(

          child: Column(


            children: <Widget>[



              SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  radioButton("Homme", Colors.blue, 0),
                  radioButton("Femme", Colors.pink, 1),
                ],
              ),


              SizedBox(
                height: 20,
              ),
              TextField(
                controller: poidsController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Entrez votre poids en kg",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (val){
                  setState(() {
                    poids = val;
                  });

                },
              ),
              SizedBox(
                height: 20,
              ),

              TextField(
                  controller: tailleController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Entrez votre taille en cm",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (val){
                    setState(() {
                      taille = val;
                    });

                  }

              ),
              SizedBox(
                height: 20,
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  double poids = double.parse(poidsController.value.text);
                  double taille = double.parse(tailleController.value.text);
                  calculImc(poids, taille);
                },
                label: const Text('Calculez votre IMC'),
                icon: const Icon(Icons.line_weight),
                backgroundColor: Colors.blue,
              ),
              SizedBox(
                height: 20,
              ),


              Text("Voter IMC :  $resultat"),


            ],


          ),

        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );


  }

  buttonAction(){
    Text("Vous avez appuyé sur le bouton");
  }
  void  calculImc(double poids, double taille){
    double finalresultat = poids / (taille * taille/10000);
    String imc = finalresultat.toStringAsFixed(2);
    setState(() {
      resultat = imc;
    });
  }

  void changeIndex(int index){
    setState(() {
      currentIndex = index;
    });
  }

  Widget radioButton(String value, Color color, int index){
    return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          child:FlatButton(
            color: currentIndex == index ? color : Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onPressed: (){
              changeIndex(index);
              print("Index : $index");
              if (index == 0){
                print("Vous êtes un Homme");
              }else{
                print("Vous êtes une Femme");
              }
            },
            child: Text(value, style: TextStyle(
              color: currentIndex == index ? Colors.white : color,
            ),) ,
          ) ,
        )
    );
  }

}
