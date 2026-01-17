abstract class SettingsRepository {
  Future<void> saveTheme(bool isDark);
  Future<bool> getTheme();
}
