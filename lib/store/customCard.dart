import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:simple_tracker/authentication/sign_in.dart';

class CustomCard extends StatelessWidget {
  final AsyncSnapshot snapshot;
  late TextEditingController nameInputController = new TextEditingController();
  var index;

  CustomCard(this.snapshot, this.index);


  @override
  Widget build(BuildContext context) {
    var snapshotData = snapshot.data!.docs[index];
    String __id= snapshot.data.docs[index].id;
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("weights").doc(__id);
    var timeToDate = new DateTime.fromMicrosecondsSinceEpoch(
        snapshotData['timestamp'].seconds * 1000);
    var dateFormatted = new DateFormat("EEEE, MM d,y").format(timeToDate);
    return Column(
      children: [
        Column(
          children: [
            Container(
              height: 150,
              child: Card(
                elevation: 11,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(snapshotData['weight']),
                      subtitle: Text(dateFormatted),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 18,
                        ),
                        RaisedButton(
                          onPressed: () {
                            __showDialog(context, documentReference);
                          },
                          child: Text("edit"),
                        ),
                        SizedBox(
                          width: 118,
                        ),
                        RaisedButton(
                          onPressed: () async {
                            String _id = snapshot.data.docs[index].id;
                            //debugPrint(FirebaseFirestore.instance.collection("weights").doc('$index').toString());
                            //await FirebaseFirestore.instance.collection("weights").doc(_id).delete().then((value) => print("deleted"));
                          },
                          child: Text("delete"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  __showDialog(BuildContext context,
      DocumentReference documentReference) async {
    await showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              contentPadding: EdgeInsets.all(10),
              content: Column(
                children: [

                  Text("Please Enter the Weight"),
                  Expanded(
                    child: TextField(
                      autocorrect: true,
                      autofocus: true,
                      decoration: InputDecoration(labelText: "Your Weight *"),
                      controller: nameInputController,
                    ),
                  ),

                ],
              ),

              actions: [
                FlatButton(
                  onPressed: () =>
                  {

                    if (nameInputController.text.isNotEmpty)
                      {

                        documentReference.update(
                            {
                              "weight":nameInputController.text,
                              "timestamp":new DateTime.now()
                            }
                        ).then((response) =>
                        {
                          print("response.id successfull"),
                        }),
                      },
                    Navigator.pop(context),
                    nameInputController.clear(),


                  },
                  child: Text("Save"),
                )
              ],
            ));
  }
}
