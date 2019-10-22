#!/usr/bin/bash
cd `dirname $0`

# googleドライブの場所を確認
# TODO: 複数アカウントの場合どうなるか
DRIVE=`find /run/user/ -type d -name "google-drive*"`
body="$DRIVE/restarter"

# TODO: 既に登録してあった場合、そのデータを使ってレストアするか上書きするかの確認
if [ -d $body ] then
    rm -fr $body
fi

# 初期登録として上書き処理
cp -r body/ $body

# シンボリックリンクの作成
# TODO: 他のも移行できるように
mkdir -p $body/link
cp -r ~/.ssh $body/link/.ssh
rm -fr ~/.ssh
ln -s $body/link/.ssh ~/.ssh

# 環境変数の追加と更新
echo "export PATH=$body:\$PATH">>~/.zshrc
source ~/.zshrc
