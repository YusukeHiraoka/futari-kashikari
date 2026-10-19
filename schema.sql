-- ふたりの貸し借りメモ
-- SupabaseのSQL Editorに、このファイル全体を貼り付けてRunしてください。
-- この構成はログインなし・公開URL方式です。テーブルはインターネット上の誰でも
-- 読み書きできます。機密情報は入力しないでください。

create table if not exists public.ledger_entries (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  entry_date date not null default current_date,
  kind text not null check (kind in ('you_paid','partner_paid','partner_repaid','you_repaid')),
  amount bigint not null check (amount > 0),
  note text not null default '' check (char_length(note) <= 180)
);

alter table public.ledger_entries enable row level security;

drop policy if exists "public can read ledger entries" on public.ledger_entries;
drop policy if exists "public can insert ledger entries" on public.ledger_entries;
drop policy if exists "public can update ledger entries" on public.ledger_entries;
drop policy if exists "public can delete ledger entries" on public.ledger_entries;

create policy "public can read ledger entries"
  on public.ledger_entries for select to anon, authenticated using (true);
create policy "public can insert ledger entries"
  on public.ledger_entries for insert to anon, authenticated with check (true);
create policy "public can update ledger entries"
  on public.ledger_entries for update to anon, authenticated using (true) with check (true);
create policy "public can delete ledger entries"
  on public.ledger_entries for delete to anon, authenticated using (true);

grant usage on schema public to anon, authenticated;
grant select, insert, update, delete on public.ledger_entries to anon, authenticated;
