
int maxProfit(List<int> prices) {
  int minPrice = 10001; // prices[i]의 최대 값이 10,000이므로 그보다 큰 값으로 초기화
  int maxProfit = 0;

  for (int price in prices) {
    if (price < minPrice) {
      minPrice = price; // 최소 가격 갱신
    } else if (price - minPrice > maxProfit) {
      maxProfit = price - minPrice; // 최대 이익 갱신
    }
  }

  return maxProfit;
}
void main() {
  print(maxProfit([7, 1, 5, 3, 6, 4])); // 출력: 5
  print(maxProfit([7, 6, 4, 3, 1]));    // 출력: 0
}
