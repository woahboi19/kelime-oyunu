import 'package:flutter/material.dart';
import 'skor.dart';

class YuksekSkorlar extends StatelessWidget {
  const YuksekSkorlar({super.key, required this.skorlar});

  final List<Skor> skorlar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: skorlar.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(
              "${index + 1}",
            ),
            title: Text(skorlar[index].skor.toString()),
          );
        },
      ),
    );
  }
}
