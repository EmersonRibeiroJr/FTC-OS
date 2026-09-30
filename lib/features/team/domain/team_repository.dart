import 'package:ftc_os/core/permissions/role.dart';

class Membership {
  const Membership({required this.teamId, required this.role});
  final String teamId;
  final Role role;
}

class TeamMember {
  const TeamMember({
    required this.userId,
    required this.displayName,
    required this.username,
    required this.role,
  });
  final String userId;
  final String displayName;
  final String username;
  final Role role;
}

abstract interface class TeamRepository {
  Future<Membership?> myMembership();
  Future<List<TeamMember>> members(String teamId);
  Future<void> createStudent({
    required String teamId,
    required String displayName,
    required String username,
    required String password,
  });
}
