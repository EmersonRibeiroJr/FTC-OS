// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'FTC OS';

  @override
  String get tagline => 'Tudo o que sua equipe FTC precisa.';

  @override
  String get teamCode => 'Código da equipe';

  @override
  String get username => 'Usuário';

  @override
  String get password => 'Senha';

  @override
  String get signIn => 'Entrar';

  @override
  String get signInFailed =>
      'Não foi possível entrar. Confira o código da equipe, o usuário e a senha.';

  @override
  String get homeTitle => 'Início';

  @override
  String get homeEmptyTitle => 'Sua temporada começa aqui';

  @override
  String get homeEmptyBody =>
      'Crie uma tarefa ou registre um teste para preencher este painel.';

  @override
  String get team => 'Equipe';

  @override
  String get addStudent => 'Adicionar aluno';

  @override
  String get displayName => 'Nome completo';

  @override
  String get tempPassword => 'Senha temporária (mín. 8 caracteres)';

  @override
  String get create => 'Criar conta';

  @override
  String get cancel => 'Cancelar';

  @override
  String get studentCreated =>
      'Conta criada. O aluno deve trocar a senha no primeiro acesso.';

  @override
  String get createStudentFailed =>
      'Não foi possível criar a conta. O usuário pode já existir.';

  @override
  String get teamEmptyTitle => 'Nenhum membro ainda';

  @override
  String get teamEmptyBody => 'Adicione o primeiro aluno para começar.';

  @override
  String get roleCoach => 'Coach';

  @override
  String get roleMentor => 'Mentor';

  @override
  String get roleCaptain => 'Capitão';

  @override
  String get roleMember => 'Membro';

  @override
  String get roleGuest => 'Convidado';
}
