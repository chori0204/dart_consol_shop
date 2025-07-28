//933. 최근 호출 수 

import 'dart:collection';

class RecentCounter {
  Queue<int> _queue; ///요청 시간을 저장하는 큐.

  RecentCounter() : _queue = Queue<int>(); //생성자에서 초기화 

  int ping(int t) {
    _queue.addLast(t); //요청 시간을 큐의 뒤쪽에 추가.
    while (_queue.isNotEmpty && _queue.first < t - 3000) {
      _queue.removeFirst(); ///오래된 요청 제거.
    }
    return _queue.length; ///현재 유효한 요청 수 반환.
  }
}
void main() {
  var recentCounter = RecentCounter();
  print(recentCounter.ping(1));     // 출력: 1
  print(recentCounter.ping(100));   // 출력: 2
  print(recentCounter.ping(3001));  // 출력: 3
  print(recentCounter.ping(3002));  // 출력: 3
}