List<String> summaryRanges(List<int> nums) {
  List<String> result = [];

  if (nums.isEmpty) return result;

  int start = nums[0];

  for (int i = 1; i < nums.length; i++) {
    if (nums[i] != nums[i - 1] + 1) {
      int end = nums[i - 1];
      result.add(start != end ? '$start->$end' : '$start');
      start = nums[i];
    }
  }

  // 마지막 범위 추가
  result.add(start != nums.last ? '$start->${nums.last}' : '$start');

  return result;
}

void main() {
  print(summaryRanges([0, 1, 2, 4, 5, 7])); // ["0->2", "4->5", "7"]
  print(summaryRanges([0, 2, 3, 4, 6, 8, 9])); // ["0", "2->4", "6", "8->9"]
  print(summaryRanges([])); // []
}