import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/main/presentation/pages/main_page.dart';
import '../../features/shop/presentation/pages/checkout_page.dart';
import '../../features/shop/presentation/pages/product_detail_page.dart';
import '../../features/shop/domain/entities/product.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter(
    initialLocation: '/splash',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    debugLogDiagnostics: true,
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/',
        builder: (context, state) => const MainPage(),
        routes: [
          GoRoute(
            path: 'checkout',
            builder: (context, state) => const CheckoutPage(),
          ),
          GoRoute(
            path: 'product-detail',
            builder: (context, state) {
              final product = state.extra as Product;
              return ProductDetailPage(product: product);
            },
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final authState = authBloc.state;
      final isUnauthenticated = authState is AuthUnauthenticated;
      final isAuthenticated = authState is AuthAuthenticated;

      final isSplashing = state.matchedLocation == '/splash';
      final isLoggingIn = state.matchedLocation == '/login';

      // If generic "checking" state (initial), maybe stay on splash?
      // Assuming AuthBloc emits Unauthenticated or Authenticated eventually.

      if (isUnauthenticated && !isLoggingIn) {
        return '/login';
      }

      if (isAuthenticated && (isLoggingIn || isSplashing)) {
        return '/';
      }

      return null;
    },
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
