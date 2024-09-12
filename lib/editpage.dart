import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class EditPage extends StatefulWidget {
  List? list;
  int index;
  EditPage({this.list, required this.index});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController? controllerCode;
  TextEditingController? controllerName;
  TextEditingController? controllerPrice;
  TextEditingController? controllerStock;

  //function editData
  void editData() {
    var url = "http://192.168.100.109/backendflutter/editdata.php";
    http.post(Uri.parse(url), body: {
      "id": widget.list![widget.index]['id'],
      "item_code": controllerCode!.text,
      "item_name": controllerName!.text,
      "price": controllerPrice!.text,
      "stock": controllerStock!.text
    });
  }

  @override
  void initState() {
    controllerCode =
        TextEditingController(text: widget.list![widget.index]['item_code']);
    controllerName =
        TextEditingController(text: widget.list![widget.index]['item_name']);
    controllerPrice =
        TextEditingController(text: widget.list![widget.index]['price']);
    controllerStock =
        TextEditingController(text: widget.list![widget.index]['stock']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EditPage'),
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
                  decoration: InputDecoration(
                    hintText: 'Item Code',
                    labelText: 'Item Code',
                  ),
                ),
                TextField(
                  controller: controllerName,
                  decoration: InputDecoration(
                    hintText: 'Item Name',
                    labelText: 'Item Name',
                  ),
                ),
                TextField(
                  controller: controllerPrice,
                  decoration: InputDecoration(
                    hintText: 'Price',
                    labelText: 'Price',
                  ),
                ),
                TextField(
                  controller: controllerStock,
                  decoration: InputDecoration(
                    hintText: 'Stock',
                    labelText: 'Stock',
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    editData();
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => ViewData(),
                    //   ),
                    // );
                  },
                  child: Text(
                    'Update Data',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
