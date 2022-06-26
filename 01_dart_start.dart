//变量（https://dart.cn/samples）
import 'dart:math';
import 'dart:io';
import 'dart:async';

class TestClass {
  var name = 'Voyager I';
  var year = 1977;
  var antennaDiameter = 3.7;
  var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
  void variable() {
    var image = {
      'tags': ['saturn'],
      'url': '//path/to/saturn.jpg'
    };
    print(
        'name is $name, year is $year, antennaDiameter is $antennaDiameter, flybyObjects is $flybyObjects, image is $image');
  }
}

//流程控制
void controlFLow() {
  var year = 1977;
  var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
  if (year >= 2001) {
    print('21st century');
  } else if (year >= 1901) {
    print('20th century');
  }
  for (final object in flybyObjects) {
    print(object);
  }

  for (int month = 1; month <= 12; month++) {
    print(month);
  }

  while (year < 2016) {
    year += 1;
  }
}

//函数
int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

//类
class Spacecraft {
  String name;

  DateTime? launchDate;

  int? get launchYear => launchDate?.year;

  Spacecraft(this.name, this.launchDate) {}

  Spacecraft.unlaunched(String name) : this(name, null);

  void describe() {
    print("Spacecraft: $name");
    var launchDate = this.launchDate;
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched:$launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}

//扩展类（继承）
class Orbiter extends Spacecraft {
  double altitude = 0;

  Orbiter(String name, DateTime? launchDate) : super(name, launchDate);
}

//Mixin
mixin Piloted {
  int astronauts = 1;

  void describeCrew() {
    print("Number of astronauts: $astronauts");
  }
}

class PilotedCraft extends Spacecraft with Piloted {
  PilotedCraft(String name, DateTime date) : super(name, date);
}

//接口和抽象类
class MockSpaceship implements Spacecraft {
  @override
  DateTime? launchDate;

  @override
  String name = "Mock";

  @override
  void describe() {
    print('mock');
  }

  @override
  // TODO: implement launchYear
  int? get launchYear => throw UnimplementedError();
  // ···
}

abstract class Describable {
  void describe();

  void describeWithEmphasis() {
    print("========");
    describe();
    print("========");
  }
}

class DescSpaceship extends Describable {
  @override
  void describe() {
    print("here is the description");
  }
}

//异步同步
const oneSecond = Duration(seconds: 1);
// ···
Future<void> printWithDelay(String message) async {
  await Future.delayed(oneSecond);
  print(message);
}

Future<void> createDescriptions(Iterable<String> objects) async {
  for (final object in objects) {
    try {
      var file = File('$object.txt');
      if (await file.exists()) {
        var modified = await file.lastModified();
        print('File for $object already exists. It was modified on $modified.');
        continue;
      }
      await file.create();
      await file.writeAsString('Start describing $object in this file.');
    } on IOException catch (e) {
      print('Cannot create description for $object: $e');
    }
  }
}

Stream<String> report(Spacecraft craft, Iterable<String> objects) async* {
  for (final object in objects) {
    await Future.delayed(oneSecond);
    yield '${craft.name} flies by $object';
  }
}

Future<void> testAsync() async {
  for (int i = 1; i <= 5; i++) {
    printWithDelay("async result: " + i.toString());
  }
}

TestClass testClass = TestClass();
Future<int> testEcp() async {
  try {
    for (final object in testClass.flybyObjects) {
      var description = await File('$object.txt').readAsString();
      print(description);
    }
  } on IOException catch (e) {
    print('Could not describe object: $e');
  } finally {
    testClass.flybyObjects.clear();
  }
  return 0;
}

void main() {
  print('\n' + '变量测试' + '\n');
  testClass.variable();

  print('\n' + '流程控制测试' + '\n');
  controlFLow();

  print('\n' + '函数测试' + '\n');
  fibonacci(8);

  print('\n' + '类测试' + '\n');
  var voyager = Spacecraft('Voyager I', DateTime(1977, 9, 5));
  voyager.describe();

  var voyager3 = Spacecraft.unlaunched('Voyager III');
  voyager3.describe();

  print('\n' + '继承类测试' + '\n');
  var spacecraft = Orbiter("Orbiter", DateTime(2022, 6, 20));
  spacecraft.describe();

  print('\n' + 'Mixin测试' + '\n');
  var craft = PilotedCraft("piloted", DateTime.now());
  craft.describe();
  craft.describeCrew();

  print('\n' + '接口和抽象类测试' + '\n');
  var mock = MockSpaceship();
  mock.describe();
  var desc = DescSpaceship();
  desc.describeWithEmphasis();

  print('\n' + '异步和异常测试' + '\n');
  testAsync();
  testEcp();
}
