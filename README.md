#  Dart Console Shopping Mall

콘솔에서 실행되는 간단한 쇼핑몰 애플리케이션입니다. 사용자가 상품을 조회하고 장바구니에 담고, 총 금액을 확인한 뒤 종료할 수 있도록 구성되어 있습니다.

##  기능 소개

- **상품 목록 보기**: 미리 정의된 상품들의 이름과 가격을 조회할 수 있습니다.
- **장바구니 담기**: 상품명을 입력하면 수량과 함께 장바구니에 담깁니다.
- **장바구니 조회**: 담긴 상품 목록과 총 금액을 확인할 수 있습니다.
- **장바구니 비우기**: 사용자 선택에 따라 장바구니를 비울 수 있습니다.
- **종료**: 안전한 확인 절차를 거쳐 프로그램을 종료합니다.

##  사용 기술

- Dart 언어
- 콘솔 입력/출력 (`stdin`, `stdout`)
- `Future.delayed`로 사용자 경험 개선
- 클래스 기반 OOP 설계 (`Product`, `ShoppingMall`, `CartItem` 등)

##  경로
- [text](bin/consol_shop)

## 실행 방법 
- 터미널에서 dart run bin/consol_shop/dart_consol_shop.dart

 -----------------------------------------------------------------------------

#  Dart gaim

콘솔에서 실행되는 RPG 게임 애플리케이션입니다.
캐릭터 속성과 몬스터를 TXT 파일에 CSV 형식으로 기입된 정보를 불러와 실행됩니다.
게임 종료시, 승패여부를 저장 할 수 있습니다.

##  기능 소개

- Palyer 이름은 콘솔에서 입력받습니다.
    (한글은 자음 모음만 입력하면 실행이 안되도록 되어있습니다.)
- Player의 속성은 'characters.txt'에서 불러옵니다.
- Monster의 정보는 'monster.txt' 에서 불러옵니다.
- 게임을 진행중에 몬스터를 모두 잡지않고 중도 포기하면 '패배'로 간주됩니다.
- 몬스터를 모두 이기거나, 중도 포기로 게임을 종료할때 승패 정보 저장할지 확인 합니다.
- 게임의 승패 정보를 저장하면, 'gaim_results.txt'파일에 저장됩니다.

- 필수만 진행한 상태
- (추가) Player가 방어를 선택 후 monster가 공격하면 공격한 데미지는 monster에게 적용되고,
         Player는 monster의 데미지만큼의 hp를 받습니다. 

##  사용 기술

- **Dart (Console I/O)**: 사용자 입력 및 출력 처리 (`stdin.readLineSync()`, `stdout.write()`)를 통해 텍스트 기반 게임 인터페이스 구현
- **Control Flow (조건문 & 반복문)**: `if-else`, `while`, `break`, `continue` 문을 사용해 전투 흐름과 사용자 응답 처리
- **String Handling**: `.toLowerCase()`, `.trim()` 등을 활용해 사용자 입력 정규화 및 검증
- **Regular Expressions (정규식)**: `RegExp`를 사용해 입력값에서 유효 문자(한글, 영문 등) 판별
- **File I/O**: `File().writeAsStringSync()` 메서드를 통해 게임 결과 파일 저장 기능 구현
- **UTF-8 Encoding**: `stdin.readLineSync(encoding: utf8)`을 통해 다국어 입력 처리 안정화

##  파일 경로 
- [text](bin/gaim)

## 실행 방법 
- 터미널에서 dart run bin/gaim/dart_gaim.dart




