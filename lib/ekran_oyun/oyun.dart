import 'package:flutter/material.dart';
import 'package:proje_kelime/ekran_oyun/oyun_alani.dart';

class EkranOyun extends StatefulWidget {
  const EkranOyun({super.key});

  @override
  State<EkranOyun> createState() => _EkranOyunState();
}

class _EkranOyunState extends State<EkranOyun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0,),body: Column(
      children: [
        Flexible(child: OyunAlani()),
      ],
    ));
  }
}