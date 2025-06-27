import 'dart:convert';
import 'dart:io';
import 'dart:async';

void main() async {
  //종료 전에 일정 시간 동안 대기하거나 카운트다운을 보여주고 싶다면 async , Dart의 Timer 또는 Future.delayed
  ShoppingMall mall = ShoppingMall();
  mall.printAction();  // 쇼핑몰 기능을 조회하는 메서드
  
  while (true) {
    String? input = stdin.readLineSync(encoding: utf8)?.trim();
    if (input != null) {
      switch (input) {
        case '1' :
          print('상품 목록을 조회합니다...');
          mall.showProducts(); //showProducts() 상품목록을 출력하는 메서드
          await Future.delayed(Duration(seconds: 1)); // 1초 대기
          mall.printAction(); // printAction() 쇼핑몰 기능을 조회하는 메서드
          break;
        case '2' :
          mall.addToCart(); //addToCart() 상품을 장바구니에 담는 메서드
          await Future.delayed(Duration(seconds: 1)); // 1초 대기       
          break;
        case '3' :
          mall.showToCart();//showTocal()  장바구니에 담긴 상품의 총 가격
          await Future.delayed(Duration(seconds: 1)); // 1초 대기
          break;
        case '4' :
          print('정말 종료하시겠습니까 ? (yes :5 )');          
          String? close = stdin.readLineSync(encoding: utf8)?.trim();          
          if(close =='5'){
            print('프로그램을 종료합니다.');
            await Future.delayed(Duration(seconds: 1)); // 1초 대기
            print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
            await Future.delayed(Duration(seconds: 1)); // 1초 대기
            exit(0); // 프로그램 종료
          }else {
            print('종료가 취소되었습니다.');
            await Future.delayed(Duration(seconds: 1)); // 1초 대기
            mall.printAction(); // printAction() 쇼핑몰 기능을 조회하는 메서드
          }  
        default:
          print('알 수 없는 명령어입니다. 다시 확인해주세요 ');
          await Future.delayed(Duration(seconds: 1));
          mall.printAction();

      }
    }
  }
}

class ShoppingMall {  //쇼핑몰을 정의하기 위한 클래스
  Map<int,String> shopAction ={ //쇼핑몰 기능 
    1:'상품 목록 보기',
    2:'장바구니에 담기',
    3:'장바구니에 담긴 상품의 총 가격 보기',
    4:'프로그램 종료'
    };

   void printAction() {   
     print('------------------------------------------------------------------------------------------------');
     int actionIndex = 0 ;
      shopAction.forEach((aNum,aText) {
        if (actionIndex < shopAction.length-1){
           stdout.write('[$aNum] $aText / '); 
           actionIndex++;
           return;
        }else {
           stdout.write('[$aNum] $aText'); 
           return;
        }

          //문자열을 연결해서 출력하려면, stdout.write() StringBuffer 
          //print()와 달리 자동 줄바꿈 없음
          //stdout.write()는 줄바꿈 없이 출력하는 함수이기 때문에, 
          //줄바꿈을 원할 경우 명시적으로 \n을 추가하거나, **print() 또는 stdout.writeln()**을 사용해야 해요.
      });
     print('\n------------------------------------------------------------------------------------------------');

    }

