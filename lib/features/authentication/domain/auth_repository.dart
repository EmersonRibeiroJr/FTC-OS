abstract interface class AuthRepository {
  Stream<bool> watchSignedIn();
  bool get isSignedIn;

  /// Login por código da equipe + usuário + senha.
  Future<void> signIn({
    required String teamCode,
    required String username,
    required String password,
  });
  Future<void> signOut();

  /// True quando a conta foi criada com senha temporária.
  Future<bool> mustChangePassword();
  Future<void> changePassword(String newPassword);
}
