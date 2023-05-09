import 'package:flutter/material.dart';
import 'package:tugaswidget/widget1.dart';

class MyWidget3 extends StatefulWidget {
  @override
  State<MyWidget3> createState() => _MyWidget3State();
}

class _MyWidget3State extends State<MyWidget3> {
  int _currentIndex = 0;
  Widget StackTech(String alamat) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 50.0,
        height: 50.0,
        child: CircleAvatar(
          radius: 50.0, // Atur radius bulatan
          backgroundImage:
              AssetImage(alamat), // Tambahkan gambar sebagai latar belakang
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Profile Screen',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Icon(Icons.search, color: Colors.black)
          ],
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView(
        children: [
          Stack(
            children: <Widget>[
              // Widget utama
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 65, left: 10, right: 10),
                  height: 400,
                  width: 600,
                  color: Colors.deepPurple,
                  child: Column(children: [
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      'Nurul Aulia Septiani',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Flutter Developer',
                      style: TextStyle(fontSize: 20, color: Colors.yellow),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_pin, color: Colors.yellow),
                            Text('London',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white))
                          ],
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Row(
                          children: [
                            Icon(Icons.favorite, color: Colors.yellow),
                            Text('23.3k',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white))
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.link, color: Colors.yellow),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'www.nurulaulia.com',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StackTech('assets/instagram.jpg'),
                          StackTech('assets/twitter.jpg'),
                          StackTech('assets/youtube.jpg'),
                          StackTech('assets/linkedin.jpg'),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
              // Widget dengan posisi absolut
              Positioned(
                top: 20.0, // Atur posisi dari atas
                left: 0.0,
                right: 0.0,
                child: Center(
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    child: CircleAvatar(
                      radius: 50.0, // Atur radius bulatan
                      backgroundImage: AssetImage(
                          'assets/avatar.png'), // Tambahkan gambar sebagai latar belakang
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.purple,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Menyusun item secara merata
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.yellow),
              onPressed: () {
                // Aksi ketika tombol home ditekan
              },
            ), // Jarak antara item menggunakan SizedBox
            IconButton(
              icon: Icon(Icons.arrow_forward, color: Colors.yellow),
              onPressed: () {
                // Aksi ketika tombol settings ditekan
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Update indeks terpilih saat tab ditekan
    });
  }

  Widget _buildPage(int index) {
    // Fungsi untuk membangun halaman sesuai dengan indeks terpilih
    // Anda bisa menggantinya dengan widget-widget halaman yang diinginkan
    switch (index) {
      case 0:
        return MyWidget1();
      case 1:
        return MyWidget1();
      case 2:
      default:
        return MyWidget1();
    }
  }
}
