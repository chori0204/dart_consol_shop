void main() {
  int height = 5; // 피라미드 높이

print('\n  좌측 직삼각형 별 ');

  for (int i = 1; i <= height; i++) {
    String stars = '*' * (i);          // 별의 개수
    print(stars);
  }


print('\n  역삼각형 별 ');

//2 역삼각형 별 
  for (int i = 0; i <= height; i++) {
    String stars = '*' * (height - i);          // 별의 개수
    print(stars);
  }


print('\n  우측 직삼각형 별 ');

//3 우측 직삼각형 별 
  for (int i = 1; i <= height; i++) {
    String spaces = ' ' * (height - i); 
    String stars = '*' * (i);          // 별의 개수
    print(spaces+stars);
  }


print('\n  직사각형 별 ');

//4 직사각형 별 
  for (int i = 1; i <= height; i++) {
    //String stars = '*' * (height);          // 별의 개수
    //print(stars);
    // 디버그 모드에서 출력시  단 한 번만 반복돼서 콘솔에 5 *****만 나옵니다.
    //그냥 Run해서 출력해보면 다 나올 수 있어요.
    //디버그모드에서 출력해보고싶을때 아래처럼 작성하면 됩니다.
     print('$i ${'*' * height}');
      // 


  } 


print('\n  피라미드 별 ');
//5 피라미드
  for (int i = 1; i <= height; i++) {
    String spaces = ' ' * (height - i);        // 왼쪽 공백
    String stars = '*' * (2 * i - 1);          // 별의 개수
    print(spaces + stars);
  }
}
