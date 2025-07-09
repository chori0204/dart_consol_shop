
void main() {
 //실행방법 : 터미널에서 dart run bin/morning/morting0703.dart
 //242.유효한 애너그램  s와 t 가 입력이 되었을때 
 //anagram nagaram 

 //list, MAP 형태로 두가지 사용 방법이 있음   

print(isAnagram("anagram","nagaram"));
print(isAnagram("rat","car"));
}

 bool isAnagram (String s , String t){
  s.trim();
  t.trim();
  
  if (s.length == t.length ){  
    List<String>sortS =s.split('')..sort();
    List<String>sortT=t.split('')..sort();  

    print(sortS);
    print(sortT);
    print(sortS.join());
    print(sortT.join());

    return true;
  } else {
      return false;
  }   

 }