//变量（https://dart.cn/samples）
void variable() {
  var name = 'Voyager I';
  var year = 1977;
  var antennaDiameter = 3.7;
  var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
  var image = {
    'tags': ['saturn'],
    'url': '//path/to/saturn.jpg'
  };
  print(
      'name is $name, year is $year, antennaDiameter is $antennaDiameter, flybyObjects is $flybyObjects, image is $image');
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

  void describe(){
    print("Spacecraft: $name");
    var launchDate = this.launchDate;
    if (launchDate != null){
      int years = DateTime.now().difference(launchDate).inDays.~/ 365;
      print('Launched:$launchYear ($years years ago)');
    } else{
      print('Unlaunched');
    }
  }
}

//扩展类（继承）
class Orbiter extends Spacecraft {
  double altitude;

  Orbiter(super.name, DateTime super.launchDate, this.altitude);
}

void main() {
  variable();
  var voyager = Spacecraft('Voyager I',  DateTime(1977, 9, 5));
  voyager.describe();

  var voyager3 = Spacecraft.unlaunched('Voyager III');
  voyager3.describe();

}
