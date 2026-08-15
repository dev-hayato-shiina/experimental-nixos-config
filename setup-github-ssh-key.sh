#!/usr/bin/env zsh

SSH_DIR="$HOME/.ssh"

KEY_PATH_DEV_HAYATO_SHIINA="${SSH_DIR}/dev-hayato-shiina-key"
KEY_PATH_SHEENA_DEVELOP="${SSH_DIR}/sheena-develop-key"
KEY_PATH_SSH_HAYATO_SHIINA="${SSH_DIR}/ssh-hayato-shiina"

BW_ITEM_ID_DEV_HAYATO_SHIINA="24d853e0-895b-4c88-835c-b3ff01315dc6"
BW_ITEM_ID_SHEENA_DEVELOP="92ade4ad-1253-4345-aaf6-b3ff0131ce58"
BW_ITEM_ID_SSH_HAYATO_SHIINA="f1b229e8-f064-4570-8ce2-b42100e37de0"

# Bitwarden セッション確認
if [[ -z "$BW_SESSION" ]]; then
  echo "Bitwardenのセッション情報を取得します"
  export BW_SESSION=$(bw unlock --raw)
  if [[ -z "$BW_SESSION" ]]; then
    echo "ログインをしてください"
    bw login
    echo "Bitwardenのセッション情報を取得します"
    export BW_SESSION=$(bw unlock --raw)
  fi
fi

# 同期
echo "Bitwarden を同期中..."
bw sync --session "$BW_SESSION"

# === dev-hayato-shiina ===

# 秘密鍵取得
PRIVATE_KEY=$(bw get item "$BW_ITEM_ID_DEV_HAYATO_SHIINA" --session "$BW_SESSION" \
  | jq -r '.notes')

if [[ -z "$PRIVATE_KEY" || "$PRIVATE_KEY" == "null" ]]; then
  echo "秘密鍵の取得に失敗しました（dev-hayato-shiina）"
  exit 1
fi

# 配置
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

echo "$PRIVATE_KEY" > "$KEY_PATH_DEV_HAYATO_SHIINA"
chmod 600 "$KEY_PATH_DEV_HAYATO_SHIINA"
echo "秘密鍵を配置しました: $KEY_PATH_DEV_HAYATO_SHIINA"

# 動作確認
ssh -T dev-hayato-shiina

# パスフレーズのポップアップが表示されず、止まってしまう場合は、以下のコマンドでパスフレーズを空にして、再実行してください。
# ssh-keygen -p -f ~/.ssh/dev-hayato-shiina-key

# =========================

# === sheena-develop ===

# 秘密鍵取得
PRIVATE_KEY=$(bw get item "$BW_ITEM_ID_SHEENA_DEVELOP" --session "$BW_SESSION" \
  | jq -r '.notes')

if [[ -z "$PRIVATE_KEY" || "$PRIVATE_KEY" == "null" ]]; then
  echo "秘密鍵の取得に失敗しました（sheena-develop）"
  exit 1
fi

# 配置
echo "$PRIVATE_KEY" > "$KEY_PATH_SHEENA_DEVELOP"
chmod 600 "$KEY_PATH_SHEENA_DEVELOP"
echo "秘密鍵を配置しました: $KEY_PATH_SHEENA_DEVELOP"

# 動作確認
ssh -T sheena-develop

# パスフレーズのポップアップが表示されず、止まってしまう場合は、以下のコマンドでパスフレーズを空にして、再実行してください。
# ssh-keygen -p -f ~/.ssh/sheena-develop-key

# ======================

# === ssh-hayato-shiina ===

# 秘密鍵取得
PRIVATE_KEY=$(bw get item "$BW_ITEM_ID_SSH_HAYATO_SHIINA" --session "$BW_SESSION" \
  | jq -r '.notes')

if [[ -z "$PRIVATE_KEY" || "$PRIVATE_KEY" == "null" ]]; then
  echo "秘密鍵の取得に失敗しました（ssh-hayato-shiina）"
  exit 1
fi

# 配置
echo "$PRIVATE_KEY" > "$KEY_PATH_SSH_HAYATO_SHIINA"
chmod 600 "$KEY_PATH_SSH_HAYATO_SHIINA"
echo "秘密鍵を配置しました: $KEY_PATH_SSH_HAYATO_SHIINA"

# =========================
