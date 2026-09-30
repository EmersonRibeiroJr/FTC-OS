import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftc_os/features/authentication/presentation/auth_providers.dart';
import 'package:ftc_os/features/team/data/supabase_team_repository.dart';
import 'package:ftc_os/features/team/domain/team_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final teamRepositoryProvider = Provider<TeamRepository>(
  (ref) => SupabaseTeamRepository(Supabase.instance.client),
);

final myMembershipProvider = FutureProvider<Membership?>((ref) {
  ref.watch(signedInProvider); // recarrega ao trocar de usuário
  return ref.watch(teamRepositoryProvider).myMembership();
});

final teamMembersProvider = FutureProvider<List<TeamMember>>((ref) async {
  final m = await ref.watch(myMembershipProvider.future);
  if (m == null) return [];
  return ref.watch(teamRepositoryProvider).members(m.teamId);
});
