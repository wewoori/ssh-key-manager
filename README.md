
# 🔐 ssh-key-manager

`ssh-key-manager`는 SSH 키 생성, 백업, 삭제, 등록 등의 작업을 **메뉴 기반**으로 간편하게 수행할 수 있는 쉘 스크립트입니다.  
반복적인 SSH 작업을 자동화하여 실수를 줄이고, 키 관리를 더 쉽게 만들어줍니다.

---

## 🧰 주요 기능 (메뉴 기반 UI)

- 🔑 SSH 키 생성 (RSA/ED25519 등 선택 가능)
- 🗂 키 백업 및 복원
- 📋 authorized_keys 등록 자동화
- ❌ 키 삭제
- 📜 등록된 키 목록 보기
- 💾 자동 경로 감지 및 홈 디렉토리 백업 지원

---

## 🚀 설치 방법 (Installation)

```bash
git clone https://github.com/wewoori/ssh-key-manager.git
cd ssh-key-manager
chmod +x ssh-key-manager.sh

./ssh-key-manager.sh

===========================
 SSH Key Manager (v1.0)
===========================
1. SSH 키 생성
2. 공개 키 리스트 보기
3. SSH 키 삭제
4. authorized_keys에 공개 키 추가
5. 퍼미션 점검 및 수정
6. SSH 키 백업
7. SSH 키 복원
0. 종료
---------------------------
번호를 선택하세요 >

차후 기능성부분은 계속 추가/개선될 예정입니다...


디렉토리 구조체는 다음과 같습니다. 

~/.ssh/
├── id_rsa
├── id_rsa.pub
├── backups/
│   ├── id_rsa_2024-01-01.bak
│   └── id_ed25519_2024-01-01.bak

🧙 제작자
🔧 Shell Script: wewoori

🎯 기획 및 실제 운영자: 당신 😎 (언제든 개선 및 제안을 환영합니다...)

📄 라이선스
MIT License. 자유롭게 사용하고, 수정하고, 배포하셔도 됩니다. 단 상업적 스크립터 도용/재배포등은 금지합니다.

