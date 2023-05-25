import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatDemo extends StatefulWidget {
  const ChatDemo({Key? key}) : super(key: key);

  @override
  State<ChatDemo> createState() => _ChatDemoState();
}

class _ChatDemoState extends State<ChatDemo> {
  TextEditingController _controller = TextEditingController();
  var message = FirebaseFirestore.instance.collection("chat");
  var messages = FirebaseFirestore.instance
      .collection("chat")
      .orderBy('datatime', descending: false)
      .snapshots();
  var select = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat App")),
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: messages,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data;
                      return ListView.builder(
                        //  reverse: true,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index].data();
                          return data["sender_id"] == "HV3VGwZYzdvNtUwNXHPQ"
                              ? Text(
                                  textAlign: TextAlign.right,
                                  '${data['msg']}',
                                )
                              : Text(
                                  textAlign: TextAlign.left,
                                  '${data['msg']}',
                                );
                        },
                      );
                    } else {
                      return Text("No Text");
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            select == value;
                          });
                        },
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Text",
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkResponse(
                    onTap: () {
                      Map<String, dynamic> data = {
                        "sender_id": "lBnKY7qkD7Lu9TCTz5TB",
                        'msg': _controller.text,
                        "datatime": "${DateTime.now()}"
                      };
                      message.add(data);
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: select.isEmpty
                          ? Icon(Icons.send, color: Colors.blue)
                          : Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// chat
//
// datatime
//
// msg
//
// sender_id
