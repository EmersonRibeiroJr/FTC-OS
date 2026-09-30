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
}
