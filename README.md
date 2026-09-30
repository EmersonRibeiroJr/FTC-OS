# FTC OS
Everything your FTC Team needs. Open source (Apache-2.0).

## Rodar
```
flutter pub get && flutter gen-l10n
flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
```
Aplique `supabase/migrations/` na sua instância Supabase.

## Estado (Fase 0, parcial)
Feito: estrutura em 3 camadas, Design System base, i18n (en/pt), login por equipe+usuário, RLS de tenancy, CI.
Pendente: Drift + SyncEngine, Edge Function `create-student`, texto oficial da licença (adicione `LICENSE` Apache-2.0), testes de RLS.
