import 'package:flutter/material.dart';
import 'package:flutter_db/helpers/dbhelper.dart';
import 'package:flutter_db/pages/entryform.dart';
import 'package:sqflite/sqflite.dart';
import '../models/item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int count = 0;
  List<Item> itemList = [];

  @override
  void initState() {
    updateListView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Item',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: createListView(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              child: Text(
                'Tambah Item',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EntryForm(),
                  ),
                ).then((value) {
                  updateListView();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  ListView createListView() {
    TextStyle? textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) => Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.ad_units),
                ),
                title: Text(
                  itemList[index].name,
                  style: textStyle,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Harga: ${itemList[index].price.toString()}'),
                    Text('Stok: ${itemList[index].stok.toString()}'),
                    Text('Kode Barang: ${itemList[index].kodeBarang}'),
                  ],
                ),
                trailing: GestureDetector(
                  child: const Icon(Icons.delete),
                  onTap: () async {
                    deleteItem(itemList[index].id);
                  },
                ),
                onTap: () async {},
              ),
            ));
  }

  void deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    updateListView();
  }

  void updateListView() {
    final Future<Database> dbFuture = SQLHelper.db();
    dbFuture.then((database) {
      Future<List<Item>> itemListFuture = SQLHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          count = itemList.length;
          print(count.toString());
        });
      });
    });
  }
}
