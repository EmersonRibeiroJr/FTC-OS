/// Papéis de uma equipe. Espelha o enum `member_role` do banco.
enum Role {
  coach,
  mentor,
  captain,
  member,
  guest;

  static Role fromName(String name) =>
      Role.values.firstWhere((r) => r.name == name, orElse: () => Role.guest);

  bool get canManageMembers => this == coach || this == mentor;
  bool get canCreateStudentAccounts => this == coach || this == mentor;
  bool get canWrite => this != guest;
}
