import 'package:flutter/material.dart';
import 'package:sqflite_learn/db_helper.dart';

import 'model_class.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Data Screen"),
        ),
      // future builder ki help se data ko fetch krte h
      body: FutureBuilder(
        // future,  db_helper ke andhar jakr readData me se data ko fetch krega
          future: DBHelper().readData(),
          builder: (context, AsyncSnapshot<List<ModelClass>> snapshot) {
            // check krenge ki data aa rha h ya null hai
            if(snapshot.hasData) {
              print(snapshot.data);
            }
            // return kiye h listview builder ko kyuki tv to title ur subtitle ka option hme milega
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
              return ListTile(
                // list m se name(title) print krna k liye
                title: Text(snapshot.data![index].name),
                // list m subtitle print krne kk liye
                subtitle: Text(snapshot.data![index].age.toString(),)

              );
            }

            );
          },),
      ),
    );
  }
}
