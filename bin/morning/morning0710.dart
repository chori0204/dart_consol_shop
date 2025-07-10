
//26. 정렬된 배열에서 중복 제거

class Solution {
  int removeDuplicates(List<int> nums) {
    if (nums.isEmpty) return 0;

    int k = 1;
    for (int i = 1; i < nums.length; i++) {
      if (nums[i] != nums[k - 1]) {
        nums[k] = nums[i];
        k++;
      }
    }
    return k;
  }
}

void main() {
  List<int> nums = [1, 1, 2];
  Solution solution = Solution(); // 인스턴스 생성
  int k = solution.removeDuplicates(nums);
  print('k = $k');
  print('nums = ${nums.sublist(0, k)} + ${List.filled(nums.length - k, "_")}');
  // 출력: k = 2, nums = [1, 2]
}



/*

class Solution {
  int removeDuplicates(List<dynamic> nums) { // 타입을 dynamic으로 변경해서 숫자 + "_" 가능
    if (nums.isEmpty) return 0;

    int k = 1;
    for (int i = 1; i < nums.length; i++) {
      if (nums[i] != nums[k - 1]) {
        nums[k] = nums[i];
        k++;
      }
    }

    // 나머지 부분 "_"로 채우기
    for (int i = k; i < nums.length; i++) {
      nums[i] = "_";
    }

    return k;
  }
}

void main() {
  List<dynamic> nums = [0,0,1,1,1,2,2,3,3,4];
  Solution solution = Solution();
  int k = solution.removeDuplicates(nums);
  print('k = $k');
  print('nums = $nums');
  // 출력: k = 5, nums = [0, 1, 2, 3, 4, _, _, _, _, _]
}

*/