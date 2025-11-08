import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model_learn/model/userdob_model.dart';
import 'package:whatsapp_clone/model_learn/model/userlocation_model.dart';
import 'package:whatsapp_clone/model_learn/model/username_model.dart';

class UserModel {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final UserName name;
  final UserDOB dob;
  final UserLocation location;
  UserModel({
    required this.gender,
    required this.email,
    required this.phone,
    required this.cell,
    required this.nat,
    required this.name,
    required this.dob,
    required this.location,
  });

  factory UserModel.fromMap(Map<String, dynamic> peruser) {
    final name = UserName.fromMap(peruser['name']);

    final dob = UserDOB.fromMap(peruser['dob']);

    final location = UserLocation.fromMap(peruser['location']);
    return UserModel(
      gender: peruser['gender'],
      email: peruser['email'],
      phone: peruser['phone'],
      cell: peruser['cell'],
      nat: peruser['nat'],
      name: name,
      dob: dob,
      location: location,
    );
  }

  String get fullName {
    return '${name.title} ${name.first} ${name.last}';
  }
}
