import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {
  Future<void> cacheTheme(bool isDark);
  Future<bool?> getLastTheme();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImpl(this.sharedPreferences);

  static const cachedThemeKey = 'CACHED_THEME';

  @override
  Future<void> cacheTheme(bool isDark) {
    return sharedPreferences.setBool(cachedThemeKey, isDark);
  }

  @override
  Future<bool?> getLastTheme() async {
    return sharedPreferences.getBool(cachedThemeKey);
  }
}
