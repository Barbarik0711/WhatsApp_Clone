import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/chat_model.dart';
import 'package:whatsapp_clone/utils/color.dart';
import 'package:whatsapp_clone/widgets/avatar_card.dart';
import 'package:whatsapp_clone/widgets/button_card.dart';
import 'package:whatsapp_clone/widgets/contact_card.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: "Vishal", status: "Full Stack Developer"),
    ChatModel(name: "Vinay", status: "Full Stack Developer Brother"),
    ChatModel(name: "Prachi", status: "Full Stack Developer Sister"),
    ChatModel(name: "Vishal2", status: "Full Stack Developer"),
    ChatModel(name: "Vinay2", status: "Full Stack Developer Brother"),
    ChatModel(name: "Prachi2", status: "Full Stack Developer Sister"),  
  ];
  List<ChatModel> groups = [

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
            Text(
              "New Group",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text("Add Participants", style: TextStyle(fontSize: 13)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search, size: 26)),
        ],
      ),
      body: Stack(
        children: [ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            if (index==0){
              return Container(height: groups.length> 0 ? 90: 10,);
            }
            return InkWell(onTap: (){
              if(contacts[index-1].isCheck == false){
                setState(() {
                  contacts[index-1].isCheck = true;
                  groups.add(contacts[index-1]);
                });
              }
              else{
                setState(() {
                  contacts[index-1].isCheck = false;
                  groups.remove(contacts[index-1]);
                });
              }
              
            },child: ContactCard(contacts: contacts[index-1]));
          },
        ),
        groups.length > 0 ? Column(
          children: [
            Container(
              height: 75,
              color: Colors.white,
              child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: contacts.length,
              itemBuilder: (context,index) {
                if (contacts[index].isCheck == true){
                  return InkWell(onTap: (){
                    setState(() {
                      contacts[index].isCheck = false;
                      groups.remove(contacts[index]);
                    });
                  },child: AvatarCard(contact: contacts[index],));
                }
                else{
                  return Container();
                }
              }
              ),
            ),
            Divider(
              thickness: 1,
            )
          ],
        ) : Container()
        ],
      ),
    );
  }
}
