
//88. 병합 정렬된 배열
void merge(List<int> nums1, int m, List<int> nums2, int n) {
  int p1 = m - 1;         // nums1의 실제 요소 끝 인덱스
  int p2 = n - 1;         // nums2의 끝 인덱스
  int p = m + n - 1;      // nums1의 전체 공간 끝 인덱스

  // 뒤에서부터 큰 값을 채워 넣음
  while (p1 >= 0 && p2 >= 0) {
    if (nums1[p1] > nums2[p2]) {
      nums1[p] = nums1[p1];
      p1--;
    } else {
      nums1[p] = nums2[p2];
      p2--;
    }
    p--;
  }

  // nums2에 남은 값 복사
  while (p2 >= 0) {
    nums1[p] = nums2[p2];
    p2--;
    p--;
  }
}
void main() {
  // List<int> nums1 = [1, 2, 3, 0, 0, 0];
  // List<int> nums2 = [2, 5, 6];
  // int m = 3, n = 3;

  // List<int> nums1 = [1];
  // List<int> nums2 = [0];
  // int m = 1, n = 0;

  List<int> nums1 = [0];
  List<int> nums2 = [1];
  int m = 0, n = 1;

  merge(nums1, m, nums2, n);
  print(nums1); // 출력: [1, 2, 2, 3, 5, 6]
}
