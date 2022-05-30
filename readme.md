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
### rockylinuxのdesktopを動かしてみる
### hub → image → コンテナ → コンテナレイヤー追加 → 新しいimage公開
- imageのダウンロードはdocker pull
- docker pull rockylinux:8.5
- imageからコンテナを作成 run時にimageがなかったら自動的にpullされるのでpullの必要性?
- #### [docker run のオプション関連](https://scrapbox.io/llminatoll/docker_run%E3%81%AE%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3%E3%81%84%E3%82%8D%E3%81%84%E3%82%8D)
- docker run -it rockylinux:8.5
  - -i オプション コンテナ内でシェル操作が出来るようにする
    - コンテナ内に入る docker container exec -it コンテナ名||ID bash
    - -i オプションを付けずに入るとlsコマンドを打っても結果を返さない
  - -t オプション [tty](https://qiita.com/toshihirock/items/22de12f99b5c40365369)
    - ターミナルにはログイン時にそれぞれ別のttyが割り当てられている
    -
    - psコマンド ターミナルごとに ps bashなどのプロセスが行われていてPIDは別の番号が割り当てられている
    - cmd を
- imageは読み取りコンテナ内でモジュールなどを追加したら に反映されて保存される

