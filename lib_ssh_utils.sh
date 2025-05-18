#!/bin/bash
# lib_ssh_utils.sh (Updated)

SSH_DIR="$HOME/.ssh"
BACKUP_DIR="$HOME/Downloads/ssh_key_backup"

ensure_authorized_keys() {
  mkdir -p "$SSH_DIR"
  touch "$SSH_DIR/authorized_keys"
  chmod 700 "$SSH_DIR"
  chmod 600 "$SSH_DIR/authorized_keys"
}

generate_ssh_key() {
  ensure_authorized_keys
  base_name="id_rsa"
  keyname="$base_name"
  i=1
  while [[ -e "$SSH_DIR/$keyname" || -e "$SSH_DIR/$keyname.pub" ]]; do
    keyname="${base_name}_$i"
    ((i++))
  done
  keypath="$SSH_DIR/$keyname"
  ssh-keygen -t rsa -b 4096 -f "$keypath"
  ensure_authorized_keys
}

list_ssh_keys() {
  echo "===== 공개 키 리스트 (전체 경로 포함) ====="
  find "$SSH_DIR" -type f -name "*.pub"
}

delete_ssh_key() {
  echo "===== 삭제 가능한 공개 키 리스트 ====="
  keys=($(find "$SSH_DIR" -type f -name "*.pub"))
  select pubkey in "${keys[@]}"; do
    if [[ -z "$pubkey" ]]; then
      echo "잘못된 선택입니다."
      return
    fi
    privkey="${pubkey%.pub}"
    pubkey_content=$(<"$pubkey")

    echo "🔍 authorized_keys에서 해당 키 내용 제거 중..."
    if [[ -f "$SSH_DIR/authorized_keys" ]]; then
      grep -vFx "$pubkey_content" "$SSH_DIR/authorized_keys" > "$SSH_DIR/authorized_keys.tmp" && \
      mv "$SSH_DIR/authorized_keys.tmp" "$SSH_DIR/authorized_keys"
      echo "✔ authorized_keys에서 해당 키 제거 완료."
    fi

    rm -f "$pubkey" "$privkey"
    echo "삭제 완료: $pubkey"
    break
  done
}

add_key_to_authorized_keys() {
  echo "===== 추가 가능한 공개 키 리스트 ====="
  keys=($(find "$SSH_DIR" -type f -name "*.pub"))
  select keyfile in "${keys[@]}"; do
    if [[ -z "$keyfile" ]]; then
      echo "잘못된 선택입니다."
      return
    fi
    pubkey_content=$(<"$keyfile")
    if grep -Fxq "$pubkey_content" "$SSH_DIR/authorized_keys"; then
      echo "이미 등록된 키입니다."
    else
      echo "$pubkey_content" >> "$SSH_DIR/authorized_keys"
      echo "authorized_keys에 추가 완료."
    fi
    break
  done
}

check_ssh_permissions() {
  chmod 700 "$SSH_DIR"
  chmod 600 "$SSH_DIR"/*
  echo "퍼미션이 수정되었습니다."
}

backup_ssh_keys() {
  mkdir -p "$BACKUP_DIR"
  echo "🔒 SSH 키를 다음 위치에 백업합니다: $BACKUP_DIR"
  tar -czf "$BACKUP_DIR/ssh_key_backup_$(date +%Y%m%d_%H%M%S).tar.gz" -C "$SSH_DIR" . && \
    echo "백업 성공." || echo "백업 실패."
}

restore_ssh_keys() {
  echo "===== 복원 가능한 백업 리스트 ====="
  files=($(ls -t "$BACKUP_DIR"/*.tar.gz 2>/dev/null))
  if [[ ${#files[@]} -eq 0 ]]; then
    echo "복원 가능한 백업이 없습니다."
    return
  fi
  select file in "${files[@]}"; do
    if [[ -z "$file" ]]; then
      echo "상위 메뉴로 돌아갑니다."
      return
    fi
    tar -xzf "$file" -C "$SSH_DIR"
    echo "복원이 완료되었습니다."
    break
  done
}
