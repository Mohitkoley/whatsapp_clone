import "package:flutter/material.dart";
import 'package:whatsapp_clone/colors.dart';

class WebSearchBar extends StatelessWidget {
  WebSearchBar({Key? key}) : super(key: key);
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.077,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: dividerColor))),
        child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
                filled: true,
                fillColor: searchBarColor,
                prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.search)),
                hintStyle: TextStyle(fontSize: 13),
                hintText: "Search or start a new chat",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ))));
  }
}
