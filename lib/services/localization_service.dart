import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localizationProvider = StateProvider<String>((ref) => 'en');

class LocalizationService {
  static const supportedLocales = [
    Locale('en', 'US'),
    Locale('es', 'ES'),
    Locale('fr', 'FR'),
  ];

  static String getLanguageName(String code) {
    switch (code) {
      case 'es': return 'Español';
      case 'fr': return 'Français';
      default: return 'English';
    }
  }

  static Map<String, Map<String, String>> translations = {
    'en': {
      'welcome': 'Welcome',
      'login': 'Login',
      'signup': 'Sign Up',
      'profile': 'Profile',
      'settings': 'Settings',
      'language': 'Language',
      'theme': 'Theme',
    },
    'es': {
      'welcome': 'Bienvenido',
      'login': 'Iniciar sesión',
      'signup': 'Registrarse',
      'profile': 'Perfil',
      'settings': 'Configuración',
      'language': 'Idioma',
      'theme': 'Tema',
    },
    'fr': {
      'welcome': 'Bienvenue',
      'login': 'Connexion',
      'signup': 'Inscription',
      'profile': 'Profil',
      'settings': 'Paramètres',
      'language': 'Langue',
      'theme': 'Thème',
    },
  };

  static String translate(String key, String language) {
    return translations[language]?[key] ?? key;
  }
}