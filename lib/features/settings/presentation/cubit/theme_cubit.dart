import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_theme_usecase.dart';
import '../../domain/usecases/save_theme_usecase.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final GetThemeUseCase getThemeUseCase;
  final SaveThemeUseCase saveThemeUseCase;

  ThemeCubit({required this.getThemeUseCase, required this.saveThemeUseCase})
    : super(ThemeMode.system);

  Future<void> loadTheme() async {
    try {
      final isDark = await getThemeUseCase();
      emit(isDark ? ThemeMode.dark : ThemeMode.light);
    } catch (_) {
      // Fallback to system if loading fails
      emit(ThemeMode.system);
    }
  }

  Future<void> toggleTheme() async {
    final isDark = state == ThemeMode.dark;
    final newTheme = !isDark;
    emit(newTheme ? ThemeMode.dark : ThemeMode.light);
    await saveThemeUseCase(newTheme);
  }
}
