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

  @override
  String get team => 'Team';

  @override
  String get addStudent => 'Add student';

  @override
  String get displayName => 'Full name';

  @override
  String get tempPassword => 'Temporary password (min. 8 characters)';

  @override
  String get create => 'Create account';

  @override
  String get cancel => 'Cancel';

  @override
  String get studentCreated =>
      'Account created. The student must change the password on first sign-in.';

  @override
  String get createStudentFailed =>
      'Could not create the account. The username may already be taken.';

  @override
  String get teamEmptyTitle => 'No members yet';

  @override
  String get teamEmptyBody => 'Add your first student to get started.';

  @override
  String get roleCoach => 'Coach';

  @override
  String get roleMentor => 'Mentor';

  @override
  String get roleCaptain => 'Captain';

  @override
  String get roleMember => 'Member';

  @override
  String get roleGuest => 'Guest';

  @override
  String get changePasswordTitle => 'Choose a new password';

  @override
  String get changePasswordBody =>
      'You signed in with a temporary password. Set your own to continue.';

  @override
  String get newPassword => 'New password (min. 8 characters)';

  @override
  String get confirmPassword => 'Confirm new password';

  @override
  String get savePassword => 'Save password';

  @override
  String get passwordTooShort => 'Use at least 8 characters.';

  @override
  String get passwordsDontMatch => 'The passwords do not match.';

  @override
  String get changePasswordFailed =>
      'Could not change the password. Try again.';

  @override
  String get signOut => 'Sign out';
}
