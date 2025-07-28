int minCostClimbingStairs(List<int> cost) {
  int n = cost.length;
  List<int> dp = List.filled(n, 0);
  dp[0] = cost[0];
  dp[1] = cost[1];

  for (int i = 2; i < n; i++) {
    dp[i] = cost[i] + (dp[i - 1] < dp[i - 2] ? dp[i - 1] : dp[i - 2]);
  }

  return dp[n - 1] < dp[n - 2] ? dp[n - 1] : dp[n - 2];
}

void main() {
  print(minCostClimbingStairs([10, 15, 20])); // 출력: 15
  print(minCostClimbingStairs([1, 100, 1, 1, 1, 100, 1, 1, 100, 1])); // 출력: 6
}