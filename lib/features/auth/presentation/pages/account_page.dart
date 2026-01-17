import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/l10n/generated/app_localizations.dart';
import '../../presentation/bloc/auth_bloc.dart';
import '../../presentation/bloc/auth_event.dart';
import '../../presentation/bloc/auth_state.dart';
import '../../../settings/presentation/cubit/theme_cubit.dart';
import '../../../settings/presentation/cubit/language_cubit.dart';
import '../../../../core/theme/app_dimens.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    // We don't need BlocListener for navigation here because AppRouter handles it globally (AuthGuard).
    // Just dispatch Logout event.
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.accountSettings)),
      body: ListView(
        children: [
          // Section 1: User Profile
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return Container(
                  padding: const EdgeInsets.all(AppDimens.paddingPage),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        child: Icon(Icons.person, size: 40),
                      ),
                      const SizedBox(height: AppDimens.spacingM),
                      Text(
                        state.user.username,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppDimens.spacingXS),
                      Text(
                        state.user.email,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const Divider(),

          // Section 2: Settings
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimens.spacingM,
              AppDimens.spacingM,
              AppDimens.spacingM,
              AppDimens.spacingS,
            ),
            child: Text(
              l10n.settings,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              final isDark = themeMode == ThemeMode.dark;
              return SwitchListTile(
                title: Text(l10n.darkMode),
                subtitle: Text(l10n.switchTheme),
                secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                value: isDark,
                onChanged: (value) {
                  context.read<ThemeCubit>().toggleTheme();
                },
              );
            },
          ),
          BlocBuilder<LanguageCubit, Locale>(
            builder: (context, locale) {
              final isThai = locale.languageCode == 'th';
              return SwitchListTile(
                title: Text(l10n.languageThai),
                subtitle: Text(
                  isThai ? l10n.statusActive : l10n.actionSwitchToThai,
                ),
                secondary: const Icon(Icons.language),
                value: isThai,
                onChanged: (value) {
                  context.read<LanguageCubit>().toggleLanguage();
                },
              );
            },
          ),

          const Divider(),

          // Section 3: Actions
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(
              l10n.signOut,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              context.read<AuthBloc>().add(AuthLogoutClicked());
            },
          ),
        ],
      ),
    );
  }
}
