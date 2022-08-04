// Flutter Driver API를 import 합니다.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Counter App', () {
    // 먼저 Finders를 정의합니다. 테스트 모음의 위젯들을 위치시키기 위해 Finder를
    // 사용할 것입니다. 참고: `byValueKey` 메서드에 인자로 넘겨줄 문자열은 step 1에서
    // 사용한 Key와 동일해야 합니다.
    final counterTextFinder = find.byValueKey('counter');
    final buttonFinder = find.byValueKey('increment');

    FlutterDriver? driver;

    // 테스트를 수행하기 전에 Flutter driver와 연결합니다.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // 테스트 완료 후 driver와의 연결을 종료합니다.
    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test('starts at 0', () async {
      // `driver.getText` 메서드를 사용하여 카운터가 0부터 시작하는지 확인합니다.
      expect(await driver!.getText(counterTextFinder), "0");
    });

    test('increments the counter', () async {
      // 먼저 버튼을 누릅니다.
      await driver!.tap(buttonFinder);

      // 그리고 카운터 값이 1 만큼 증가했는지 확인합니다.
      expect(await driver!.getText(counterTextFinder), "1");
    });
  });
}