  //List를 사용하는 이유  Map 보다 동적으로 item을 추가 수정 삭제 할 수있음
  List<Product> catalog = [
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000)
  ];
 
  Map<Product, int> cart = {};  //Map은 키-값 구조이기 때문에 Product를 키로, 수량을 값으로 저장하면 장바구니에 어떤 상품이 몇 개 있는지를 명확하게 표현할 수 있어요.
  
  
  void showProducts() {  //상품 목록을 조회하는 기능 
    print('\n[상품 목록]');
    for (int i = 0; i < catalog.length; i++) {
     print('[${i + 1}] ${catalog[i]}'); // 상품의 번호 추가

   }
  }

  void addToCart() async {
  while (true) {
    stdout.write('\n상품명을 입력하세요 (종료하려면 "m" 입력): ');
    String? itemInput = stdin.readLineSync(encoding: utf8)?.trim();

    if (itemInput == null || itemInput.isEmpty) {
      print('\n상품이 입력되지 않았습니다.');
      await Future.delayed(Duration(seconds: 1));
      showProducts();
      continue;
    }

    if (itemInput.toLowerCase() == 'm') {
      print('\n메뉴로 돌아갑니다.');
      await Future.delayed(Duration(seconds: 1));
      printAction();
      return;
    }

    Product? matched = catalog.firstWhere(
      (product) => product.item == itemInput,
      orElse: () => Product('', 0),
    );

    if (matched.item.isEmpty) {
      print('\n없는 상품입니다. 다시 확인해주세요.');
      showProducts();
      continue;
    }

    print('상품: ${matched.item} / 가격: ${matched.itemprice}원');
    stdout.write('몇 개 담을까요?: ');
    String? itemCount = stdin.readLineSync(encoding: utf8)?.trim();
    int? typeNum = int.tryParse(itemCount ?? '');

    if (typeNum == null || typeNum <= 0) {
      print('\n상품 개수는 1 이상의 숫자로 입력해주세요.');
      continue;
    }

    cart[matched] = (cart[matched] ?? 0) + typeNum;
    print('\n장바구니에 추가됨: ${matched.item} ($typeNum개)');

    print('\n[다음 선택] 장바구니 보기(s) / 쇼핑 계속(g) / 메뉴로 이동(m) / 장바구니 비우기(c)');
    String? menuState = stdin.readLineSync(encoding: utf8)?.trim().toLowerCase();

    switch (menuState) {
      case 's':
        showToCart(); //장바구니 보기(s)
        return;
      case 'g':
        continue; //쇼핑 계속(g)
      case 'm':
        printAction(); //메뉴로 이동(m)
        return;
      case 'c':
        clearCart(); // 장바구니 비우기(c)
        return;
      default:
        errAction(); // 올바르지 않은 입력
        return;
    }
  }
}  

  void showToCart() async { // 장바구니에 담긴 상품의 총가격 보기 
    if (cart.isEmpty) {
      print('\n장바구니가 비어 있어요.');
      await Future.delayed(Duration(seconds: 1)); // 1초 대기    
      print('\n메뉴로 돌아갑니다.');
      printAction(); // 최초메뉴로 이동     
      return; 
    } else {  
      print('\n[장바구니 목록]');
      int total = 0;
      cart.forEach((product, qty) {//장바구니에 담긴 제품 가격       
        int subtotal = product.itemprice * qty;
        print('- ${product.item} x $qty = $subtotal 원');
        total += subtotal;
        });
      print('총 금액은 $total원 입니다.');
      await Future.delayed(Duration(seconds: 1)); // 1초 대기     
      print('\n[다음 선택] 쇼핑 계속(g) / 메뉴로 이동(m) / 장바구니 비우기(c)');
      String? menuState = stdin.readLineSync(encoding: utf8)?.trim().toLowerCase();
      switch (menuState) {
        case 'g':
          addToCart(); //쇼핑 계속
          return;        
        case 'm':
          printAction(); //메뉴로 이동
          return;
        case 'c':
          clearCart(); //장바구니 비우기
          return;
        default:
          errAction(); // 올바르지 않은 입력
          return;
      }
    }
  }//showCart

  void errAction() async {
    print('\n올바르지 않은 선택입니다. 메뉴로 돌아갑니다.');
    await Future.delayed(Duration(seconds: 1)); // 1초 대기     
    printAction();
    return;
  }

  void clearCart() async {  // 장바구니를 비우는 기능 
  print('정말로 장바구니를 모두 비우시겠습니까 ? (예 ,아니오)');
  String? cartClear = stdin.readLineSync(encoding: utf8)?.trim();

  if(cartClear =='아니오'){
    print('취소 되었습니다.');
    return;
  } else if (cartClear =='예'){
    print('장바구니가 모두 비워졌습니다.');
    cart.clear();
    return;
  } else {
    errAction(); // 올바르지 않은 입력
      return;

  }
 
}


} // class ShoppingMall  


class Product{  //상품을 정의하기 위한 Product 클래스
    String item; //상품명
    int itemprice; //상품가격

    Product(this.item, this.itemprice) ;   

    @override
    String toString() => '$item / $itemprice원';
    
  }// Product

class CartItem { //상품을 담기위한 CartItem 클래스 
  Product product;  
  int quantity;
  CartItem(this.product, this.quantity);
  
  
}// CartItem
