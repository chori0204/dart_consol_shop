class Solution {
  int singleNumber(List<int> nums) {
    int result = 0;

    // Dart에서는 for-each는 이렇게 씁니다
    for (int num in nums) {
      result ^= num;  // XOR 연산: 같은 숫자는 상쇄되고, 하나만 남음
    }

    return result;
  }
}
