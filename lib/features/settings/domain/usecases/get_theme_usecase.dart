import '../repositories/settings_repository.dart';

class GetThemeUseCase {
  final SettingsRepository repository;

  GetThemeUseCase(this.repository);

  Future<bool> call() async {
    return await repository.getTheme();
  }
}
