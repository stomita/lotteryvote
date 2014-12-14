lotteryvote
===========

次世代選挙投票支援システム「LotteryVote」

### ChallengePost

http://jphack2014.challengepost.com/submissions/30740-lotteryvote

### デモURL

https://lotteryvote-developer-edition.ap0.force.com/one/one.app

username: isuzuki@member.sfhack2014.stomita.org
password: sfhack2014

### ビルド方法

#### 静的リソースのビルド

前提：Node.js (npm), Grunt, Bowerはインストール済み

```bash
$ cd {{ LotteryVoteソースコードを展開したディレクトリ }}/web
$ npm install
$ bower install
$ grunt build
```

#### Force.com パッケージの配布

前提：Apache AntおよびForce.com移行ツールはセットアップ済み

```bash
$ cd {{ LotteryVoteソースコードを展開したディレクトリ }}/force
$ cp build.properties.sample build.properties
$ vi build.properties # Salesforce管理者として接続するための接続情報を設定する

...

$ ant deploy
```

#### Salesforce Communityの設定

Salesforceのヘルプに従ってコミュニティの設定を行う

