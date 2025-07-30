List<int> rotate(List<int> nums, int k) {
  int n = nums.length;
  if (n == 0 || k % n == 0) return nums;

  k = k % n;

  List<int> rotated = [];
  rotated.addAll(nums.sublist(n - k));
  rotated.addAll(nums.sublist(0, n - k));
  
  return rotated;
}

void main() {
  print(rotate([1, 2, 3, 4, 5, 6, 7], 3)); // 출력: [5, 6, 7, 1, 2, 3, 4]
  print(rotate([-1, -100, 3, 99], 2));    // 출력: [3, 99, -1, -100]
}