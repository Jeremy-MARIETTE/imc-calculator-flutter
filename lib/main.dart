//import 'dart:html';
//import 'dart:developer';
//import 'dart:typed_data';


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
  String commentaireImc = "";
  double imcPointer = 18;





  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body:

    SingleChildScrollView(
        child:

        Container(

          child:


          Column(


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


              chart(),
              Text("Votre IMC :"),
              Text(resultat,style: TextStyle(
                fontSize:40,
                fontWeight: FontWeight.bold,
              ),),
              Text("Commentaire :"),
              Text(commentaireImc,style: TextStyle(
                fontSize:30,
                fontWeight: FontWeight.bold,
              ),),


            ],


          ),
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    ),
);

  }

  buttonAction(){
    Text("Vous avez appuyé sur le bouton");
  }
  void  calculImc(double poids, double taille){
    double finalresultat = poids / (taille * taille/10000);

      commImc(finalresultat);
    String imc = finalresultat.toStringAsFixed(2);
    setState(() {
      resultat = imc;
      imcPointer = finalresultat;
    });
  }

  void changeIndex(int index){
    setState(() {
      currentIndex = index;


    });
  }

   commImc(finalresultat){
    setState(() {
      if(finalresultat < 16.5){
        commentaireImc = "Maigreur morbide";
     }if(finalresultat > 16.5 && finalresultat < 18.5){
        commentaireImc = "Maigreur";
      }
      if(finalresultat > 18.5 && finalresultat < 25){
        commentaireImc = "Poids normal";
      }
      if(finalresultat > 25 && finalresultat < 30){
        commentaireImc = "Surpoids";
      }
      if(finalresultat > 30 && finalresultat < 35){
        commentaireImc = "Obésité simple";
      }
      if(finalresultat > 35 && finalresultat < 40){
        commentaireImc = "Obésité sévère";
      }
      if(finalresultat > 40 ){
        commentaireImc = "Obésité morbide";
      }

    }

      );

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

  Widget chart(){

   return  Container(
     margin: EdgeInsets.only(top:90),
     padding: EdgeInsets.only(bottom: 0),
     //color: Colors.amber[600],
      height: 200,


      child:   RadialGauge(
        axes: [
          RadialGaugeAxis(
           /*
            ticks: [
              RadialTicks(
                values: [12,18,25,48],
                  interval: 10,
                  alignment: RadialTickAxisAlignment.below,
                  color: Colors.blue,
                  length: 0.2,
              ),
            ],
            */
            color: Colors.transparent,
            minValue: 0,
            maxValue: 60,
            segments: [
              RadialGaugeSegment(
                minValue: 0,
                maxValue: 18.5,
                minAngle: -90,
                maxAngle: -60,
                color: Colors.blue,


              ),
              RadialGaugeSegment(
                minValue: 18.5,
                maxValue: 25,
                minAngle: -60,
                maxAngle: -25,
                color: Colors.green,
              ),
              RadialGaugeSegment(
                minValue: 25,
                maxValue: 60,
                minAngle: -25,
                maxAngle: 90,
                color: Colors.red,
              ),
              // ...
            ],
            pointers: [
              RadialNeedlePointer(
                value: imcPointer,
                thicknessStart: 20,
                thicknessEnd: 0,
                length: 0.6,
                knobRadiusAbsolute: 10,
                //gradient: LinearGradient(...),
              )
            ],
          ),
        ],
      ),
    );

  }

}
