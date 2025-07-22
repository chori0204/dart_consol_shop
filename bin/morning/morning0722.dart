List<List<int>> findUniqueElements(List<int> nums1, List<int> nums2) {
  // 중복 제거: 고유한 원소 집합 생성
  Set<int> set1 = nums1.toSet();
  Set<int> set2 = nums2.toSet();

  // nums1에는 있지만 nums2에는 없는 원소
  List<int> unique1 = set1.where((num) => !set2.contains(num)).toList();

  // nums2에는 있지만 nums1에는 없는 원소
  List<int> unique2 = set2.where((num) => !set1.contains(num)).toList();

  return [unique1, unique2];
}

void main() {
  print(findUniqueElements([1, 2, 3], [2, 4, 6]));      // [[1, 3], [4, 6]]
  print(findUniqueElements([1, 2, 3, 3], [1, 1, 2, 2])); // [[3], []]
}