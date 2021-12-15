import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_tracker/store/customCard.dart';
import 'package:simple_tracker/authentication/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
class WeightsApp extends StatefulWidget {
  const WeightsApp({Key? key}) : super(key: key);

  @override
  _WeightsAppState createState() => _WeightsAppState();
}

class _WeightsAppState extends State<WeightsApp> {
  var firestoreDb = FirebaseFirestore.instance.collection("weights").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.redAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.redAccent[400],
        title: Text("Body Weights"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestoreDb,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, int index) {
                  return Column(
                    children: [
                      CustomCard(snapshot,index),
                    ],
                  );
                });
          }),
      bottomSheet:SizedBox(
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          color: Colors.redAccent[200],
          child:Text("LOG OUT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          onPressed: (){
            var result =FirebaseAuth.instance.signOut();
            Navigator.pop(context);
            print(result);
          },
        ),
      )

    );
  }
}
