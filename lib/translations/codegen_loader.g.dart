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
  "entrez_taille": "Enter your height in cm",
  "entrez_age": "Enter your age",
  "imc_btn": "Calculate your BMI",
  "card_text": "Your BMI",
  "card_bmr": "BMR Schofield Formula:",
  "bmr_kcal": "kcal/day",
  "card_img": "IMG Fat Index",
  "card_poids_ideal": "Ideal weight:",
  "card_poids_ideal_kg": "Kg",
  "commentaire": "Comment",
  "maigreur_morbide": "Morbid thinness",
  "maigreur": "thinness",
  "poids_normal": "regular weight",
  "surpoids": "Overweight",
  "obesite_simple": "Simple obesity",
  "obesite_severe": "Severe obesity",
  "obesite_morbide": "Morbid obesity",
  "img_trop_faible": "Fat index too low.",
  "img_normal": "Normal fat index.",
  "img_trop_haut": "Fat index too high."
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
  "commentaire": "Commentaire",
  "maigreur_morbide": "Maigreur morbide",
  "maigreur": "Maigreur",
  "poids_normal": "Poids normal",
  "surpoids": "Surpoids",
  "obesite_simple": "Obésité simple",
  "obesite_severe": "Obésité sévère",
  "obesite_morbide": "Obésité morbide",
  "img_trop_faible": "Indice de matière grasse trop faible.",
  "img_normal": "Indice de matière grasse normal.",
  "img_trop_haut": "Indice de matière grasse trop haut."
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "fr": fr};
}
