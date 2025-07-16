int pivotIndex(List<int> nums) {
  int totalSum = nums.reduce((a, b) => a + b);
  int leftSum = 0;

  for (int i = 0; i < nums.length; i++) {
    int rightSum = totalSum - leftSum - nums[i];
    if (leftSum == rightSum) {
      return i;
    }
    leftSum += nums[i];
  }

  return -1;
}

void main() {
  print(pivotIndex([1, 7, 3, 6, 5, 6])); // 출력: 3
  print(pivotIndex([1, 2, 3]));          // 출력: -1
  print(pivotIndex([2, 1, -1]));         // 출력: 0
}
