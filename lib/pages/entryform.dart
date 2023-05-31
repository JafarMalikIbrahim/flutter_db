import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/item.dart';
import 'package:flutter_db/helpers/dbhelper.dart';

class EntryForm extends StatefulWidget {
  const EntryForm({
    Key? key,
    Item? item,
  }) : super(key: key);
  @override
  State<EntryForm> createState() => EntryFormState();
}

class EntryFormState extends State<EntryForm> {
  Item item = Item(name: '', price: 0, stok: 0, kodeBarang: '');
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stokController = TextEditingController();
  TextEditingController kodeBarangController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (item.name == '') {
      nameController.text = item.name;
      priceController.text = item.price.toString();
      stokController.text = item.stok.toString();
      kodeBarangController.text = item.kodeBarang;
    }
    return Scaffold(
      appBar: AppBar(
        title: item.name == '' ? const Text('Tambah') : const Text('Ubah'),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: <Widget>[
          // Nama Barang
          SizedBox(
            height: 80,
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Nama Barang',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                // TODO: Method untuk form nama barang
              },
            ),
          ),
          SizedBox(height: 16),
          // Harga Barang
          SizedBox(
            height: 80,
            child: TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Harga Barang',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                // TODO: Method untuk form harga barang
              },
            ),
          ),
          SizedBox(height: 16),
          // Stok Barang
          SizedBox(
            height: 80,
            child: TextField(
              controller: stokController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Stok Barang',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                // TODO: Method untuk form stok barang
              },
            ),
          ),
          SizedBox(height: 16),
          // Kode Barang
          SizedBox(
            height: 80,
            child: TextField(
              controller: kodeBarangController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Kode Barang',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                // TODO: Method untuk form kode barang
              },
            ),
          ),
          SizedBox(height: 32),
          // Tombol Simpan dan Batal
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (item.name == '') {
                      print('database');
                      // Tambah data
                      item = Item(
                        name: nameController.text,
                        price: int.parse(priceController.text),
                        stok: int.parse(stokController.text),
                        kodeBarang: kodeBarangController.text,
                      );
                      final Future<Database> dbFuture = SQLHelper.db();
                      Future<int> id = SQLHelper.createItem(item);
                      print(id);
                    } else {
                      // Ubah data
                      item.name = nameController.text;
                      item.price = int.parse(priceController.text);
                      item.stok = int.parse(stokController.text);
                      item.kodeBarang = kodeBarangController.text;
                    }
                    print('Disini Datanya');
                    // Kembali ke layar sebelumnya dengan membawa objek it
                    print(item.name);
                    Navigator.pop(context, item);
                  },
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
