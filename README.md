# ふたりの貸し借りメモ

GitHub Pages + Supabaseで動く、2人用の立て替え・貸し借りメモです。
ログイン・招待リンクは不要で、同じGitHub Pages URLを開くだけで使えます。

## できること
- 「あなたが立て替え・貸した」「相手が立て替え・貸した」の記録
- 返済の記録
- 差額（相手が返す金額 / 自分が返す金額）の自動計算
- 記録の編集・削除
- iPhoneのホーム画面に追加（PWA対応）

## 1. Supabaseアカウントとデータベースを作成
1. https://supabase.com/ を開き、Sign upからアカウントを作成します（GitHubアカウントで登録する方法もあります）。
2. Dashboardで **New project** を選びます。
3. Organization、Project name（例：futari-kashikari）、Database password、Region（近い地域）を設定して作成します。Database passwordは自分で保管し、アプリには入力しません。
4. プロジェクトができたら、左メニューの **SQL Editor** を開き、**New query** を作成します。
5. このZIP内の `schema.sql` の中身を全部コピーして貼り付け、**Run** を押します。

## 2. URLと公開キーを設定
1. Supabase Dashboardの **Project Settings → API Keys**（画面によってはSettings内のAPI欄）を開きます。
2. **Project URL** と **Publishable key**（古い画面では `anon` / `public` key）をコピーします。
3. `config.js` をテキストエディタで開き、次の2行の値を自分のプロジェクトの値に置き換えます。
   - `SUPABASE_URL`
   - `SUPABASE_ANON_KEY`
4. `service_role` keyや`secret` keyは絶対に使わないでください。公開用のPublishable/anon keyを使います。

## 3. GitHubにアップロード
1. GitHubで **New repository** を作成します。例：`futari-kashikari`。GitHub FreeならPublic repositoryにします。
2. リポジトリの **Add file → Upload files** を選びます。
3. ZIPを解凍し、中のファイル（`index.html`、`config.js`、`schema.sql`、`manifest.json`、`icon.svg`、`sw.js`、`README.md`）をまとめてアップロードします。フォルダごとではなく、ファイルがリポジトリ直下に並ぶようにしてください。
4. **Commit changes** を押します。
5. リポジトリの **Settings → Pages** を開き、Build and deploymentのSourceを **Deploy from a branch**、Branchを **main**、Folderを **/(root)** にしてSaveします。
6. 1〜数分待って、Pagesに表示されたURLを開きます。

## 4. 2人で使う
表示された同じURLをあなたと相手のスマホで開くだけです。共有リンクの生成・招待コード・アプリ内ログインは不要です。
iPhoneではSafariの共有ボタン →「ホーム画面に追加」でアプリ風に使えます。

## 大事な注意
このバージョンは「URLを知っている人だけ」ではなく、インターネット上の誰でもデータを閲覧・追加・変更・削除できる設定です。GitHub PagesのURLも公開URLです。ユーザーの希望に合わせてログインなしを優先した簡易版ですが、URLが知られると第三者も触れる可能性があります。銀行情報、住所、パスワードなどは入力しないでください。
`config.js`内のPublishable/anon keyは公開前提のキーです。`service_role` keyは絶対に置かないでください。

Supabase Freeプランは小規模用途には十分なことが多いですが、1週間ほどDB利用が少ないとプロジェクトが自動停止される場合があります。停止したらSupabase DashboardからResumeできます。
