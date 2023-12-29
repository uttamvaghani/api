import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> map = [];
    late Welcome welcome;
    TextEditingController searchbar = TextEditingController();

    Getapi() async {
      final res = await http.get(Uri.parse("https://dummyjson.com/products"));
      // Getinlist=GetsearchFromJson(res.body) as List<Getsearch>;
      // return welcomeFromJson(res.body);
      welcome = Welcome.fromJson(jsonDecode(res.body));

      map.addAll(welcome.products);

      return map;
    }

    @override
    void initState() {
      Getapi();
      super.initState();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: searchbar,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search, color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.black),
                            borderRadius: BorderRadius.circular(50.0)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Colors.black), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1000,
              // color: Colors.blue,
              child: ListView.builder(
                itemCount: map.length,
                itemBuilder: (context, index) {
                  String name = map[index].title.toString();
                  if (searchbar.text.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            leading: Container(
                              width: 80,
                              height: 500,
                              color: Colors.white,
                              child: Image(
                                  image:
                                      NetworkImage("${map[index].thumbnail}"),
                                  fit: BoxFit.fill),
                            ),
                            subtitle: Container(
                                height: 100,
                                width: double.infinity,
                                child: FutureBuilder(
                                  future: Getapi(),
                                  builder: (context, snapshot) {
                                    var simm = map[index].id - 1;
                                    return Center(
                                      child: GridView.builder(
                                        itemCount: welcome
                                            .products[simm].images.length,
                                        itemBuilder: (context, sin) {
                                          return Image(
                                            image: NetworkImage(
                                                "${welcome.products[simm].images[sin]}"),
                                          );
                                        },
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 70,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10),
                                      ),
                                    );
                                  },
                                )),
                            title: Text(
                                "${map[index].title.toString()} prise:${map[index].price.toString()}"),
                          ),
                        ),
                      ),
                    );
                  } else if (name
                      .toLowerCase()
                      .toString()
                      .contains(searchbar.text.toLowerCase())) {
                    var simm = map[index].id - 1;
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            leading: Container(
                              width: 80,
                              height: 500,
                              color: Colors.white,
                              child: Image(
                                  image:
                                      NetworkImage("${map[index].thumbnail}"),
                                  fit: BoxFit.fill),
                            ),
                            subtitle: Container(
                                height: 100,
                                width: double.infinity,
                                child: Center(
                                  child: GridView.builder(
                                    itemCount:
                                        welcome.products[simm].images.length,
                                    itemBuilder: (context, sin) {
                                      return Image(
                                        image: NetworkImage(
                                            "${welcome.products[simm].images[sin]}"),
                                      );
                                    },
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 70,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10),
                                  ),
                                )),
                            title: Text(
                                "${map[index].title.toString()} prise:${map[index].price.toString()}"),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
