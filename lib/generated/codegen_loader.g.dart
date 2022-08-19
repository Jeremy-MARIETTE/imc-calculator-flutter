// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "bienvenue": "Welcome on my app",
  "homme": "Men",
  "femme": "Women",
  "entrez_poids": "Enter your weight in kg",
  "entrez_taille": "Entrez votre taille en cm",
  "entrez_age": "Enter your height in cm",
  "imc_btn": "Calculate your BMI",
  "card_text": "Your BMI",
  "card_bmr": "BMR Schofield Formula:",
  "bmr_kcal": "kcal/day",
  "card_img": "IMG Fat Index",
  "card_poids_ideal": "Ideal weight:",
  "card_poids_ideal_kg": "Kg",
  "commentaire": "Comment"
};
static const Map<String,dynamic> fr = {
  "bienvenue": "Bienvenue sur mon application",
  "homme": "Homme",
  "femme": "Femme",
  "entrez_poids": "Entrez votre poids en kg",
  "entrez_taille": "Entrez votre taille en cm",
  "entrez_age": "Entrez votre age",
  "imc_btn": "Calculez votre IMC",
  "card_text": "Votre IMC",
  "card_bmr": "BMR Formule de Schofield:",
  "bmr_kcal": "Kcal/jour",
  "card_img": "IMG Indice de matière grasse",
  "card_poids_ideal": "Poids idéal:",
  "card_poids_ideal_kg": "Kg",
  "commentaire": "Commentaire"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "fr": fr};
}
