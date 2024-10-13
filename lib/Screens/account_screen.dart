import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  final TextStyle text1 = const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      wordSpacing: 1.2,
      decoration: TextDecoration.underline);
  Future<List<dynamic>> getAllAccounts() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/users'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        //print('data=${data.toString()}');
        return data;
      } else {
        throw Exception('error');
      }
    } catch (error) {
      throw error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Accounts'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: FutureBuilder(
          future: getAllAccounts(),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: const CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.tealAccent,
                            child: Center(
                                child: Icon(Icons.person,
                                    color: Colors.white, weight: 5, size: 47))),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Text(
                                snapshot.data!
                                    .toList()[index]['name']['firstname']
                                    .toString(),
                                style: text1,
                              ),
                              Text(
                                  snapshot.data!
                                      .toList()[index]['name']['lastname']
                                      .toString(),
                                  style: text1),
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            snapshot.data!.toList()[index]['email'].toString(),
                            style: const TextStyle(
                                wordSpacing: 1.2, letterSpacing: 1.2),
                          ),
                        ),
                        trailing: Text(
                          'Contact:- ${snapshot.data!.toList()[index]['phone']}',
                          style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 20),
                        ));
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
