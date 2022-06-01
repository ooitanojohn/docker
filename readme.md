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
  - `-i` オプション コンテナ内でシェル操作が出来るようにする
    - コンテナ内に入る docker exec -it コンテナ名 bash
    - -i オプションを付けずに入るとlsコマンドを打っても結果を返さない
  - `-t` オプション [tty](https://qiita.com/toshihirock/items/22de12f99b5c40365369)
    - ターミナルにはログイン時にそれぞれ別のttyが割り当てられている
    - `-t` オプションを付けずに入るとコンテナに入ってはいそうだが、ホストに出力されていない
      - `ps`コマンドで確認が出来る ターミナルごとに ps bashなどのプロセスが行われていてPIDは別の番号が割り当てられている
  - -`--name コンテナ名`  オプション コンテナに名前をつけれる
  - `-p 180:80` `ホスト元:コンテナ` オプション [ポートフォワードする](https://qiita.com/tatsuo-iriyama/items/e4bf2404411343116e3e)
  - `-v 作業読み込みファイルがある階層:コンテナ側の読み込んでいる階層` オプション [コンテナ内に入るとわかるが/var/www/htmlディレクトリがありここのphpファイルを読み取るのでコンテナ外の現在のフォルダ${PWD}とリンクさせている](https://gray-code.com/blog/php-on-docker/)
  - d オプション バックグラウンドで実行(当分使わない)
- imageは読み取りコンテナ内でモジュールなどを追加したらに反映されて保存される
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

### apacheに -it -p 180:80 で立ち上げ
- It works! した
### [Dockerfile 記述してみる](https://www.wakuwakubank.com/posts/270-docker-build-image/)
- [せっかくなのでalpine入れてみるw](./Dockerfile)
- docker build -t ph35-apache-alpine .
### [効率的で安産なDockerfileの作り方](https://qiita.com/pottava/items/452bf80e334bc1fee69a#dockerfile-%E3%83%99%E3%82%B9%E3%83%88%E3%83%97%E3%83%A9%E3%82%AF%E3%83%86%E3%82%A3%E3%82%B9)
### Dockerfile からimageを作り、run コマンドでコンテナをビルドする
- docker build -t name // image作成
- docker run

### 各ver.は最新安定版を使用
### alpine導入
  - latestの方がsizeは小さい
  - [alpine:3.15.0](https://ja.wikipedia.org/wiki/Alpine_Linux)
    - docker run -it -p 180:80 --name ph35-alpine alpine:3.15.0
    - **update**
    - apk update && apk upgrade && rm -rf /var/cache/apk/*
    - [imageの軽量化 何故軽量化する？](https://blog.mosuke.tech/entry/2020/07/09/container-image-size/)
  #### docker commit で image sizeの確認
    - docker commit ph35-alpine alpine:3.15.0
    - 5 → update upgrade 16MB → rm cachefile 13.7MB
| REPOSITORY | TAG    | IMAGE ID     | CREATED       | SIZE   |
| alpine     | 3.15.0 | df38f55e2d08 | 6 seconds ago | 13.7MB |
| alpine     | 3.15.0 | 30a755205171 | 2 minutes ago | 16MB   |
| tests_php  | latest | f3dc3e7c43f2 | 4 months ago  | 560MB  |
| mysql      | 8.0    | 5b4c624c7fe1 | 4 months ago  | 519MB  |
| nginx      | latest | 605c77e624dd | 5 months ago  | 141MB  |
| alpine     | <none> | c059bfaa849c | 6 months ago  | 5.59MB |
  #### [image size 見やすいパッケージ dive ](https://dev.classmethod.jp/articles/docker_image_diet_dive/)
### apache + php8.1 + mysql + postgle


### docker system df コンテナ,image,volume一覧と使用サイズが確認できる
  - [volumeとはコンテナ外にあるディレクトリやファイルを格納している phpでいうhtdocsマウント情報](https://qiita.com/wwbQzhMkhhgEmhU/items/7285f05d611831676169)
  - docker volume ls
  - docker volume inspect volume_nameで中身見れるよ
### docker logs
-fオプションをつけることでtail -fと同じように最新のログを追うことができます。
$ docker logs -f eeed701d7b98
1
$ docker logs
### docker containerを実行する
- #### [ここまでDockerfile 記述してみた]()


### [docker cmd まとめ](https://beyondjapan.com/blog/2016/08/docker-command-reverse-resolutions/#docker)
  - #### 削除
    - docker rm -v コンテナ名 // -v で　volumeも削除
    - docker rmi イメージ名
    - [docker volume rm ボリューム名](https://qiita.com/wwbQzhMkhhgEmhU/items/7285f05d611831676169) // volume削除
  - #### hubからimage取得
    - docker pull image:tags
  - #### Dockerfileからimage作成
    - docker build -t イメージ名 Dockerfileの階層
  - #### imageからコンテナ作成
    - docker run -it -p ホスト側のポート:コンテナ側のポート -v ホスト側のディレクトリ:コンテナのディレクトリ --name コンテナ名 image:tag
  - ####

