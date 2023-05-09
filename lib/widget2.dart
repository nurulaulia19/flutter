import 'package:flutter/material.dart';

class MyWidget2 extends StatelessWidget {
  const MyWidget2({super.key});

  Widget Card(Color colorz, Image imagez, String txt) {
    return Expanded(
        flex: 1,
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Container(
            margin: EdgeInsets.all(2),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: imagez,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(txt)
              ],
            ),
            height: 250,
            color: colorz,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.menu),
            SizedBox(
              width: 12,
            ),
            Text('Silky Threads')
          ],
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        children: [
          Wrap(
            children: <Widget>[
              Card(Colors.green, Image.asset('assets/Earring.png'), 'Earring'),
              Card(Colors.yellow, Image.asset('assets/Bracelet.png'),
                  'Bracelet'),
              Card(Colors.red, Image.asset('assets/Necklace (1).png'),
                  'Necklace'),
              Card(Colors.orange, Image.asset('assets/Necklace.png'),
                  'Necklace'),
              Card(Colors.purple, Image.asset('assets/Rings.png'), 'Ring'),
              Card(Colors.pink, Image.asset('assets/Crown.png'), 'Crown'),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aksi yang ingin dijalankan ketika tombol ditekan
          print('Tombol ditekan');
        },
        child: Icon(Icons.camera_alt), // Icon yang ditampilkan pada tombol
        tooltip: 'Tambah', // Tooltip untuk tombol
      ),
    );
  }
}
