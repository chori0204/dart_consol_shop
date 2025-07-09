void main() {
  print(tribonacci(4));   // 출력: 4
  print(tribonacci(25));  // 출력: 1389537
}

int tribonacci(int n) {
  if (n == 0) return 0;
  if (n == 1 || n == 2) return 1;

  int t0 = 0, t1 = 1, t2 = 1, t3 = 0;
  for (int i = 3; i <= n; i++) {

    print("T$n = T($n-1) +T($n-2)+ T($n-3) ");
    t3 = t0 + t1 + t2; // t3= 0+1+1
    t0 = t1; 
    t1 = t2;
    t2 = t3;
  }
  return t3;
}

