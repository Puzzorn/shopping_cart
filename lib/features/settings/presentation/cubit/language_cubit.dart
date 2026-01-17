import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  final SharedPreferences prefs;
  static const String _kLanguageCode = 'language_code';

  LanguageCubit(this.prefs) : super(const Locale('en')) {
    _loadLanguage();
  }

  void _loadLanguage() {
    final languageCode = prefs.getString(_kLanguageCode);
    if (languageCode != null) {
      emit(Locale(languageCode));
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    await prefs.setString(_kLanguageCode, languageCode);
    emit(Locale(languageCode));
  }

  Future<void> toggleLanguage() async {
    final newLang = state.languageCode == 'en' ? 'th' : 'en';
    await changeLanguage(newLang);
  }
}
