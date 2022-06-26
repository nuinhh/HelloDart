import 'dart:collection';
import 'dart:math';
import 'dart:convert';

// 测试dart核心库中数字、集合、字符串的功能
void dartcore_numbers_collection_string() {
//数字部分

  assert(num.parse('42') is int);
  assert(num.parse('0x42') is int);
  assert(num.parse('0.50') is double);

//设置进制
  assert(int.parse('42', radix: 16) == 66);

// 将整型转换为字符串.
  assert(42.toString() == '42');

// 将双精度浮点转换为字符串.
  assert(123.456.toString() == '123.456');

// 指定小数点右边的位数.
  assert(123.456.toStringAsFixed(2) == '123.46');

// 科学计数法的转换.
  assert(123.456.toStringAsPrecision(2) == '1.2e+2');
  assert(double.parse('1.2e+2') == 120.0);

// 检查字符串中是否包含查找的字符串.
  assert('Never odd or even'.contains('odd'));

// 检查字符串中是否以特定字符串开头
  assert('Never odd or even'.startsWith('Never'));

// 检查字符串中是否以特定字符串结尾
  assert('Never odd or even'.endsWith('even'));

// 找到特定字符串的位置
  assert('Never odd or even'.indexOf('odd') == 6);

// 抓取指定位置的字符串
  assert('Never odd or even'.substring(6, 9) == 'odd');
// 以指定字符分割字符串.
  var parts = 'progressive web apps'.split(' ');
  assert(parts.length == 3);
  assert(parts[0] == 'progressive');
// 通过下标得到对应的UTF-16字母.
  assert('Never odd or even'[0] == 'N');
//分割并输出每个分割得到的字符
  for (final char in 'hello'.split('')) {
    print(char);
  }

//得到字符串中所有UTF-16字符.
  var codeUnitList = 'Never odd or even'.codeUnits.toList();
  assert(codeUnitList[0] == 78);

// 转换成大写.
  assert('web apps'.toUpperCase() == 'WEB APPS');
// 转换成小写.
  assert('WEB APPS'.toLowerCase() == 'web apps');

// 移除首尾空格.
  assert('  hello  '.trim() == 'hello');

// 检验是否为空.
  assert(''.isEmpty);

// 检验是否为非空.
  assert('  '.isNotEmpty);

//replace操作只是返回了一个新字符串，并没有改变原字符串
  var greetingTemplate = 'Hello, NAME!';
  var greeting = greetingTemplate.replaceAll(RegExp('NAME'), 'Bob');
  assert(greeting != greetingTemplate);

//构建一个字符串，在tostring前都没有生成新字符串对象
  var sb = StringBuffer();
  sb
    ..write('Use a StringBuffer for ')
    ..writeAll(['efficient', 'string', 'creation'], ' ')
    ..write('.');

  var fullString = sb.toString();

  assert(fullString == 'Use a StringBuffer for efficient string creation.');

// 正则表达式
  var numbers = RegExp(r'\d+');
  var allCharacters = 'llamas live fifteen to twenty years';
  var someDigits = 'llamas live 15 to 20 years';
  assert(!allCharacters.contains(numbers));
  assert(someDigits.contains(numbers));
  var exedOut = someDigits.replaceAll(numbers, 'XX');
  assert(exedOut == 'llamas live XX to XX years');

  assert(numbers.hasMatch(someDigits));
//循环输出句子中符合条件的所有值
  for (final match in numbers.allMatches(someDigits)) {
    print(match.group(0)); // 15, then 20
  }
}

