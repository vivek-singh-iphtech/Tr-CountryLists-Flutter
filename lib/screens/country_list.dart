import 'package:flutter/material.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Country Lists",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: 2,
              itemBuilder: (BuildContext, int index) {
                return const ListTile(
                    leading: CircleAvatar(
                  backgroundImage: AssetImage('images/india.png'),
                ));
              }),
        ),
      ),
    );
  }
}
