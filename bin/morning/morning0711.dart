//14. 가장 긴 공통 접두사(문자열)

class Solution {
  String longestCommonPrefix(List<String> strs) {
    
    if (strs.isEmpty) return "";

    String prefix = strs[0];

    for (int i = 1; i < strs.length; i++) {
      while (!strs[i].startsWith(prefix)) {
        // 접두사가 아니면 접미사 하나씩 제거
        prefix = prefix.substring(0, prefix.length - 1);
        if (prefix.isEmpty) return "";
      }
    }

    return prefix;
  }
}

void main() {
  List<String> strs = ["Flower", "Flow", "Flight"];

  if (!isAlphabetOnly(strs)) {
    print("영문자 이외의 문자가 포함되어 있습니다.");
    return;
  }

  List<String> lowerList = strs.map((s) => s.toLowerCase()).toList();
  Solution solution = Solution();
  print(solution.longestCommonPrefix(lowerList)); // 출력: fl
}


bool isAlphabetOnly(List<String> strs) {
  final RegExp regex = RegExp(r'^[a-zA-Z]+$');
  return strs.every((s) => regex.hasMatch(s));
}

