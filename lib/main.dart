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
  TextEditingController ageController = TextEditingController();
  String poids = "";
  String taille = "";
  String resultat = "";
  int currentIndex = 1;
  String commentaireImc = "";
  double imcPointer = 18;
  double age = 0;
  double img =0;





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
                  radioButton("Homme", Colors.blue, 1),
                  radioButton("Femme", Colors.pink, 0),
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
              TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Entrez votre age",
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
                  double newAge =  double.parse(ageController.value.text);
                  calculImc(poids, taille);
                  //Enlève le clavier
                  FocusManager.instance.primaryFocus?.unfocus();

                  setState(() {
                    age = newAge;
                  });
                  IMG(imcPointer,age,currentIndex);
                },
                label: const Text('Calculez votre IMC'),
                backgroundColor: Colors.blue,
              ),
              SizedBox(
                height: 20,
              ),


              chart(),
              Container(
                color: Colors.amber[600],
                width: 300,
                child:  Column(
                  children: [
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
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.amber[600],
                width: 300,
                child: Column(
                  children: [
                    Text(""
                        "BMR Formule de Schofield:"),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.amber[600],
                width: 300,
                child: Column(
                  children: [
                    Text("IMG Indice de matière grasse:"),
                    Text(img.toStringAsFixed(2),style: TextStyle(
                      fontSize:30,
                      fontWeight: FontWeight.bold,
                    ),),
                    Text("Commentaire:"),
                  ],

                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.amber[600],
                width: 300,
                child: Column(
                  children: [
                    Text(""
                        "Poids idéal:"),
                  ],
                ),
              ),




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

  IMG(imc,age,currentIndex){
    setState(() {
      img = (1.2*imc)+(0.23*age)-(10.8*currentIndex)-5.4;
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
              if (index == 1){
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
                maxValue: 30,
                minAngle: -25,
                maxAngle: -5,
                color: Colors.yellow,
              ),
              RadialGaugeSegment(
                minValue: 30,
                maxValue: 35,
                minAngle: -5,
                maxAngle: 25,
                color: Colors.orange,
              ),
              RadialGaugeSegment(
                minValue: 35,
                maxValue: 40,
                minAngle: 25,
                maxAngle: 55,
                color: Colors.red,
              ),
              RadialGaugeSegment(
                minValue: 40,
                maxValue: 40,
                minAngle: 55,
                maxAngle: 90,
                color: Colors.black,
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
