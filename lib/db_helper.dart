import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_learn/model_class.dart';

// DBHelper nam se class banye h

class DBHelper {
  Database?
  _database; // _database nam se ye variable bnaye h esme hi data store hoga

  // ye fun bnaye h futhure nam se jo ki Database reurnt kr rha h ,getter , setter ka use kr rhe h yha esliye "get" likhe h , kuiki hm database ko get krenge

  Future<Database?> get database async {
    // yha condition lgayenge ki  agr database null nh hua to _database file ko return kr dega means data fully fill rhega to return ho jayega but agr full nh rhega to niche ke work ko work krega

    if (_database != null) return _database;

    // Directory de rhe h fun ko ,      getapplication...... means path get krega, niche 2 line se file create kiye hm ur 3rd third line file ko open kiye h

    Directory directory = await getApplicationDocumentsDirectory();

    // string bna rhe h path name se  , directory path means  jo all file ka path hota h vha tk
    // hmm create kr chuke h  , ab uske andhar mydatabase nam se file create ho jayega

    String path = join(directory.path, 'mydatabase.db');

    // ab mai es 'mydatabase' file ko open krunga, & version denge esme , jo file open hoga vh '_database' m open hoga
    _database = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        // ab file bna chuke h , ab hm table create krenge
        // databasetable ye table ka nam h , table ka nam dete time space nh dete h
        // Ab table ke andhar column banyenge , jiske ki column ka nam, ur type ur primary key dete h
        // string ke jgh p text ka use krte h sqflite m
        // querry ke andhar comment m v kus nh likh skte

        await db.execute('''
          CREATE TABLE DatabaseTable (
            id INTEGER PRIMARY KEY,
            name TEXT,
            age INTEGER
          )
        ''');
      },
    );

    return _database; // es line ka mtlb h ki jo table create kiye h vh database m chala jayega , jo database se file create kiye h usi database m
  }
  // ab hamra table create ho gya
  //ab hm table m data insert krenge
// yha p hm model class ki help se data insert krenge
  // model class ka use krne se int, id , name .... kus dene ki jarurt nh h yha bs simply modelclass ka use kr denge
  Future<int>insertData(ModelClass modelClass) async {
    Database? db = await database;

    // data ko insert krna h esliye tomap ka use krenge
    return await db!.insert('Databasetable', modelClass.toMap());

  }

  // ab h data ko read or fetch krenge
// yha p hm model class ki help se data read  krenge
//futurebuilder k through work kr rhe h esliey future lagaye h
  Future<List<ModelClass>> readData() async{
    Database? db = await database;
    final list = await db!.query('DatabaseTable');
    // fromMap ka use krenge kuiki data table se nikal kr aayega read krne k liye ,  list.map means list ko map m convert kr diye h hm
    return list.map((map) => ModelClass.fromMap(map)).toList();
  }


  // now, we delete hm data,  futurebuilder k through work kr rhe h esliey future lagaye h
 Future<int>deleteData(int id) async{
    Database? db = await database;
     return await db!.delete(
        'DatabaseTable',
    // id mangega ki kon sa delete krna h , yhi agr name dete to name vale column me chala jayega
    where: 'id = ?',
      // id provide krne ko bol rha h , to yha name dete  kyuki jo yha denge vhi same chij vo magenga
      whereArgs: [id]
    );
}


// now, we do how to update data
// yha p modelclass k through data ko update  kr rhe h
  // futurebuilder k through work kr rhe h esliey future lagaye h
Future<int>updateData(ModelClass modelClass) async {
    Database? db = await database;
    return await db!.update(
      'DatabaseTable',
      modelClass.toMap(),
      where: 'id = ?',
      whereArgs: [modelClass.id],
    );
}
}
