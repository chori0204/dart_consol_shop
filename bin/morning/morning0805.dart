bool isPalindrome(String s) {
  // 영문자와 숫자만 남기고 소문자로 변환
  String filtered = s
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]'), '');

  // 팰린드롬 확인
  String reversed = filtered.split('').reversed.join('');
  return filtered == reversed;
}

void main() {
  print(isPalindrome("A man, a plan, a canal: Panama")); // true
  print(isPalindrome("race a car")); // false
  print(isPalindrome("12321")); // true
  print(isPalindrome("No 'x' in Nixon")); // true
}