import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/model/chat_model.dart';
import 'package:whatsapp_clone/screens/chat/individual_chat_screen.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.chatModel});
  final ChatModel chatModel;
  
  @override
  Widget build(BuildContext context) {


    return InkWell(
      onTap: (){
        // Navigate to chat screen
        Navigator.push(context, 
        MaterialPageRoute(
          builder: (context) => IndividualChatScreen(chatModel: chatModel),
        ),
        );
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blueGrey,
              child: chatModel.isGroup! ?
              SvgPicture.asset("assets/svg/group.svg", color: Colors.white,height: 38,width: 38,)
              : SvgPicture.asset("assets/svg/person.svg", color: Colors.white,height: 38,width: 38,),
            ),
            title: Text(chatModel.name!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),),
            subtitle: Row(
              children: [
                Icon(Icons.done_all, size: 16, color: Colors.blue,),
                SizedBox(width: 5,),
                Text(chatModel.currentMessage!,),
              ],
            ),
            trailing: Text(chatModel.time!),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 85),
            child: const Divider(
              // indent: 85,
              // endIndent: 20,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}