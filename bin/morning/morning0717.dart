int strStr(String haystack, String needle) {
  int hLen = haystack.length;
  int nLen = needle.length;

  if (nLen == 0) return 0; // 빈 문자열은 항상 0번째에 존재

  for (int i = 0; i <= hLen - nLen; i++) {
    if (haystack.substring(i, i + nLen) == needle) {
      return i;
    }
  }

  return -1;
}
void main() {
  print(strStr("sadbutsad", "sad"));     // 출력: 0
  print(strStr("leetcode", "leeto"));    // 출력: -1
  print(strStr("mississippi", "issip")); // 출력: 4
}
