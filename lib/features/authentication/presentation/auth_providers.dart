import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ftc_os/features/authentication/data/supabase_auth_repository.dart';
import 'package:ftc_os/features/authentication/domain/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => SupabaseAuthRepository(Supabase.instance.client.auth),
);

final signedInProvider = StreamProvider<bool>((ref) async* {
  final repo = ref.watch(authRepositoryProvider);
  yield repo.isSignedIn;
  yield* repo.watchSignedIn();
});
