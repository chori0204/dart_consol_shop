import 'dart:io';
import 'dart:math';
import 'dart:convert';

//실행방법 : 터미널에서 dart run bin/gaim/dart_gaim.dart

/// ─────────────────────────────────────
/// 1. DataLoader: 플레이어·몬스터 데이터 로드
/// ─────────────────────────────────────
class DataLoader {
  /// player_stats.txt: maxHp,attack,defense
  List<int> loadPlayerStats(String path) {
    final parts = File(path)
        .readAsStringSync()
        .trim()
        .split(',')
        .map((s) => int.parse(s.trim()))
        .toList();
    if (parts.length != 3) {
      throw FormatException(
          'player_stats.txt 포맷 오류: maxHp,attack,defense 세 개의 값이 필요합니다.');
    }
    return parts;
  }

  /// monsters.txt: name,maxHp,attack
  List<Monster> loadMonsters(String path) {
    final lines = File(path)
        .readAsLinesSync()
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();
    if (lines.isEmpty) {
      throw FormatException('monsters.txt에 몬스터 데이터가 없습니다.');
    }
    return lines.map((line) {
      final cols = line.split(',').map((s) => s.trim()).toList();
      if (cols.length != 3) {
        throw FormatException('monsters.txt 포맷 오류: name,maxHp,attack 세 개의 값이 필요합니다.\n> $line');
      }
      return Monster(
        cols[0],
        int.parse(cols[1]),
        int.parse(cols[2]),
      );
    }).toList();
  }
}

/// ─────────────────────────────────────
/// 2. Character 추상 클래스
/// ─────────────────────────────────────
abstract class Character {
  String name;
  int maxHp, hp, attack, defense;
  Character(this.name, this.maxHp, this.attack, this.defense)
      : hp = maxHp;

  bool get isAlive => hp > 0;  //hp가 0보다 커야 생존

  void takeDamage(int dmg) {
    final dealt = (dmg - defense).clamp(0, dmg);
    hp = (hp - dealt).clamp(0, maxHp);
    print('$name 이 데미지를 $dealt 받았습니다. (HP: $hp/$maxHp)');
    
 }

  void attackTarget(Character target) {
    target.takeDamage(attack);
  }

}

/// ─────────────────────────────────────
/// 3. Player 클래스
/// ─────────────────────────────────────
class Player extends Character {
  Player(String name, int maxHp, int attack, int defense)
      : super(name, maxHp, attack, defense);

  /// 방어 시 반사된 데미지만큼 회복, 최대 maxHp까지
  void heal(int amt) {
    final before = hp;
    hp = min(maxHp, hp + amt);
    final healed = hp - before;
    print('방어로 막은 데미지 만큼 $name 의 hp $healed 를 회복합니다. (HP: $hp/$maxHp)');
          
  }
}

/// ─────────────────────────────────────
/// 4. Monster 클래스 (defense = 0)
/// ─────────────────────────────────────
class Monster extends Character {
  Monster(String name, int maxHp, int attack)
      : super(name, maxHp, attack, 0);
}

/// ─────────────────────────────────────
/// 5. Game: 턴제 전투 로직
/// ─────────────────────────────────────
class Game {
  final Player player;
  final List<Monster> pool;
  final _rnd = Random();

  Game(this.player, this.pool);

