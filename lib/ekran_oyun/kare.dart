import 'dart:async';

import 'package:proje_kelime/ekran_oyun/harfler.dart';

class Kare {
int? x; 
int? y;
bool secili = false;
Harfler? harf;
Timer? timer;
Limit durum = Limit.normal;

Kare(this.x, this.y, this.harf,[this.timer]);
}

enum Limit{zeminde, ustunde, normal}