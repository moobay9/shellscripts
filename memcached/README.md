シェルスクリプトから使う memchaced
===============

# 使い方
10行目の MEMHOST に memcached のホスト名を入れてください
注意：現状では複数のホストには対応しておりません。
MEMHOST=HOGEHOGE


保存：memcached.sh save <key> <val> <time(sec)>
取得：memcached.sh get  <key>
削除：memcached.sh del  <key>