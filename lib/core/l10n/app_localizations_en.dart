// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'FTC OS';

  @override
  String get tagline => 'Everything your FTC Team needs.';

  @override
  String get teamCode => 'Team code';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get signIn => 'Sign in';

  @override
  String get signInFailed =>
      'Could not sign in. Check your team code, username and password.';

  @override
  String get homeTitle => 'Home';

  @override
  String get homeEmptyTitle => 'Your season starts here';

  @override
  String get homeEmptyBody =>
      'Create a task or log a test to fill this dashboard.';
}
