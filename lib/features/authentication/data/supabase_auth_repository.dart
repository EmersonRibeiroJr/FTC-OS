import 'package:ftc_os/features/authentication/domain/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._client);
  final SupabaseClient _client;

  GoTrueClient get _auth => _client.auth;

  /// E-mail sintético usado internamente (ADR-005).
  static String syntheticEmail(String teamCode, String username) =>
      '${username.trim().toLowerCase()}@${teamCode.trim().toLowerCase()}.ftcos.local';

  @override
  bool get isSignedIn => _auth.currentSession != null;

  @override
  Stream<bool> watchSignedIn() =>
      _auth.onAuthStateChange.map((e) => e.session != null);

  @override
  Future<void> signIn({
    required String teamCode,
    required String username,
    required String password,
  }) async {
    await _auth.signInWithPassword(
      email: syntheticEmail(teamCode, username),
      password: password,
    );
  }

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<bool> mustChangePassword() async {
    final uid = _auth.currentUser?.id;
    if (uid == null) return false;
    final row = await _client
        .from('profiles')
        .select('must_change_password')
        .eq('user_id', uid)
        .maybeSingle();
    return (row?['must_change_password'] as bool?) ?? false;
  }

  @override
  Future<void> changePassword(String newPassword) async {
    await _auth.updateUser(UserAttributes(password: newPassword));
    final uid = _auth.currentUser!.id;
    await _client
        .from('profiles')
        .update({'must_change_password': false}).eq('user_id', uid);
  }
}