//测试dart核心库中list的功能
void dartcore_list() {
// list的创建和初始化
  var grains = <String>[];
  assert(grains.isEmpty);
  var fruits = ['apples', 'oranges'];

// list的基本操作
  fruits.add('kiwis');

  fruits.addAll(['grapes', 'bananas']);
  assert(fruits.length == 5);

  var appleIndex = fruits.indexOf('apples');
  fruits.removeAt(appleIndex);
  assert(fruits.length == 4);

  fruits.clear();
  assert(fruits.isEmpty);

  var vegetables = List.filled(99, 'broccoli');
  assert(vegetables.every((v) => v == 'broccoli'));

//根据下标查找值.
  assert(fruits[0] == 'apples');

//根据值查找下标.
  assert(fruits.indexOf('apples') == 0);

//将list排序.
  fruits.sort((a, b) => a.compareTo(b));
  assert(fruits[0] == 'apples');

//列表可以指定类型.
  var fruits_1 = <String>[];
  fruits_1.add('apples');
  var fruit = fruits_1[0];
  assert(fruit is String);
}

//dart核心库中集合功能测试
void dartcore_set() {
//Set的创建和初始化
  var ingredients = <String>{};

  ingredients.addAll(['gold', 'titanium', 'xenon']);
  assert(ingredients.length == 3);

  ingredients.add('gold');
  assert(ingredients.length == 3);

  ingredients.remove('gold');
  assert(ingredients.length == 2);

  var atomicNumbers = Set.from([79, 22, 54]);

  var ingredients_1 = Set<String>();
  ingredients_1.addAll(['gold', 'titanium', 'xenon']);

// 检查对应元素是否存在
  assert(ingredients_1.contains('titanium'));

// 检查所有元素是否都存在
  assert(ingredients_1.containsAll(['titanium', 'xenon']));

//创建两个集合的交集.
  var nobleGases = Set.from(['xenon', 'argon']);
  var intersection = ingredients_1.intersection(nobleGases);
  assert(intersection.length == 1);
  assert(intersection.contains('xenon'));
}

//dart核心库中map的功能测试
void dartcore_map() {
  var hawaiianBeaches = {
    'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
    'Big Island': ['Wailea Bay', 'Pololu Beach'],
    'Kauai': ['Hanalei', 'Poipu']
  };

  var searchTerms = Map();

  var nobleGases = Map<int, String>();

  var nobleGases_1 = {54: 'xenon'};

//map的一些基本功能
  assert(nobleGases_1[54] == 'xenon');

  assert(nobleGases_1.containsKey(54));

  nobleGases_1.remove(54);
  assert(!nobleGases_1.containsKey(54));

//从一个 map 中检索出所有的 key 或所有的 value
  var keys = hawaiianBeaches.keys;

  assert(keys.length == 3);
  assert(Set.from(keys).contains('Oahu'));

  var values = hawaiianBeaches.values;
  assert(values.length == 3);
  assert(values.any((v) => v.contains('Waikiki')));

//检查一个 map 中是否包含某个key
  assert(hawaiianBeaches.containsKey('Oahu'));
  assert(!hawaiianBeaches.containsKey('Florida'));

  var teamAssignments = <String, String>{};
  String pickToughestKid() {
    return "pickToughestKid";
  }

//如果当且仅当该 key 不存在于 map 中，且要为这个 key 赋值，可使用 putIfAbsent() 方法。
//该方法需要一个方法返回这个 value。
  teamAssignments.putIfAbsent('Catcher', () => pickToughestKid());
  assert(teamAssignments['Catcher'] != null);
}

//公共集合方法测试
void public_test() {
//检查 list， set 或 map 对象中是否包含元素
  var coffees = <String>[];
  var teas = ['green', 'black', 'chamomile', 'earl grey'];
  assert(coffees.isEmpty);
  assert(teas.isNotEmpty);
//让 list， set 或 map 对象中的每个元素都使用一个方法
  teas.forEach((tea) => print('I drink $tea'));
//map 对象上调用 `forEach() 方法时，函数必须带两个参数（key 和 value）
  var hawaiianBeaches = {
    'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
    'Big Island': ['Wailea Bay', 'Pololu Beach'],
    'Kauai': ['Hanalei', 'Poipu']
  };
  hawaiianBeaches.forEach((k, v) {
    print('I want to visit $k and swim at $v');
  });
//map() 方法可将所有结果返回到一个对象中
  var loudTeas = teas.map((tea) => tea.toUpperCase());
  loudTeas.forEach(print);
//toList()或toSet()可以强制在每个项目上立即调用函数
  var loudTeas_1 = teas.map((tea) => tea.toUpperCase()).toList();

  bool isDecaffeinated(String teaName) => teaName == 'chamomile';

  var decaffeinatedTeas = teas.where((tea) => isDecaffeinated(tea));

  assert(teas.any(isDecaffeinated));

  assert(!teas.every(isDecaffeinated));
}

