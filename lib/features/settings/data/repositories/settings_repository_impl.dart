import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;
  SettingsRepositoryImpl(this.localDataSource);
  @override
  Future<bool> getTheme() async {
    final isDark = await localDataSource.getLastTheme();
    return isDark ?? false; // Default to light theme if no preference found
  }

  @override
  Future<void> saveTheme(bool isDark) async {
    await localDataSource.cacheTheme(isDark);
  }
}
