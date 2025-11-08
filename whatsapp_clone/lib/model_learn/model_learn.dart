import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone/model_learn/model/user_model.dart';
import 'package:whatsapp_clone/model_learn/model/username_model.dart';
import 'package:whatsapp_clone/model_learn/services/user_api.dart';

class ModelLearn extends StatefulWidget {
  const ModelLearn({super.key});

  @override
  State<ModelLearn> createState() => _ModelLearnState();
}

class _ModelLearnState extends State<ModelLearn> {
  List<UserModel> users = [];

  Future<void> fetchUsers() async {
    final response = await UserApi.fetchUsers();
    setState(() {
      users = response;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("REST API Calls"), // Added const
      ),
      body: users.isEmpty
          ? const Center(child: Text("Press the button to fetch users"))
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final name = user.fullName;
                final email = user.email;
                final color = user.gender == "male" ? Colors.blue : Colors.pink;
                final phone = user.phone;
                final country = user.location.country;
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  child: ListTile(
                    title: Text(name),
                    subtitle: Text(country),
                    tileColor: color,
                  ),
                );
              },
            ),
    );
  }
}
