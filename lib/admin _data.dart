import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataList extends StatefulWidget {
  const DataList({Key? key}) : super(key: key);

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("USER-DATA",style: TextStyle(fontSize: 25,),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, i) {
              var Data = snapshot.data!.docs[i];
              var img = File(Data['image']);
              return Container(
                height: 80,
                width: double.infinity,
                margin: EdgeInsets.only(top: 16,left: 10,right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Text(snapshot.data!.docs[i]['first name']),
                      SizedBox(width: 4,),
                      Text(snapshot.data!.docs[i]['Secound name'])
                    ],
                  ),
                  subtitle: Text("${Data["email"]}"),
                  trailing: Text("${Data["Password"]}"),
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: FileImage(img),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                ),
              );
            },);
        },),
    );
  }
}