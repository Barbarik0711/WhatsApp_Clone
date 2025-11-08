import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/chat_model.dart';
import 'package:whatsapp_clone/screens/create_group.dart';
import 'package:whatsapp_clone/utils/color.dart';
import 'package:whatsapp_clone/widgets/button_card.dart';
import 'package:whatsapp_clone/widgets/contact_card.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<ChatModel> contacts = [
    ChatModel(name: "Vishal", status: "Full Stack Developer"),
    ChatModel(name: "Vinay", status: "Full Stack Developer Brother"),
    ChatModel(name: "Prachi", status: "Full Stack Developer Sister"),
    ChatModel(name: "Vishal2", status: "Full Stack Developer"),
    ChatModel(name: "Vinay2", status: "Full Stack Developer Brother"),
    ChatModel(name: "Prachi2", status: "Full Stack Developer Sister")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Contact", style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),), Text("256Contacts",style: TextStyle(
              fontSize: 13,
              
            ),)
          ],
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search, size: 26,)),
          PopupMenuButton<String>(
            onSelected: (value) {
              debugPrint(value);
            },
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem<String>(
                  value: "Invite a Friend",
                  child: Text("Invite a Friend"),
                ),
                PopupMenuItem<String>(
                  value: "Contacts",
                  child: Text("Contacts"),
                ),
                PopupMenuItem<String>(
                  value: "Refresh",
                  child: Text("Refresh"),
                ),
                PopupMenuItem<String>(
                  value: "Help",
                  child: Text("Help"),
                ),
              ];
            },
            color: Colors.white,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length+2,
        itemBuilder: (context,index) {
          if(index==0){
            return InkWell(
              onTap:() {
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>CreateGroup()));
              },
              child: ButtonCard(
                icon : Icons.group,
                name : "New Group",
              ),
            );
          }
          else if(index==1){ 
            return ButtonCard(icon : Icons.person_add,
              name : "New Contact",);
          }
          else{
            return ContactCard(contacts: contacts[index-2]);
          }
        },
        ),
      
    );
  }
}