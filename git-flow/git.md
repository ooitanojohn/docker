# git remote一覧 コマンド取得

- git fetch
- git br -a
- co 出来る git co br_name
- mg も可


## [git-flow 導入](https://qiita.com/ueueue0217/items/274fba0dff12d1e124b9)
[こちらも](https://qiita.com/azusanakano/items/c5f021497d8f69c00e51)
sudo apt-get install git-flow
git flow init


開発終了時 flow br finish cmdで
featureからdevelopにマージ,ブランチ削除、developブランチへcoしてくれる

Feature branches? [feature/]
Bugfix branches? [bugfix/]
Release branches? [release/]
Hotfix branches? [hotfix/]
Support branches? [support/]
Version tag prefix? []
Hooks and filters directory? [/home/ooitanojohn/docker/.git/hooks]

Switched to a new branch 'feature/lamp'

Summary of actions:
- A new branch 'feature/lamp' was created, based on 'develop'
- You are now on branch 'feature/lamp'

Now, start committing on your feature. When done, use:

     git flow feature finish lamp


Switched to branch 'develop'
Updating 33a135a..f520dad
Fast-forward
 git-flow/.gitconfig | 11 +++++++++++
 git-flow/git.md     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 git.md              | 19 -------------------
 3 files changed, 57 insertions(+), 19 deletions(-)
 create mode 100644 git-flow/.gitconfig
 create mode 100644 git-flow/git.md
 delete mode 100644 git.md
Deleted branch feature/lamp (was f520dad).

Summary of actions:
- The feature branch 'feature/lamp' was merged into 'develop'
- Feature branch 'feature/lamp' has been locally deleted
- You are now on branch 'develop'



     ・他の人により更新されたリモートのdevelopブランチを、ローカルのdevelopブランチに反映する場合（随時）

$ git checkout develop
$ git pull origin develop
・開発したfeatureブランチ（sample）をリモートへプッシュする場合

$ git flow feature publish sample
・他の人が開発したfeatureブランチ（sample）をローカルにプルする場合

$ git flow feature track sample


# ひとまず 安定環境master 開発develop local作業featureとかでいいかも