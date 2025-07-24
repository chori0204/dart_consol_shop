bool hasUniqueFrequencies(List<int> arr) {
  // 숫자별 빈도를 저장할 맵
  Map<int, int> freqMap = {};

  for (int num in arr) {
    freqMap[num] = (freqMap[num] ?? 0) + 1;
  }

  // 빈도 값만 모아서 중복 체크
  Set<int> freqSet = {};

  for (int count in freqMap.values) {
    if (freqSet.contains(count)) {
      return false; // 같은 빈도가 이미 존재함
    }
    freqSet.add(count);
  }

  return true; // 모든 빈도가 유일함
}

void main() {
  print(hasUniqueFrequencies([1, 2, 2, 1, 1, 3]));        // true
  print(hasUniqueFrequencies([1, 2]));                    // false
  print(hasUniqueFrequencies([-3, 0, 1, -3, 1, 1, 1, -3, 10, 0])); // true
}