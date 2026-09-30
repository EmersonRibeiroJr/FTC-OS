import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftc_os/core/l10n/app_localizations.dart';
import 'package:ftc_os/shared/design_system/tokens.dart';
import 'package:ftc_os/features/authentication/presentation/auth_providers.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _team = TextEditingController();
  final _user = TextEditingController();
  final _pass = TextEditingController();
  bool _busy = false;
  String? _error;

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    setState(() { _busy = true; _error = null; });
    try {
      await ref.read(authRepositoryProvider).signIn(
        teamCode: _team.text, username: _user.text, password: _pass.text,);
    } catch (_) {
      setState(() => _error = l10n.signInFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(Space.xl),
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text(l10n.appName, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: Space.xs),
              Text(l10n.tagline),
              const SizedBox(height: Space.xxl),
              TextField(controller: _team, decoration: InputDecoration(labelText: l10n.teamCode)),
              const SizedBox(height: Space.md),
              TextField(controller: _user, decoration: InputDecoration(labelText: l10n.username)),
              const SizedBox(height: Space.md),
              TextField(controller: _pass, obscureText: true, decoration: InputDecoration(labelText: l10n.password)),
              if (_error != null) Padding(
                padding: const EdgeInsets.only(top: Space.md),
                child: Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              ),
              const SizedBox(height: Space.xl),
              FilledButton(onPressed: _busy ? null : _submit, child: Text(l10n.signIn)),
            ],),
          ),
        ),
      ),
    );
  }
}
