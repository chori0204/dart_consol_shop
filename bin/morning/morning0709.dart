int majorityElement(List<int> nums) {
  int count = 0;
  int? candidate;

  for (int num in nums) {
    if (count == 0) {
      candidate = num;
    }
    count += (num == candidate) ? 1 : -1;
  }

  // 검증 단계 (필요한 경우)
  int occur = nums.where((x) => x == candidate).length;
  return (occur > nums.length ~/ 2) ? candidate! : -1;
}
void main() {
  print(majorityElement([3,2,3])); // 출력: 3
  print(majorityElement([2,2,1,1,1,2,2]));         // 출력: 2 
}
