import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/chat_model.dart';
import 'package:whatsapp_clone/screens/select_contact.dart';
import 'package:whatsapp_clone/utils/color.dart';
import 'package:whatsapp_clone/widgets/chat_card.dart';

class CHatScreen extends StatefulWidget {
  const CHatScreen({super.key});

  @override
  State<CHatScreen> createState() => _CHatScreenState();
}

class _CHatScreenState extends State<CHatScreen> {
  List<ChatModel> chats= [
    ChatModel(
      name: "You",
      icon: "assets/svg/person.svg",
      isGroup: false,
      time: "12:00",
      currentMessage: "Hello there!",
    ),
    ChatModel(
      name: "Amma",
      icon: "assets/svg/person.svg",
      isGroup: false,
      time: "21:00",
      currentMessage: "Paunchli ka?",
    ),
    ChatModel(
      name: "Devs",
      icon: "assets/svg/group.svg",
      isGroup: true,
      time: "19:00",
      currentMessage: "This is a Group!",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (builder) => SelectContact() )
          );
        },
        backgroundColor: AppColors.accentColor,
        child: const Icon(Icons.message,color: Colors.white,),
        
      ),
      body: ListView.builder(
       itemCount: chats.length,
       itemBuilder: (context, index) => ChatCard(chatModel: chats[index]),
      ),
    );
    
  }
}