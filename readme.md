# docker復習

## 現在の環境
- wsl の ubuntuに docker-ce docker-compose が入った状態
### docker version
| Client:       | Docker Engine - Community |
| ------------- | ------------------------- |
| Version:      | 20.10.12                  |
| API version:  | 1.41                      |
| Go version:   | go1.16.12                 |
| Git commit:   | e91ed57                   |
| Built:        | Mon Dec 13 11:45:33 2021  |
| OS/Arch:      | linux/amd64               |
| Context:      | default                   |
| Experimental: | true                      |
 - docker-compose version
### docker-compose version
- docker-compose version 1.29.2, build 5becea4c
- docker-py version: 5.0.0
- CPython version: 3.7.10
- OpenSSL version: OpenSSL 1.1.0l  10 Sep 2019

### docker コンテナと imageの掃除
- docker rm continer ID
- docker rmi `docker images -a`
## docker とは ubuntuがホストos Docker Engene = ce そこにコンテナがあって名前空間でプロセスの分離をしている + vagrantなどより軽量に動く

### image とは コンテナを起動するのに必要な設定ファイル
- imageはコンテナの元
- 常駐させたいコンテナはmysql
- image のtag とは alpine(軽量なlinux os)など
- tag名を指定しなければ latestタグが使用される
- nginx:1.14-perl

## Docker hubから 各imageを取得してみる
<!-- ### rockylinuxのdesktopを動かしてみる →  -->
### apache + php レイヤーが含まれる imageを入れる
- ubuntu ver 確認 lsb_release -a
- アーキテクチャ arch
## [docker hub pull時のアーキテクチャは自動選択される (自分で選択する事も出来るが)](https://dev.classmethod.jp/articles/docker-multi-architecture-image/)
## [tagのlinux ディストリビューション種類](https://prograshi.com/platform/docker/docker-image-tags-difference/)
- Dockerイメージの主なタグ一覧 参照 (debian使ったことないから何とも言えない..)
- 勉強も兼ねてるのでslim かalpineを選択
- slimないalpineある
- docker pull php:8.1-apache にした
### hub → image → コンテナ → コンテナレイヤー追加 → 新しいimage公開
- imageのダウンロードはdocker pull
- docker pull rockylinux:8.5
- imageからコンテナを作成 run時にimageがなかったら自動的にpullされるのでpullの必要性?

- #### [docker run のオプション関連](https://scrapbox.io/llminatoll/docker_run%E3%81%AE%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3%E3%81%84%E3%82%8D%E3%81%84%E3%82%8D)
<!-- - docker run -it rockylinux:8.5 --> // container は省略してかける
- docker run -it php:8.1-apache
  - -i オプション コンテナ内でシェル操作が出来るようにする
    - コンテナ内に入る docker exec -it コンテナ名 bash
    - -i オプションを付けずに入るとlsコマンドを打っても結果を返さない
  - -t オプション [tty](https://qiita.com/toshihirock/items/22de12f99b5c40365369)
    - ターミナルにはログイン時にそれぞれ別のttyが割り当てられている
    - -t オプションを付けずに入るとコンテナに入ってはいそうだが、ホストに出力されていない
    - psコマンド ターミナルごとに ps bashなどのプロセスが行われていてPIDは別の番号が割り当てられている
  - name オプション コンテナに名前をつけれる
  - d オプション バックグラウンドで実行(当分使わない)
  - p オプション [ポートフォワードする](https://qiita.com/tatsuo-iriyama/items/e4bf2404411343116e3e)
  - v オプション [コンテナ内に入るとわかるが/var/www/htmlディレクトリがありここのphpファイルを読み取るのでコンテナ外の現在のフォルダ${PWD}とリンクさせている](https://gray-code.com/blog/php-on-docker/)
- imageは読み取りコンテナ内でモジュールなどを追加したら に反映されて保存される
### apache だけportフォワードなしで立ち上げてみた
  - ooitanojohn@win10ohs00727:~/docker$ docker exec -it apache bash
  - root@58aaf06c300b:/usr/local/apache2# ls
  - bin  build  cgi-bin  conf  error  htdocs  icons  include  logs  modules
  - root@58aaf06c300b:/usr/local/apache2# cd htdocs/
  - root@58aaf06c300b:/usr/local/apache2/htdocs# ls
  - index.html
  - root@58aaf06c300b:/usr/local/apache2/htdocs# cat index.html
  - <html><body><h1>It works!</h1></body></html>
  - root@58aaf06c300b:/usr/local/apache2/htdocs#
- **htdocs**見ると安心するな、実家に帰ってきた気分
- curlでポート疎通確認
  - apt-get update
  - apt-get install curl
  - curl http://localhost:80
  - コンテナ内では<html><body><h1>It works!</h1></body></html> が返ってくるが、コンテナ外ではooitanojohn@win10ohs00727:~/docker$ curl http://localhost:80
curl: (7) Failed to connect to localhost port 80: Connection refused となる

### docker imageからコンテナをビルドする
- docker image build -t

### docker containerを実行する
- #### [ここまでDockerfile 記述してみた]()


### [docker cmd 一覧 お気に入り](https://beyondjapan.com/blog/2016/08/docker-command-reverse-resolutions/#docker)
