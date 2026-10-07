import 'package:flutter/material.dart';
import 'package:sqflite_learn/DataScrren.dart';
import 'package:sqflite_learn/db_helper.dart';
import 'package:sqflite_learn/model_class.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text("Sqflite Database"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(hintText: 'Enter Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Enter age'),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // yha p modelclass k through data ko insert kr rhe h
                  await DBHelper().insertData(
                    ModelClass(
                      name: nameController.text,
                      age: int.parse(ageController.text),
                    ),
                  );
                  nameController.clear();
                  ageController.clear();
                  print("insert data");
                },
                child: Text("Insert Data"),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  // yha p modelclass k through data ko read  kr rhe h  ,  future use krne k badd . then ka option mil jata h yha p
                  final data = await DBHelper().readData().then((value){
                    print('read data');
                  });
                  // jo v data hahiye vh dena hoga
                  print(data[1].name);
                },
                child: Text("Read Data"),
              ),
              SizedBox(height: 15),

              ElevatedButton(
                onPressed: () async {
                  try {
                    await DBHelper().deleteData(4);
                    print('Data deleted');
                  } catch (error) {
                    print('Error found: $error');
                  }
                },
                child: Text("Delete Data"),
              ),

              SizedBox(height: 15),

              ElevatedButton(
                onPressed: () async {
                  // yha p modelclass k through data ko update  kr rhe h
                  await DBHelper().updateData(
                    ModelClass(id: 1, name: 'panja', age: 20),
                  );
                  print("Data updated");
                },
                child: Text("Updated Data"),
              ),
            ],
          ),

          // yha p hm ek button v bna skte te jisko click krne p page navigate ho jata its tottly upto you what i have to use
          // data show krne k liye , jb listview ki help se data fetch hoga floaing action button ki help se data show krega
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          shape: CircleBorder(),
          focusColor: Colors.red,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DataScreen()),
            );
          },
        ),
      ),
    );
  }
}
