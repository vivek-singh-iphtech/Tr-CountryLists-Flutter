import 'package:country_lists/controllers/countrylistcontroller.dart';
import 'package:country_lists/models/countrylistmodel.dart';
import 'package:country_lists/views/countrylistwebview.dart';
import 'package:flutter/material.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  final CountryListController controller = CountryListController();

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: controller.fetchData(),
          builder: (context, AsyncSnapshot<List<CountryModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<CountryModel>? item = snapshot.data;
              return ListView.builder(
                  itemCount: item?.length,
                  itemBuilder: (context, int index) {
                    CountryModel? country = item?[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: Color.fromARGB(255, 233, 248, 255),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                      
                              width: 2, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onTap: () {
                          _navigateToWebViewPage(country!);
                        },
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage(country?.image ?? "null problem"),
                        ),
                        title: Text(
                          country?.title ?? 'null problem',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          country?.subtitle ?? 'null problem',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 151, 155, 178),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }

  void _navigateToWebViewPage(CountryModel country) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WebViewPage(country)));
  }
}
