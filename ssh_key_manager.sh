#!/bin/bash
# ssh_key_manager.sh (Main Script)

# lib 파일 포함
source "$(dirname "$0")/lib_ssh_utils.sh"

show_menu() {
  echo "===== SSH 키 관리 메뉴 ====="
  echo "1. SSH 키 생성"
  echo "2. 공개 키 리스트 보기"
  echo "3. SSH 키 삭제"
  echo "4. authorized_keys에 공개 키 추가"
  echo "5. 퍼미션 점검 및 수정"
  echo "6. SSH 키 백업"
  echo "7. SSH 키 복원"
  echo "0. 종료"
}

while true; do
  show_menu
  read -rp "메뉴 번호를 선택하세요: " choice
  case $choice in
    1) generate_ssh_key ;;
    2) list_ssh_keys ;;
    3) delete_ssh_key ;;
    4) add_key_to_authorized_keys ;;
    5) check_ssh_permissions ;;
    6) backup_ssh_keys ;;
    7) restore_ssh_keys ;;
    0) echo "종료합니다."; exit 0 ;;
    *) echo "잘못된 입력입니다. 다시 선택해주세요." ;;
  esac
  echo ""
done
