-- FTC OS · Fase 0: tenancy, papéis e RLS.
create type member_role as enum ('coach','mentor','captain','member','guest');

create table teams (
  id uuid primary key default gen_random_uuid(),
  code text not null unique,
  name text not null,
  ftc_number text,
  country text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz,
  version int not null default 1
);

create table profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null,
  username text,
  photo_url text,
  locale text not null default 'en',
  must_change_password boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table members (
  id uuid primary key default gen_random_uuid(),
  team_id uuid not null references teams(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  role member_role not null default 'member',
  discipline text,
  specialty text,
  training_hours numeric not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz,
  version int not null default 1,
  unique (team_id, user_id)
);

create table seasons (
  id uuid primary key default gen_random_uuid(),
  team_id uuid not null references teams(id) on delete cascade,
  name text not null,
  game text,
  starts_on date,
  ends_on date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz,
  version int not null default 1
);

create function team_role(t uuid) returns member_role
language sql stable security definer set search_path = public as $$
  select role from members
  where team_id = t and user_id = auth.uid() and deleted_at is null
$$;

create function is_team_member(t uuid) returns boolean
language sql stable security definer set search_path = public as $$
  select team_role(t) is not null
$$;

alter table teams enable row level security;
alter table profiles enable row level security;
alter table members enable row level security;
alter table seasons enable row level security;

create policy teams_read on teams for select using (is_team_member(id));
create policy teams_update on teams for update using (team_role(id) in ('coach','mentor'));

create policy profiles_self on profiles for select using (user_id = auth.uid());
create policy profiles_teammates on profiles for select using (
  exists (select 1 from members a join members b on a.team_id = b.team_id
          where a.user_id = auth.uid() and b.user_id = profiles.user_id));
create policy profiles_update_self on profiles for update using (user_id = auth.uid());

create policy members_read on members for select using (is_team_member(team_id));
create policy members_manage on members for all
  using (team_role(team_id) in ('coach','mentor'))
  with check (team_role(team_id) in ('coach','mentor'));

create policy seasons_read on seasons for select using (is_team_member(team_id));
create policy seasons_write on seasons for all
  using (team_role(team_id) in ('coach','mentor','captain'))
  with check (team_role(team_id) in ('coach','mentor','captain'));
