import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/editpage.dart';
import 'package:myapp/homepage.dart';

class DetailPage extends StatefulWidget {
  List? list;
  int index;
  DetailPage({super.key, this.list, required this.index});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  //function delete
  void deleteData() {
    var url = "https://adipramanacomputer.com/apiphp/delete.php";
    http.post(
      Uri.parse(url),
      body: {
        'id': widget.list![widget.index]['id'],
      },
    );
  }

  //function showDialog
  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
        'Are you Sure want to delete ${widget.list![widget.index]['item_name']} ?',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            deleteData();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Homepage(),
              ),
            );
          },
          child: const Text(
            'Ok Delete!',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "${widget.list![widget.index]["item_name"]}",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: 270.0,
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          //colors
          color: Colors.white,
          shadowColor: Colors.blue,
          child: Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 15.0,
                  ),
                ),
                Text(
                  widget.list![widget.index]['item_name'],
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Item Code : ${widget.list![widget.index]['item_code']}",
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "Price : ${widget.list![widget.index]['price']}",
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "Stock : ${widget.list![widget.index]['stock']}",
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditPage(
                                list: widget.list, index: widget.index),
                          ),
                        );
                      },
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        confirm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Icon(
                        Icons.delete,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
