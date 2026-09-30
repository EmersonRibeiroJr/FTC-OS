import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftc_os/core/l10n/app_localizations.dart';
import 'package:ftc_os/features/authentication/presentation/auth_providers.dart';
import 'package:ftc_os/shared/design_system/tokens.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});
  @override
  ConsumerState<ChangePasswordPage> createState() => _State();
}

class _State extends ConsumerState<ChangePasswordPage> {
  final _new = TextEditingController();
  final _confirm = TextEditingController();
  bool _busy = false;
  String? _error;

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    if (_new.text.length < 8) {
      setState(() => _error = l10n.passwordTooShort);
      return;
    }
    if (_new.text != _confirm.text) {
      setState(() => _error = l10n.passwordsDontMatch);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(authRepositoryProvider).changePassword(_new.text);
      ref.invalidate(mustChangePasswordProvider); // o router libera o acesso
    } catch (_) {
      if (mounted) {
        setState(() {
          _busy = false;
          _error = l10n.changePasswordFailed;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => ref.read(authRepositoryProvider).signOut(),
            child: Text(l10n.signOut),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(Space.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.changePasswordTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: Space.sm),
                Text(l10n.changePasswordBody),
                const SizedBox(height: Space.xl),
                TextField(
                  controller: _new,
                  obscureText: true,
                  decoration: InputDecoration(labelText: l10n.newPassword),
                ),
                const SizedBox(height: Space.md),
                TextField(
                  controller: _confirm,
                  obscureText: true,
                  decoration: InputDecoration(labelText: l10n.confirmPassword),
                ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: Space.md),
                    child: Text(
                      _error!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                const SizedBox(height: Space.xl),
                FilledButton(
                  onPressed: _busy ? null : _submit,
                  child: Text(l10n.savePassword),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
