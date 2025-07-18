String gcdOfStrings(String str1, String str2) {
  // 두 문자열을 이어붙였을 때 결과가 같아야 공약수 존재
  if (str1 + str2 != str2 + str1) {
    return "";
  }

  // 최대공약수 함수 (정수)
  int gcd(int a, int b) {
    while (b != 0) {
      int temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  int lenGCD = gcd(str1.length, str2.length);
  return str1.substring(0, lenGCD);
}

void main() {
  print(gcdOfStrings("ABCABC", "ABC"));      // 출력: ABC
  print(gcdOfStrings("ABABAB", "ABAB"));      // 출력: AB
  print(gcdOfStrings("LEET", "CODE"));        // 출력: ""
  print(gcdOfStrings("ABABABAB", "ABAB"));    // 출력: ABAB
}
