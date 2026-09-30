import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftc_os/core/l10n/app_localizations.dart';
import 'package:ftc_os/features/authentication/presentation/auth_providers.dart';
import 'package:ftc_os/features/authentication/presentation/login_page.dart';
import 'package:ftc_os/features/team/presentation/team_page.dart';
import 'package:ftc_os/shared/design_system/empty_state.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final signedIn = ref.watch(signedInProvider).valueOrNull ?? false;
  return GoRouter(
    initialLocation: '/home',
    redirect: (_, state) {
      final atLogin = state.matchedLocation == '/login';
      if (!signedIn) return atLogin ? null : '/login';
      return atLogin ? '/home' : null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
      GoRoute(path: '/home', builder: (_, __) => const _HomePlaceholder()),
      GoRoute(path: '/team', builder: (_, __) => const TeamPage()),
    ],
  );
});

class _HomePlaceholder extends ConsumerWidget {
  const _HomePlaceholder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeTitle),
        actions: [
          IconButton(
            tooltip: l10n.team,
            icon: const Icon(Icons.groups_outlined),
            onPressed: () => context.push('/team'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authRepositoryProvider).signOut(),
          ),
        ],
      ),
      body: EmptyState(title: l10n.homeEmptyTitle, body: l10n.homeEmptyBody),
    );
  }
}
