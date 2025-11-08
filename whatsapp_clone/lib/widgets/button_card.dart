import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/model/chat_model.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({super.key , required this.name, required this.icon });
  
  final String name;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 23,
        child: Icon(icon,color: Colors.white,),
        backgroundColor: Color(0xFF25D366),
      ),
      title: Text(name ,style: TextStyle(
        fontWeight: FontWeight.bold,
      ),),
      // subtitle: Text(s!, style: TextStyle(
      //   fontSize: 13,
      // ),),
    
    );
  }
}