//import 'dart:html';
//import 'dart:developer';
//import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:gauges/gauges.dart';
import 'package:easy_localization/easy_localization.dart';
import './translations/codegen_loader.g.dart';
import '../translations/locale_keys.g.dart';
import 'package:flag/flag.dart';








void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(child: MyApp(),
        supportedLocales: [
          Locale('fr'),
          Locale('en')
        ],
        fallbackLocale: Locale('en'),
        assetLoader: CodegenLoader(),
        path: 'assets/translations')

  );
}

class MyApp extends StatelessWidget {


  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
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
  String commentaireImg = "";
  double imcPointer = 18;
  double age = 0;
  double img =0 ;
  double poidsIdeal = 0;
  double tailleCalcul = 0;
  double poidsCalcul = 0;
  double bmr = 0;





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
              Text(
                LocaleKeys.bienvenue.tr(),
              ),
              SizedBox(
                height: 20,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly ,

              children: [
                ElevatedButton(onPressed: () async{
                  await context.setLocale(Locale('fr'));
                },
                  style: ButtonStyle(
                 backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child:  Flag.fromCode(
                    FlagsCode.FR,
                    height: 40,
                    width: 60,
                    fit: BoxFit.cover,
                  ),

                ),

                ElevatedButton(onPressed: () async{
                  await context.setLocale(Locale('en'));
                },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child:  Flag.fromCode(
                    FlagsCode.US,
                    height: 40,
                    width: 60,
                    fit: BoxFit.fill,
                  ),

                ),

              ],
            ),
              SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  radioButton(LocaleKeys.homme.tr(), Colors.blue, 1),
                  radioButton(LocaleKeys.femme.tr(), Colors.pink, 0),
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
                  hintText: LocaleKeys.entrez_poids.tr(),
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
                    hintText: LocaleKeys.entrez_taille.tr(),
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
                    hintText: LocaleKeys.entrez_age.tr(),
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
                    tailleCalcul = taille;
                    poidsCalcul = poids;
                  });
                  IMG(imcPointer,age,currentIndex);
                  calculPoids(currentIndex,tailleCalcul);
                  BMR(age, poidsCalcul, currentIndex);
                },
                label: Text( LocaleKeys.imc_btn.tr() ),
                backgroundColor: Colors.blue,
              ),
              SizedBox(
                height: 20,
              ),


              chart(),
              card(LocaleKeys.card_text.tr(), resultat, commentaireImc),

              SizedBox(
                height: 20,
              ),
              card(LocaleKeys.card_bmr.tr(), bmr.toStringAsFixed(2),LocaleKeys.bmr_kcal.tr()),

              SizedBox(
                height: 20,
              ),
              card(LocaleKeys.card_img.tr(), img.toStringAsFixed(2), commentaireImg),

              SizedBox(
                height: 20,
              ),
              card(LocaleKeys.card_poids_ideal.tr(), poidsIdeal.toStringAsFixed(2), LocaleKeys.card_poids_ideal_kg.tr()),

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
        commentaireImc = LocaleKeys.maigreur_morbide.tr();
     }if(finalresultat > 16.5 && finalresultat < 18.5){
        commentaireImc = LocaleKeys.maigreur.tr();
      }
      if(finalresultat > 18.5 && finalresultat < 25){
        commentaireImc = LocaleKeys.poids_normal.tr();
      }
      if(finalresultat > 25 && finalresultat < 30){
        commentaireImc = LocaleKeys.surpoids.tr();
      }
      if(finalresultat > 30 && finalresultat < 35){
        commentaireImc = LocaleKeys.obesite_simple.tr();
      }
      if(finalresultat > 35 && finalresultat < 40){
        commentaireImc = LocaleKeys.obesite_severe.tr();
      }
      if(finalresultat > 40 ){
        commentaireImc = LocaleKeys.obesite_morbide.tr();
      }

    }

      );

  }

  commImg(imgResult,currentIndex){
    setState(() {

      if(currentIndex == 1){
        if(imgResult < 15){
          commentaireImg = LocaleKeys.img_trop_faible.tr();
        }
        if(imgResult > 15 && imgResult < 20){
          commentaireImg = LocaleKeys.img_normal.tr();
        }
        if(imgResult > 20){
          commentaireImg = LocaleKeys.img_trop_haut.tr();
        }

      }
      if(currentIndex == 0){
        if(imgResult < 25){
          commentaireImg = LocaleKeys.img_trop_faible.tr();
        }
        if(imgResult > 25 && imgResult < 30){
          commentaireImg = LocaleKeys.img_normal.tr();
        }
        if(imgResult > 30){
          commentaireImg = LocaleKeys.img_trop_haut.tr();
        }

      }

    });
  }

  IMG(imc,age,currentIndex){
    setState(() {
      img = (1.2*imc)+(0.23*age)-(10.8*currentIndex)-5.4;

    });
    commImg(img, currentIndex);
  }
BMR(age,poids,currentIndex){
    setState(() {
      if(currentIndex == 1){
        if(age >10 && age <17){
            bmr = 17.686*poids+658.2;
        }
        if(age >17 && age <30){
          bmr = 15.057*poids+692.2;
        }
        if(age >30 && age <60){
          bmr = 11.472*poids+873.1;
        }
        if(age >60){
          bmr = 11.411*poids+587.7;
        }

      }
      if(currentIndex == 0){
        if(age >10 && age <17){
          bmr = 13.384*poids+692.6;
        }
        if(age >17 && age <30){
          bmr = 14.818*poids+486.6;
        }
        if(age >30 && age <60){
          bmr = 8.126*poids+845.6;
        }
        if(age >60){
          bmr = 9.082*poids+658.5;
        }

      }
    });

}

  calculPoids(currentIndex,tailleCalcul){

    setState(() {
      if(currentIndex == 1){
        poidsIdeal = tailleCalcul-100-((tailleCalcul-150)/4);
      }
      if(currentIndex == 0){
        poidsIdeal = tailleCalcul-100-((tailleCalcul-150)/2.5);
      }
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

  card(titre,data,commentaire){
    return  Container(
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.grey,
            width: 5.0,
            style: BorderStyle.solid
        ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
      ),
      child:  Column(
        children: [
          Text("$titre"),
          Text(data,style: TextStyle(
            fontSize:40,
            fontWeight: FontWeight.bold,
          ),),
          Text(LocaleKeys.commentaire.tr()),
          Text(commentaire,style: TextStyle(
            fontSize:30,
            fontWeight: FontWeight.bold,
          ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

}
