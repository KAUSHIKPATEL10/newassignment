import 'dart:convert';
import 'package:newassignment/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Hit"),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final id = users[index];
            final title = id.name;
            final description = id.description;

            return ListTile(
              title: Text(title),
              subtitle: Text(description),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: FetchData,
      ),
    );
  }

  void FetchData() async {
    const url = 'https://dummyapi.online/api/products';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);


    final res=json['products'] as List<dynamic>;
    final data=res.map((e)  {
      return User(
        name: e['name'],
        description: e['description'],
        image: e['image']

      );
    }).toList();

    setState(() {
      users = data;
    });
  }


}
