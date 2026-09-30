import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftc_os/core/l10n/app_localizations.dart';
import 'package:ftc_os/core/permissions/role.dart';
import 'package:ftc_os/features/team/presentation/team_providers.dart';
import 'package:ftc_os/shared/design_system/empty_state.dart';
import 'package:ftc_os/shared/design_system/tokens.dart';

String roleLabel(AppLocalizations l, Role r) => switch (r) {
      Role.coach => l.roleCoach,
      Role.mentor => l.roleMentor,
      Role.captain => l.roleCaptain,
      Role.member => l.roleMember,
      Role.guest => l.roleGuest,
    };

class TeamPage extends ConsumerWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final membership = ref.watch(myMembershipProvider).valueOrNull;
    final members = ref.watch(teamMembersProvider);
    final canAdd = membership?.role.canCreateStudentAccounts ?? false;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.team)),
      floatingActionButton: canAdd
          ? FloatingActionButton.extended(
              onPressed: () async {
                final ok = await showDialog<bool>(
                  context: context,
                  builder: (_) => _AddStudentDialog(teamId: membership!.teamId),
                );
                if (ok ?? false) {
                  ref.invalidate(teamMembersProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(l10n.studentCreated)));
                  }
                }
              },
              icon: const Icon(Icons.person_add_alt_1),
              label: Text(l10n.addStudent),
            )
          : null,
      body: members.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (list) => list.isEmpty
            ? EmptyState(title: l10n.teamEmptyTitle, body: l10n.teamEmptyBody)
            : ListView.separated(
                padding: const EdgeInsets.all(Space.lg),
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: Space.sm),
                itemBuilder: (_, i) {
                  final m = list[i];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(m.displayName.characters.first.toUpperCase()),
                      ),
                      title: Text(m.displayName),
                      subtitle: Text('@${m.username}'),
                      trailing: Chip(label: Text(roleLabel(l10n, m.role))),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class _AddStudentDialog extends ConsumerStatefulWidget {
  const _AddStudentDialog({required this.teamId});
  final String teamId;
  @override
  ConsumerState<_AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends ConsumerState<_AddStudentDialog> {
  final _name = TextEditingController();
  final _user = TextEditingController();
  final _pass = TextEditingController();
  bool _busy = false;
  bool _failed = false;

  Future<void> _submit() async {
    setState(() {
      _busy = true;
      _failed = false;
    });
    try {
      await ref.read(teamRepositoryProvider).createStudent(
            teamId: widget.teamId,
            displayName: _name.text,
            username: _user.text,
            password: _pass.text,
          );
      if (mounted) Navigator.of(context).pop(true);
    } catch (_) {
      if (mounted) {
        setState(() {
          _busy = false;
          _failed = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.addStudent),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _name,
              decoration: InputDecoration(labelText: l10n.displayName),
            ),
            const SizedBox(height: Space.md),
            TextField(
              controller: _user,
              decoration: InputDecoration(labelText: l10n.username),
            ),
            const SizedBox(height: Space.md),
            TextField(
              controller: _pass,
              obscureText: true,
              decoration: InputDecoration(labelText: l10n.tempPassword),
            ),
            if (_failed)
              Padding(
                padding: const EdgeInsets.only(top: Space.md),
                child: Text(
                  l10n.createStudentFailed,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(minimumSize: const Size(0, 40)),
          onPressed: _busy ? null : _submit,
          child: Text(l10n.create),
        ),
      ],
    );
  }
}
