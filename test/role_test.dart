import 'package:flutter_test/flutter_test.dart';
import 'package:ftc_os/core/permissions/role.dart';
import 'package:ftc_os/features/authentication/data/supabase_auth_repository.dart';

void main() {
  test('apenas coach e mentor criam contas de alunos', () {
    expect(Role.mentor.canCreateStudentAccounts, isTrue);
    expect(Role.coach.canCreateStudentAccounts, isTrue);
    expect(Role.captain.canCreateStudentAccounts, isFalse);
    expect(Role.guest.canWrite, isFalse);
  });

  test('e-mail sintético é normalizado', () {
    expect(SupabaseAuthRepository.syntheticEmail(' ABC1 ', 'Ana '), 'ana@abc1.ftcos.local');
  });
}
