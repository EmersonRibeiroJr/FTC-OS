abstract interface class AuthRepository {
  Stream<bool> watchSignedIn();
  bool get isSignedIn;

  /// Login por código da equipe + usuário + senha (alunos não precisam de e-mail).
  Future<void> signIn({required String teamCode, required String username, required String password});
  Future<void> signOut();
}
