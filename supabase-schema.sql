-- Run this in your Supabase project's SQL editor to create the vocab table.
-- Matches the entry shape written by vocab-book.js in the extension.

create table if not exists vocab_entries (
  id text primary key,
  word text not null,
  reading text,
  language text not null check (language in ('ja', 'en')),
  meaning text,
  context text,
  "videoTitle" text,
  status text not null default 'learning' check (status in ('learning', 'mastered')),
  "masteredOrder" integer,
  "createdAt" bigint not null
);

-- Allow the extension and the mobile page (both using the anon key) to
-- read and write. Since this is a single-user personal vocab book with no
-- auth layer, RLS is left open — do not put anything sensitive in here,
-- and consider adding real auth if you ever share the anon key publicly.
alter table vocab_entries enable row level security;

create policy "Allow all access with anon key"
  on vocab_entries
  for all
  using (true)
  with check (true);
