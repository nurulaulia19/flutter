import 'package:flutter/material.dart';

class MyWidget1 extends StatelessWidget {
  const MyWidget1({super.key});

  Widget ListAndroid(String txt1, String txt2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Text(txt1),
            SizedBox(
              height: 40,
            ),
          ]),
        ),
        Container(margin: EdgeInsets.only(right: 8), child: Text(txt2))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Flutter ListView'),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        children: [
          ListAndroid('Android Cupcake', 'Android Donut'),
          ListAndroid('Android Eclair', 'Android Froyo'),
          ListAndroid('Android Gingerbread', 'Android Honeycomb'),
          ListAndroid('Android Ice Cream Sandwitch', 'Android Jelly Bean'),
          ListAndroid('Android Kitkat', 'Android Lollipop'),
          ListAndroid('Android Marshmellow', 'Android Nougat'),
          ListAndroid('Android Oreo', 'Android Pie'),
        ],
      ),
    );
  }
}
