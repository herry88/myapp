import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:myapp/addpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //function get api
  Future getData() async {
    var url = Uri.parse('https://adipramanacomputer.com/apiphp/getdata.php');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
      // print('Response data: ${response.body}'); //debugging flutter
    } else {
      return jsonDecode(response.body);
      // print('Error: ${response.statusCode}'); //debugging flutter
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Halaman Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //material page route to add page
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddPage(),
            ),
          );
          print("tambah data");
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tooltip: 'Tambah Data',
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          //widget
          return snapshot.hasData
              ? ItemList(list: snapshot.data)
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<dynamic> list;
  const ItemList({required this.list, super.key});

  @override
  Widget build(BuildContext context) {
    //debug di console
    if (list.isEmpty) {
      return const Center(
        child: Text("Tidak Ada data di temukan"),
      );
    }

    print('List data: $list'); // Debug print
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            //Nanti dulu yee, klo ini bisa nanti di buatkan halaman detailnya
            print('Item tapped: ${list[index]['item_name']}');
          },
          child: Card(
            color: Colors.white,
            child: ListTile(
              title: Text(list[index]['item_name'] ?? 'Nama tidak tersedia'),
              subtitle: Text(
                  'Email: ${list[index]['item_code'] ?? 'Email tidak tersedia'}'),
            ),
          ),
        );
      },
    );
  }
}
