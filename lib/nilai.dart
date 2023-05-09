import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Mahasiswa {
  final String nim;
  final String nama;
  final String kelas;
  final String jurusan;
  final String kehadiran;
  final String tugas;
  final String uts;
  final String uas;
  Mahasiswa({
    required this.nim,
    required this.nama,
    required this.kelas,
    required this.jurusan,
    required this.kehadiran,
    required this.tugas,
    required this.uts,
    required this.uas,
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      nim: json['nim'],
      nama: json['nama'],
      kelas: json['kelas'],
      jurusan: json['jurusan'],
      kehadiran: json['kehadiran'],
      tugas: json['tugas'],
      uts: json['uts'],
      uas: json['uas'],
    );
  }
}

class Nilai extends StatefulWidget {
  @override
  _NilaiState createState() => _NilaiState();
}

class _NilaiState extends State<Nilai> {
  Dio dio = new Dio();
  List<Mahasiswa> listMahasiswa = [];
  TextEditingController _controllerNim = TextEditingController();
  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerkelas = TextEditingController();
  TextEditingController _controllerjurusan = TextEditingController();

  TextEditingController _controllerKehadiran = TextEditingController();
  TextEditingController _controllerTugas = TextEditingController();
  TextEditingController _controllerUts = TextEditingController();
  TextEditingController _controllerUas = TextEditingController();
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();

  Future<void> getMahasiswa() async {
    Response response;
    response =
        await dio.get("http://192.168.43.34/api-mahasiswa/list_nilai.php");
    if (response.data['status'] == 1) {
      // prdouble(response.data['info']);
      setState(() {
        listMahasiswa = [];
        for (int i = 0; i < response.data['info'].length; i++) {
          listMahasiswa.add(Mahasiswa(
            nim: response.data['info'][i]['nim'],
            nama: response.data['info'][i]['nama'],
            kelas: response.data['info'][i]['kelas'],
            jurusan: response.data['info'][i]['jurusan'],
            kehadiran: response.data['info'][i]['kehadiran'],
            tugas: response.data['info'][i]['tugas'],
            uts: response.data['info'][i]['uts'],
            uas: response.data['info'][i]['uas'],
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

  Future<void> insertMahasiswa() async {
    final response = await http.post(
      Uri.parse("http://192.168.43.34/api-mahasiswa/insertNilai.php"),
      body: {
        'nim': _controllerNim.text,
        'nama': _controllerNama.text,
        'kelas': _controllerkelas.text,
        'jurusan': _controllerjurusan.text,
        'kehadiran': _controllerKehadiran.text,
        'tugas': _controllerTugas.text,
        'uts': _controllerUts.text,
        'uas': _controllerUas.text,
      },
    );
    if (response.statusCode == 200) {
      getMahasiswa();
      setState(() {
        _controllerNim.clear();
        _controllerNama.clear();
        _controllerkelas.clear();
        _controllerjurusan.clear();
        _controllerKehadiran.clear();
        _controllerTugas.clear();
        _controllerUts.clear();
        _controllerUas.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('something went wrong'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    child: TextField(
                  controller: _controllerKehadiran,
                  decoration: InputDecoration(hintText: "Nilai Kehadiran"),
                )),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: TextField(
                  controller: _controllerTugas,
                  decoration: InputDecoration(hintText: "Nilai Tugas"),
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
                  controller: _controllerUts,
                  decoration: InputDecoration(hintText: "Nilai Uts"),
                )),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: TextField(
                  controller: _controllerUas,
                  decoration: InputDecoration(hintText: "Nilai Uas"),
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
            Text("Data Nilai Mahasiswa"),
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
                      var kehadiran = listMahasiswa[index].kehadiran;
                      var tugas = listMahasiswa[index].tugas;
                      var uts = listMahasiswa[index].uts;
                      var uas = listMahasiswa[index].uas;
                      double ratarata = double.parse(kehadiran) +
                          double.parse(tugas) +
                          double.parse(uts) +
                          double.parse(uas);
                      double hasil = ratarata / 4;
                      String rata = hasil.toString();
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
                              height: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Kehadiran Mhs"),
                                Text(listMahasiswa[index].kehadiran),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tugas Mhs"),
                                Text(listMahasiswa[index].tugas),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("UTS Mhs"),
                                Text(listMahasiswa[index].uts),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("UAS Mhs"),
                                Text(listMahasiswa[index].uas),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Text("nilai rata-rata"),
                                  Text(rata),
                                ],
                              ),
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
