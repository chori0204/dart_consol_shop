void main() {
  print(findMaxAverage([1, 12, -5, -6, 50, 3], 4)); // 출력: 12.75000
  print(findMaxAverage([5], 1));                   // 출력: 5.00000
}

double findMaxAverage(List<int> nums, int k) {
  int windowSum = 0;

  // 초기 윈도우 합
  for (int i = 0; i < k; i++) {
    windowSum += nums[i];
  }

  int maxSum = windowSum;

  // 슬라이딩 윈도우 이동
  for (int i = k; i < nums.length; i++) {
    windowSum += nums[i] - nums[i - k];
    if (windowSum > maxSum) {
      maxSum = windowSum;
    }
  }

  // 평균 계산 및 반올림
  double average = maxSum / k;
  return double.parse(average.toStringAsFixed(5));
}