import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/model/chat_model.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key , required this.contacts});
  final ChatModel contacts;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        child: Stack(
          children:[ CircleAvatar(
            radius: 23,
            child: SvgPicture.asset("assets/svg/person.svg",color: Colors.white, height: 30, width: 30,),
            backgroundColor: Colors.blueGrey[200],
          ),
          contacts.isCheck! ? Positioned(bottom:4,right:5, child:  CircleAvatar(backgroundColor:Colors.teal,radius: 11,child:  Icon(Icons.check,color: Colors.white,size: 18,))) : Container(),
          ],
        ),
      ),
      title: Text(contacts.name! ,style: TextStyle(
        fontWeight: FontWeight.bold,
      ),),
      subtitle: Text(contacts.status!, style: TextStyle(
        fontSize: 13,
      ),),
    
    );
  }
}