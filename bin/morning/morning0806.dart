bool isSubsequence(String s, String t) {
  int i = 0; // s의 인덱스
  for (int j = 0; j < t.length; j++) {
    if (i < s.length && s[i] == t[j]) {
      i++;
    }
  }
  return i == s.length;
}
void main() {
  print(isSubsequence("abc", "ahbgdc")); // true
  print(isSubsequence("axc", "ahbgdc")); // false
  print(isSubsequence("", "ahbgdc"));    // true
  print(isSubsequence("abc", ""));       // false
}