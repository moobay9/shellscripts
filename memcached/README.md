シェルスクリプトから使う memchaced
===============

## 使い方
10行目の MEMHOST に memcached のホスト名を入れてください 
注意：現状では複数のホストには対応しておりません。 

## 設定
`MEMHOST=HOGEHOGE`
HOGEHOGE を適切な memcached のホスト名に変更する

## コマンド
保存：memcached.sh save <key> <val> <time(sec)>
取得：memcached.sh get  <key>
削除：memcached.sh del  <key>
