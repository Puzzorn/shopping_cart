import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/app_database.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/check_auth_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/shop/data/shop_repository_impl.dart';
import '../../features/shop/domain/repositories/shop_repository.dart';
import '../../features/shop/presentation/bloc/cart_bloc.dart';
import '../../features/shop/presentation/bloc/shop_bloc.dart';
import '../network/api_client.dart';
import '../router/app_router.dart';
import '../../features/settings/data/datasources/settings_local_data_source.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecases/get_theme_usecase.dart';
import '../../features/settings/domain/usecases/save_theme_usecase.dart';
import '../../features/settings/presentation/cubit/theme_cubit.dart';
import '../../features/settings/presentation/cubit/language_cubit.dart';
import '../../features/shop/domain/usecases/get_products_usecase.dart';
import '../../features/shop/domain/usecases/sync_products_usecase.dart';
import '../../features/shop/domain/usecases/get_cart_items_usecase.dart';
import '../../features/shop/domain/usecases/add_to_cart_usecase.dart';
import '../../features/shop/domain/usecases/remove_from_cart_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Shop

  // Use Cases
  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  sl.registerLazySingleton(() => SyncProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetCartItemsUseCase(sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFromCartUseCase(sl()));

  // BLoCs
  sl.registerFactory(
    () => CartBloc(
      getCartItemsUseCase: sl(),
      addToCartUseCase: sl(),
      removeFromCartUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ShopBloc(getProductsUseCase: sl(), syncProductsUseCase: sl()),
  );

  sl.registerLazySingleton<ShopRepository>(
    () => ShopRepositoryImpl(sl(), sl()),
  );

  // Features - Auth
  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton(() => secureStorage);

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthUseCase(sl()));

  sl.registerLazySingleton(
    () => AuthBloc(
      loginUseCase: sl(),
      logoutUseCase: sl(),
      checkAuthUseCase: sl(),
    ),
  );

  // Features - Settings
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetThemeUseCase(sl()));
  sl.registerLazySingleton(() => SaveThemeUseCase(sl()));
  sl.registerFactory(
    () => ThemeCubit(getThemeUseCase: sl(), saveThemeUseCase: sl()),
  );
  sl.registerFactory(() => LanguageCubit(sl()));

  // Core
  sl.registerLazySingleton(() => AppDatabase());
  sl.registerLazySingleton(() => ApiClient());
  sl.registerLazySingleton(() => sl<ApiClient>().dio);
  sl.registerLazySingleton(() => AppRouter(sl()));
}
