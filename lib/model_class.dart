class ModelClass {
  final int? id;   // esko null bnaye h kyuki  yha pe id khud auto increment hoga
  final String name;
  final int age;

  // jis nams se class bnaye rhenge usi nam se constructor v bnyenge

  ModelClass({
    this.id,
    required this.name,
    required this.age,
    // yha tk  model class bn gya
  });

  // ab hm ek method banayenge
  // jb hme table se data chahiye to ye table se data lega map form m ur model class ki form m return krega
// frommap  means map se data lekr esko convert kiye h model class m
  factory ModelClass.fromMap(Map<String, dynamic> map) {
    return ModelClass(id: map['id'], name: map['name'], age: map['age']);
  }
// sqflite map ki data ko accept krta h
  // another method bnayenge
// esme hm tomap ka use kiye h mtlb model class se map m convert hoga yha se
  // jo v data hm string, int, .... form m denge usko map m convert krke tb table me bhejega , jb hme insert krna hoga data
  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }
// yha tk completely sqflite model class bn gya h
}
