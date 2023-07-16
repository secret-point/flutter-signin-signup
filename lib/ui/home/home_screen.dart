import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:soultrain/ui/Welcome/welcome_screen.dart';
import 'package:soultrain/constants/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  ListItemState createState() => ListItemState();
}

class ListItemState extends State<HomeScreen> {
  final int listLength = 30;
  late List<String> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  void dispose() {
    users.clear();
    super.dispose();
  }

  void fetchUsers() async {
    final uri = Uri.parse('${Constants.apiUrl}/users');
    Response response = await get(uri, headers: Constants.apiHeader);
    final body = jsonDecode(response.body);
    setState(() {
      users = List<String>.from(body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("UserList"),
          automaticallyImplyLeading: false,
          backgroundColor: Constants.kPrimaryColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const WelcomeScreen();
                  }),
                  ModalRoute.withName('/'),
                );
              },
            ),
          ],
        ),
        body: ListBuilder(
          isSelectionMode: false,
          selectedList: users,
          onSelectionChange: (bool x) {},
        ));
  }
}

class ListBuilder extends StatefulWidget {
  const ListBuilder({
    super.key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  });

  final bool isSelectionMode;
  final List<String> selectedList;
  final Function(bool)? onSelectionChange;

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.selectedList.length,
        itemBuilder: (_, int index) {
          return ListTile(
              onTap: () => _toggle(index),
              leading: const Icon(Icons.person),
              title: Text(widget.selectedList[index]));
        });
  }
}
