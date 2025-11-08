import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/camera_page.dart';
import 'package:whatsapp_clone/screens/camera_screen.dart';
import 'package:whatsapp_clone/utils/color.dart';
import 'chat/chat_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  void initState(){
    super.initState();
    _tabController = TabController(length: 4, vsync:this, initialIndex: 1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WhatsApp",style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: Colors.white,)),
          PopupMenuButton<String>(
            onSelected: (value){
              debugPrint(value);
            },
            itemBuilder: (BuildContext context){
            return [

              const PopupMenuItem<String>(
                value: "New group",
                child: Text("New group"),
              ),
              const PopupMenuItem<String>(
                value: "New broadcast",
                child: Text("New broadcast"),
              ),
              const PopupMenuItem<String>(
                value: "Linked devices",
                child: Text("Linked devices"),
              ),
              const PopupMenuItem<String>(
                value: "Starred messages",
                child: Text("Starred messages"),
              ),
              const PopupMenuItem<String>(
                value: "Settings",
                child: Text("Settings"),
              ),
            ];
          },
          color: Colors.white,
          )
        ],
        bottom: TabBar(
          controller : _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white, // Color for the selected tab's text/icon
          unselectedLabelColor: Colors.white.withOpacity(0.7), // Color for unselected tabs' text/icon
          tabs: const [
            Tab(icon: Icon(Icons.camera_alt),),
            Tab(text: "CHATS",),
            Tab(text: "STATUS",),
            Tab(text: "CALLS",),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          CameraScreen(),
          CHatScreen(),
          Center(child: Text("Status Screen"),),
          Center(child: Text("Calls Screen"),),
        ],
      ),
    );
  }
}