void time() {
  //对时间的各项操作
  var now = DateTime.now();

  var y2k = DateTime(2000); // January 1, 2000

  y2k = DateTime(2000, 1, 2); // January 2, 2000

  y2k = DateTime.utc(2000); // 1/1/2000, UTC

  y2k = DateTime.fromMillisecondsSinceEpoch(946684800000, isUtc: true);

  y2k = DateTime.parse('2000-01-01T00:00:00Z');

//返回毫秒数
// 1/1/2000, UTC
  var x = DateTime.utc(2000);
  assert(x.millisecondsSinceEpoch == 946684800000);
// 1/1/1970, UTC
  var unixEpoch = DateTime.utc(1970);
  assert(unixEpoch.millisecondsSinceEpoch == 0);

  var y2k_1 = DateTime.utc(2000);

  var y2001 = y2k_1.add(const Duration(days: 366));
  assert(y2001.year == 2001);

  var december2000 = y2001.subtract(const Duration(days: 30));
  assert(december2000.year == 2000);
  assert(december2000.month == 12);

  var duration = y2001.difference(y2k);
  assert(duration.inDays == 366); // y2k was a leap year.
}

void math_test() {
  // 三角函数
  assert(cos(pi) == -1.0);
  var degrees = 30;
  var radians = degrees * (pi / 180);
  var sinOf30degrees = sin(radians);
  assert((sinOf30degrees - 0.5).abs() < 0.01);

  // 最大值和最小值
  assert(max(1, 1000) == 1000);
  assert(min(1, -1000) == -1000);

  // 数学常数
  print("e: " + e.toString()); // 2.718281828459045
  print("pi: " + pi.toString()); // 3.141592653589793
  print("sqrt2: " + sqrt2.toString()); // 1.4142135623730951

  //随机数生成
  var random = Random();
  print(random.nextDouble());
  print(random.nextInt(10)); // Between 0 and 9.
  print(random.nextBool()); // true or false
}

void uft8Test() {
  List<int> utf8Bytes = [
    0xc3,
    0x8e,
    0xc3,
    0xb1,
    0xc5,
    0xa3,
    0xc3,
    0xa9,
    0x72,
    0xc3,
    0xb1,
    0xc3,
    0xa5,
    0xc5,
    0xa3,
    0xc3,
    0xae,
    0xc3,
    0xb6,
    0xc3,
    0xb1,
    0xc3,
    0xa5,
    0xc4,
    0xbc,
    0xc3,
    0xae,
    0xc5,
    0xbe,
    0xc3,
    0xa5,
    0xc5,
    0xa3,
    0xc3,
    0xae,
    0xe1,
    0xbb,
    0x9d,
    0xc3,
    0xb1
  ];
  var funnyWord = utf8.decode(utf8Bytes);
  print(funnyWord);
  assert(funnyWord == 'Îñţérñåţîöñåļîžåţîờñ');

  List<int> encoded = utf8.encode('Îñţérñåţîöñåļîžåţîờñ');

  assert(encoded.length == utf8Bytes.length);
  for (int i = 0; i < encoded.length; i++) {
    assert(encoded[i] == utf8Bytes[i]);
  }
}

void main() {
  dartcore_numbers_collection_string();
  dartcore_list();
  dartcore_set();
  dartcore_map();
  public_test();
  time();
  math_test();
  uft8Test();
}
