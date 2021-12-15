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
  late TextEditingController nameInput=TextEditingController();
  var firestoreDb = FirebaseFirestore.instance.collection("weights")
      .snapshots();

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
                      CustomCard(snapshot, index),
                    ],
                  );
                });
          }),
      bottomSheet: SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: RaisedButton(
          color: Colors.redAccent[200],
          child: Text("LOG OUT", style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),),
          onPressed: () {
            var result = FirebaseAuth.instance.signOut();
            Navigator.pop(context);
            print(result);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addItem(context);

        },
        backgroundColor: Colors.redAccent[400],
        child: Text("+",style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 44
        )),
      ),

    );
  }

  _addItem(BuildContext context) async {

    await showDialog(context: context, builder:(_)=>AlertDialog(
        contentPadding: EdgeInsets.all(10),
      content: Column(
        children: [
          Text("Please Enter the Weight"),
          Expanded(
            child: TextField(
              autocorrect: true,
              autofocus: true,
              decoration: InputDecoration(labelText: "Your Weight *"),
              controller: nameInput,
            ),
          ),

        ],
      ),
      actions: [
        FlatButton(
          onPressed: () =>
          {

            if (nameInput.text.isNotEmpty)
              {

                FirebaseFirestore.instance.collection("weights").add(
                    {
                      "weight":nameInput.text,
                      "timestamp":new DateTime.now()
                    }
                ).then((response) =>
                {
                  print("response.id successfull"),
                }),
              },
            Navigator.pop(context),
            nameInput.clear(),


          },
          child: Text("Save"),
        )
      ],

    ));
  }

}
