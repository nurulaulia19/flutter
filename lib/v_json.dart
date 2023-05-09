import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Mahasiswa {
  final String nim;
  final String nama;
  final String kelas;
  final String jurusan;
  Mahasiswa(
      {required this.nim,
      required this.nama,
      required this.kelas,
      required this.jurusan});

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      nim: json['nim'],
      nama: json['nama'],
      kelas: json['kelas'],
      jurusan: json['jurusan'],
    );
  }
}

class ViewJson extends StatefulWidget {
  @override
  _ViewJsonState createState() => _ViewJsonState();
}

class _ViewJsonState extends State<ViewJson> {
  Dio dio = new Dio();
  List<Mahasiswa> listMahasiswa = [];
  TextEditingController _controllerNim = TextEditingController();
  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerkelas = TextEditingController();
  TextEditingController _controllerjurusan = TextEditingController();
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();

  Future<void> getMahasiswa() async {
    Response response;
    response =
        await dio.get("http://192.168.43.34/api-mahasiswa/list_mahasiswa.php");
    if (response.data['status'] == 1) {
      // print(response.data['info']);
      setState(() {
        listMahasiswa = [];
        for (int i = 0; i < response.data['info'].length; i++) {
          listMahasiswa.add(Mahasiswa(
            nim: response.data['info'][i]['nim'],
            nama: response.data['info'][i]['nama'],
            kelas: response.data['info'][i]['kelas'],
            jurusan: response.data['info'][i]['jurusan'],
          ));
        }
      });
    }
  }

  @override
  void initState() {
    getMahasiswa();
    super.initState();
  }

  //       if (data['status'] == 1) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('Data berhasil disimpan'),
  //             duration: Duration(seconds: 2),
  //           ),
  //         );
  //         setState(() {
  //           _controllerNim.clear();
  //           _controllerNama.clear();
  //           _controllerkelas.clear();
  //           _controllerjurusan.clear();
  //           getMahasiswa();
  //         });
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(data['nim']),
  //           ),
  //         );
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Terjadi kesalahan saat menyimpan data'),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Terjadi kesalahan saat menyimpan data'),
  //       ),
  //     );
  //   }
  // }

  Future<void> insertMahasiswa() async {
    try {
      final response = await dio.post(
        "http://192.168.43.34/api-mahasiswa/insert.php",
        data: {
          'nim': _controllerNim.text,
          'nama': _controllerNama.text,
          'kelas': _controllerkelas.text,
          'jurusan': _controllerjurusan.text,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        if (data['status'] == 1) {
          getMahasiswa();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Data berhasil disimpan'),
              duration: Duration(seconds: 2),
            ),
          );
          setState(() {
            _controllerNim.clear();
            _controllerNama.clear();
            _controllerkelas.clear();
            _controllerjurusan.clear();
            getMahasiswa();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Terjadi kesalahan: ${data['message']}'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan saat menyimpan data'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan saat menyimpan data'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text("Parsing Json"),
      ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            Text("Form Input"),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    child: TextField(
                  controller: _controllerNim,
                  decoration: InputDecoration(hintText: "Nim"),
                )),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: TextField(
                  controller: _controllerkelas,
                  decoration: InputDecoration(hintText: "Kelas"),
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    child: TextField(
                  controller: _controllerNama,
                  decoration: InputDecoration(hintText: "Nama Mhs"),
                )),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: TextField(
                  controller: _controllerjurusan,
                  decoration: InputDecoration(hintText: "Jurusan"),
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                insertMahasiswa();
              },
              child: Text(
                "Simpan",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 29,
            ),
            Text("Data Mahasiswa"),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            listMahasiswa.length == null
                ? Center(
                    child: Text("Data Kosong"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: listMahasiswa.length,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Nim Mhs"),
                                Text(listMahasiswa[index].nim),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Nama Mhs"),
                                Text(listMahasiswa[index].nama),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Kelas Mhs"),
                                Text(listMahasiswa[index].kelas),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Jurusan Mhs"),
                                Text(listMahasiswa[index].jurusan),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 2,
                            ),
                          ],
                        ),
                      );
                    })
          ],
        ),
      ),
    );
  }
}
