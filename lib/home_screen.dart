import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/update.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void signOut() {
    FirebaseAuth.instance.signOut();
    User? user = FirebaseAuth.instance.currentUser;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LoginScreen();
    },));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
          actions: [IconButton(onPressed: () {
            signOut();
          }, icon:Icon(Icons.logout))],
      ),
      body: StreamBuilder(
        stream:FirebaseFirestore.instance.collection("users").where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData)
            {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                var Data=snapshot.data!.docs[index];
                var img = File(Data["image"]);
                return Column(
                  children: [
                    SizedBox(height: 20,),
                    Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: FileImage(img),fit:BoxFit.fill),
                    ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 100,),
                        Container(
                          child: Text("First Name:"),
                        ),
                        Container(
                          child: Center(
                            child: Text(Data["first name"],
                          ),
                        ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 100,),
                        Container(
                          child: Text("Secound Name:"),
                        ),
                        Container(
                          child: Center(
                            child: Text(Data["Secound name"],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 100,),
                        Container(
                          child: Text("Phone Number:"),
                        ),
                        Container(
                          height: 20,
                          width: 80,
                          child: Center(
                            child: Text(Data["phonenumber"]),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width:100,),
                        Container(
                          child: Text("Email:"),
                        ),
                        Container(
                          height: 20,
                          width: 150,
                          child: Center(
                            child: Text(Data["email"]),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 100,),
                        Container(
                          child: Text("Password:"),
                        ),
                        Container(
                          height: 20,
                          width: 70,
                          child: Center(
                            child: Text(Data["Password"]),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },);
            }
          else
            {
              return CircularProgressIndicator();
            }
        },
      ),
        floatingActionButton: FloatingActionButton(onPressed:() {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return update();
          },));
        },child: Icon(Icons.update),),
    );
  }
}