  /// 게임 시작: 남은 몬스터 순회하며 전투
  bool startGaim() {
    print('\n=== 게임을 시작합니다 ===');
    print(
      '[Player] ${player.name}  '
      'HP:${player.hp}/${player.maxHp}  '
      'ATK:${player.attack} DEF:${player.defense}\n',
    );

    final remaining = List<Monster>.from(pool);
    while (player.isAlive && remaining.isNotEmpty) {
      // 랜덤 몬스터 선택 후 리스트에서 제거
      final idx = _rnd.nextInt(remaining.length);
      final mon = remaining.removeAt(idx);

      print('새로운 몬스터가 나타났습니다. \n${mon.name} 등장! (체력:${mon.hp}/${mon.maxHp},공격력 :${mon.attack})');

      // 전투
      while (player.isAlive && mon.isAlive) {
        stdout.write('\n[${player.name} 턴] \n행동을 선택하세요 1:공격  2:방어 > ');
        final choice = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
        final numeric = RegExp(r'^[0-9]+$').hasMatch(choice);
        final defend = choice == '2';

        if (choice.isEmpty) {
          print('입력된 내용이 없습니다.');
          continue;
        }

       if (numeric == false) {
          print('Action 숫자로만 가능합니다.');
          continue;
        }

        if (defend) {
          print('${player.name} 가 방어했습니다 !');
        } else {
          print('${player.name} 가 공격했습니다 !');
          player.attackTarget(mon);
          
        }

        if (!mon.isAlive) break;

        if (defend) {
          // 방어 시 반사: 몬스터 공격력만큼 몬스터 데미지 및 플레이어 회복
          print('\n[${mon.name} 턴]');
          print('${mon.name} 의 공격했으나,${player.name} 가 방어하여 반사 된 데미지가 몬스터에게 돌아갔습니다.');
          mon.takeDamage(mon.attack);
          player.heal(mon.attack);
           print('(${player.name} - '
                'HP:${player.hp}/${player.maxHp}  '
               'ATK:${player.attack} DEF:${player.defense})');
           print('(${mon.name} - '
                'HP:${mon.hp}/${mon.maxHp}  '
               'ATK:${mon.attack})\n');
        } else {
          print('\n[${mon.name} 턴]');
          print('${mon.name} 가 공격했습니다.');
          mon.attackTarget(player);
          print('(${player.name} - '
                'HP:${player.hp}/${player.maxHp}  '
               'ATK:${player.attack} DEF:${player.defense})');
           print('(${mon.name} - '
                'HP:${mon.hp}/${mon.maxHp}  '
               'ATK:${mon.attack})\n');
        }
      }

      if (!player.isAlive) {
        print('\n${player.name} 사망... 게임 오버');
        return false;
      }

      print('\n ${mon.name} 처치 완료! 남은 몬스터: ${remaining.length}\n');

    if (remaining.isNotEmpty) {
      while (true) {
        stdout.write('다음 몬스터와 전투하시겠습니까? (y/n) > ');
        final nextCheck = stdin.readLineSync()?.trim().toLowerCase() ?? '';

        if (nextCheck.isEmpty) {
          print('입력이 비어 있습니다. 다시 입력해주세요.');
          continue;
        }

        if (nextCheck == 'n') {
          print('중도 포기... 게임 종료');
          return false;
        } else if (nextCheck == 'y') {
          print('전투를 계속합니다.');
          break;
        } else {
          print('잘못 입력하셨습니다. (전투계속: y / 중도포기: n)');
          continue;
        }
      }
    }
  }
    print('\n 모든 몬스터를 처치했습니다! 승리! ');
    return true;
  }
}

void main() {
  // 1) 캐릭터 이름 입력 (한글·영문만)
  String playerName;
  while (true) {
    stdout.write('캐릭터 이름을 입력하세요: ');
    final input = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
    final pattern = RegExp(r'^[가-힣A-Za-z]+$').hasMatch(input);
    //RegExp(r'^[가-힣ㄱ-ㅎㅏ-ㅣA-Za-z]+$') 
    //RegExp(r'^[가-힣A-Za-z]+$') --한글 자음 모음만 입력하는것을 막으려면

    if (input.isEmpty) {
      print('이름을 입력해야 합니다.');
      continue;
    }
    
    if (pattern ==false) {
      print('숫자·특수문자 없이 한글·영문만 가능합니다.');
      continue;
    }
    playerName = input;
    break;
  }

  // 2) 파일에서 스탯·몬스터 로드
  late Player player;
  late List<Monster> monsters;
  try {
    final loader = DataLoader();
    final stats = loader.loadPlayerStats('bin/gaim/file/characters.txt');
    monsters = loader.loadMonsters('bin/gaim/file/monsters.txt');
    player = Player(playerName, stats[0], stats[1], stats[2]);
  } catch (e) {
    stderr.writeln('데이터 로드 오류: $e');
    return;
  }

  // 3) 게임 시작
  final success = Game(player, monsters).startGaim();

  // 4) 결과 파일에 저장
  final result = '${DateTime.now().toIso8601String()} | '
      '${playerName} | ${success ? "승리" : "패배"}\n';
  
  // 5) 저장 여부 확인 ================================
   while (true) {
    stdout.write('\n결과 파일을 저장하시겠습니까? (y/n) > ');
    final saveResult = stdin.readLineSync()?.trim().toLowerCase() ?? '';
    final patSave = RegExp(r'^[a-zA-Z]+$').hasMatch(saveResult);

    if (saveResult.isEmpty) {
      print('⚠️ 입력이 비어 있습니다. 다시 입력해주세요.');
      continue;
    }

    if (saveResult == 'n') {
      print('저장하지 않고 종료합니다.');
      break;
    } else if (saveResult == 'y') {
      File('bin/gaim/file/game_results.txt')
       .writeAsStringSync(result, mode: FileMode.append);
      print('\n 게임 결과가 game_results.txt 에 저장되었습니다.');
      break;
    } else {
       print('잘못 입력하셨습니다..(저장 : y, 저장안함 : n)');
      continue;
    }
  }
}