import 'package:ftc_os/core/permissions/role.dart';
import 'package:ftc_os/features/team/domain/team_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseTeamRepository implements TeamRepository {
  SupabaseTeamRepository(this._client);
  final SupabaseClient _client;

  @override
  Future<Membership?> myMembership() async {
    final uid = _client.auth.currentUser?.id;
    if (uid == null) return null;
    final row = await _client
        .from('members')
        .select('team_id, role')
        .eq('user_id', uid)
        .isFilter('deleted_at', null)
        .limit(1)
        .maybeSingle();
    if (row == null) return null;
    return Membership(
      teamId: row['team_id'] as String,
      role: Role.fromName(row['role'] as String),
    );
  }

  @override
  Future<List<TeamMember>> members(String teamId) async {
    final rows = await _client
        .from('members')
        .select('user_id, role')
        .eq('team_id', teamId)
        .isFilter('deleted_at', null);
    if (rows.isEmpty) return [];
    final ids = rows.map((r) => r['user_id'] as String).toList();
    final profiles = await _client
        .from('profiles')
        .select('user_id, display_name, username')
        .inFilter('user_id', ids);
    final byId = {for (final p in profiles) p['user_id'] as String: p};
    return [
      for (final r in rows)
        TeamMember(
          userId: r['user_id'] as String,
          displayName: (byId[r['user_id']]?['display_name'] as String?) ?? '?',
          username: (byId[r['user_id']]?['username'] as String?) ?? '',
          role: Role.fromName(r['role'] as String),
        ),
    ];
  }

  @override
  Future<void> createStudent({
    required String teamId,
    required String displayName,
    required String username,
    required String password,
  }) async {
    await _client.functions.invoke(
      'create-student',
      body: {
        'teamId': teamId,
        'displayName': displayName,
        'username': username,
        'password': password,
      },
    );
  }
}
