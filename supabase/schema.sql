-- PIFIFY cloud library
-- Run this script in Supabase Dashboard > SQL Editor.
create table if not exists public.pifify_library (
  user_id uuid primary key references auth.users(id) on delete cascade,
  playlists jsonb not null default '[]'::jsonb,
  favorites jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.pifify_library enable row level security;

drop policy if exists "Users can read their own PIFIFY library" on public.pifify_library;
create policy "Users can read their own PIFIFY library"
  on public.pifify_library for select to authenticated
  using (auth.uid() = user_id);

drop policy if exists "Users can insert their own PIFIFY library" on public.pifify_library;
create policy "Users can insert their own PIFIFY library"
  on public.pifify_library for insert to authenticated
  with check (auth.uid() = user_id);

drop policy if exists "Users can update their own PIFIFY library" on public.pifify_library;
create policy "Users can update their own PIFIFY library"
  on public.pifify_library for update to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);


-- PIFIFY user profiles
create table if not exists public.pifify_profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null default '' check (char_length(display_name) <= 30),
  avatar_url text not null default '',
  updated_at timestamptz not null default now()
);
alter table public.pifify_profiles enable row level security;
drop policy if exists "Users can read their own PIFIFY profile" on public.pifify_profiles;
create policy "Users can read their own PIFIFY profile"
  on public.pifify_profiles for select to authenticated
  using (auth.uid() = user_id);
drop policy if exists "Users can insert their own PIFIFY profile" on public.pifify_profiles;
create policy "Users can insert their own PIFIFY profile"
  on public.pifify_profiles for insert to authenticated
  with check (auth.uid() = user_id);
drop policy if exists "Users can update their own PIFIFY profile" on public.pifify_profiles;
create policy "Users can update their own PIFIFY profile"
  on public.pifify_profiles for update to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
