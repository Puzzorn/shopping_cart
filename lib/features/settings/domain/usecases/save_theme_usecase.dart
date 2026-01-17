import '../repositories/settings_repository.dart';

class SaveThemeUseCase {
  final SettingsRepository repository;

  SaveThemeUseCase(this.repository);

  Future<void> call(bool isDark) async {
    await repository.saveTheme(isDark);
  }
}
