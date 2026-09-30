-- Cole no SQL Editor e execute. Tudo é desfeito no final.
-- Sucesso = erro com a mensagem "TESTES OK".
do $$
declare a uuid := gen_random_uuid(); b uuid := gen_random_uuid();
        ta uuid; tb uuid; n int;
begin
  insert into auth.users (id, instance_id, aud, role, email) values
    (a, '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', 'a@rls.test'),
    (b, '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', 'b@rls.test');
  insert into teams (code, name) values ('rlsa', 'A') returning id into ta;
  insert into teams (code, name) values ('rlsb', 'B') returning id into tb;
  insert into members (team_id, user_id, role) values (ta, a, 'mentor'), (tb, b, 'mentor');

  perform set_config('request.jwt.claims',
    json_build_object('sub', a, 'role', 'authenticated')::text, true);
  set local role authenticated;

  select count(*) into n from teams;
  if n <> 1 then raise exception 'FALHA: A vê % equipes (esperado 1)', n; end if;

  select count(*) into n from members where team_id = tb;
  if n <> 0 then raise exception 'FALHA: A vê membros da equipe B'; end if;

  begin
    insert into seasons (team_id, name) values (tb, 'x');
    raise exception 'FALHA: A conseguiu escrever na equipe B';
  exception when insufficient_privilege then
    null; -- esperado: o RLS bloqueou
  end;

  insert into seasons (team_id, name) values (ta, '2026-2027'); -- A pode na própria equipe

  raise exception 'TESTES OK (alterações desfeitas)';
end $$;
