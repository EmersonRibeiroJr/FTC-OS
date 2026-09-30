import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ftc_os/features/authentication/domain/auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._auth);
  final GoTrueClient _auth;

  /// E-mail sintético usado internamente (ADR-005).
  static String syntheticEmail(String teamCode, String username) =>
      '${username.trim().toLowerCase()}@${teamCode.trim().toLowerCase()}.ftcos.local';

  @override
  bool get isSignedIn => _auth.currentSession != null;

  @override
  Stream<bool> watchSignedIn() =>
      _auth.onAuthStateChange.map((e) => e.session != null);

  @override
  Future<void> signIn({required String teamCode, required String username, required String password}) async {
    await _auth.signInWithPassword(
      email: syntheticEmail(teamCode, username),
      password: password,
    );
  }

  @override
  Future<void> signOut() => _auth.signOut();
}
