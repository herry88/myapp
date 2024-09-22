import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/homepage.dart';

class EditPage extends StatefulWidget {
  List? list;
  int index;
  EditPage({super.key, this.list, required this.index});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController? controllerCode;
  TextEditingController? controllerName;
  TextEditingController? controllerPrice;
  TextEditingController? controllerStock;

  Future<void> updateData(
      int id, String itemcode, String itemname, double price, int stock) async {
    const url = 'https://adipramanacomputer.com/apiphp/edit.php';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'id': id.toString(),
        'item_code': itemcode,
        'item_name': itemname,
        'price': price.toString(),
        'stock': stock.toString(),
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] != null) {
        print('Success: ${data['success']}');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Homepage(),
          ),
        );
      } else if (data['error'] != null) {
        print('Error: ${data['error']}');
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void dispose() {
    controllerCode!.dispose();
    controllerName!.dispose();
    controllerPrice!.dispose();
    controllerStock!.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controllerCode =
        TextEditingController(text: widget.list![widget.index]['item_code']);
    controllerName =
        TextEditingController(text: widget.list![widget.index]['item_name']);
    controllerPrice = TextEditingController(
        text: widget.list![widget.index]['price'].toString());
    controllerStock = TextEditingController(
        text: widget.list![widget.index]['stock'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Page', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(
              children: [
                TextField(
                  controller: controllerCode,
                  decoration: const InputDecoration(
                    hintText: 'Item Code',
                    labelText: 'Item Code',
                  ),
                ),
                TextField(
                  controller: controllerName,
                  decoration: const InputDecoration(
                    hintText: 'Item Name',
                    labelText: 'Item Name',
                  ),
                ),
                TextField(
                  controller: controllerPrice,
                  decoration: const InputDecoration(
                    hintText: 'Price',
                    labelText: 'Price',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                TextField(
                  controller: controllerStock,
                  decoration: const InputDecoration(
                    hintText: 'Stock',
                    labelText: 'Stock',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    updateData(
                      widget.list![widget.index]['id'],
                      controllerCode!.text.trim(),
                      controllerName!.text.trim(),
                      double.parse(controllerPrice!.text.trim()),
                      int.parse(controllerStock!.text.trim()),
                    );
                  },
                  child: const Text('Update Data'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
