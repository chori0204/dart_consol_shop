bool containsNearbyDuplicate(List<int> nums, int k) {
  Set<int> window = {};

  for (int i = 0; i < nums.length; i++) {
    if (window.contains(nums[i])) {
      return true;
    }

    window.add(nums[i]);

    // 윈도우 크기를 k로 유지
    if (window.length > k) {
      window.remove(nums[i - k]);
    }
  }

  return false;
}

void main() {
  print(containsNearbyDuplicate([1, 2, 3, 1], 3)); // true
  print(containsNearbyDuplicate([1, 0, 1, 1], 1)); // true
  print(containsNearbyDuplicate([1, 2, 3, 1, 2, 3], 2)); // false
}