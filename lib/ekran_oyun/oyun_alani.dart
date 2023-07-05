import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proje_kelime/main.dart';
import 'package:proje_kelime/skor/skor_yonetici.dart';

import 'kare.dart';

import 'harfler.dart';

class OyunAlani extends StatefulWidget {
  const OyunAlani({super.key});

  @override
  State<OyunAlani> createState() => _OyunAlaniState();
}

class _OyunAlaniState extends State<OyunAlani> {
  GlobalKey _oyunAlaniKey = GlobalKey();
  late final double kareWidth;
  List<Kare> kareler = [];
  List<Kare> seciliKareler = [];
  Timer? anaTimer;
  int skor = 0;
  int hata = 0;
  late final List<String> sozluk;
  bool yuklenme = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sozlukHazirla();
    Future.delayed(Duration(seconds: 1)).then((value) => giris());
  }

  void sozlukHazirla() async {
    var data = await rootBundle.loadString("assets/sozluk.csv");
    sozluk = data.split("\n");
    setState(() {
      yuklenme = false;
    });
  }

  void giris() {
    RenderBox renderBox =
        _oyunAlaniKey.currentContext?.findRenderObject() as RenderBox;
    kareWidth = renderBox.size.width / 8;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 8; j++) {
        Random random = Random();
        int harfind = random.nextInt(Harfler.values.length);
        Kare bosKare = Kare(j, -i, Harfler.values[harfind]);
        bosKare.timer = Timer.periodic(Duration(milliseconds: 100),
            (timer) => kareHareket(timer, bosKare));
        kareler.add(bosKare);
      }
    }
    Future.delayed(Duration(seconds: 1)).then((value) {
      anaTimer =
          Timer.periodic(Duration(seconds: 5), (timer) => yeniBlok(timer));
    });
  }

  void yeniBlok(Timer timer) {
    Random random = Random();
    int harfind = random.nextInt(Harfler.values.length);
    int rand = random.nextInt(8);
    Kare bosKare = Kare(rand, -1, Harfler.values[harfind]);
    bosKare.timer = Timer.periodic(
        Duration(milliseconds: 100), (timer) => kareHareket(timer, bosKare));
    kareler.add(bosKare);
  }

  void hataCiz() {
    for (int j = 0; j < 8; j++) {
      Random random = Random();
      int harfind = random.nextInt(Harfler.values.length);
      Kare bosKare = Kare(j, -1, Harfler.values[harfind]);
      bosKare.timer = Timer.periodic(
          Duration(milliseconds: 100), (timer) => kareHareket(timer, bosKare));
      kareler.add(bosKare);
    }
  }

  void kareHareket(Timer timer, Kare kare) {
    setState(() {
      if (!kontrolZemin(kare)) {
        if (!kontrolUst(kare)) {
          kare.y = kare.y! + 1;
        } else {
          kare.durum = Limit.ustunde;
        }
      } else {
        kare.durum = Limit.zeminde;
      }
      if (kare.durum == Limit.ustunde && kare.y == 0) {
        anaTimer?.cancel();
        kareler.forEach((element) {
          element.timer?.cancel();
        });
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            SkorYoneticisi().skorEkle(skor);
            return AlertDialog(
              title: Text("Oyun Bitti"),
              content: Text("$skor"),
              actions: [
                TextButton(
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EkranAna(),
                        )),
                    child: Text("Ana Menü'ye dön"))
              ],
            );
          },
        );
      }
    });
  }

  bool kontrolZemin(Kare kare) {
    return (kare.y ?? 0) == 9;
  }

  bool kontrolUst(Kare kare) {
    for (var element in kareler) {
      int x = kare.x ?? 0;
      int y = kare.y ?? 0;
      if (x == element.x && y + 1 == element.y) return true;
    }
    return false;
  }

  Positioned kareCiz(Kare kare) {
    return Positioned(
        top: kare.y! * kareWidth,
        left: kare.x! * kareWidth,
        child: GestureDetector(
            onTap: () {
              setState(() {
                if (!kare.secili) {
                  seciliKareler.add(kare);
                  kare.secili = true;
                }
              });
            },
            child: Container(
                width: kareWidth,
                height: kareWidth,
                color: kare.secili ? Colors.amberAccent : Colors.greenAccent,
                child: Center(child: Text(kare.harf?.harf ?? "")))));
  }

  Widget kareYigin() {
    List<Positioned> kareCizilen = [];
    kareler.forEach((element) {
      kareCizilen.add(kareCiz(element));
    });
    return Stack(children: kareCizilen);
  }

  Text girilenKelime() {
    String kelime = "";
    seciliKareler.forEach((element) {
      kelime = "$kelime${element.harf?.harf ?? ""}";
    });
    return Text(kelime);
  }

  @override
  Widget build(BuildContext context) {
    return yuklenme
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.velocity.pixelsPerSecond.dx > 150) {
                kontrolKelime();
              }
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Skor: $skor"),
                      Text("Hata: $hata"),
                    ],
                  ),
                ),
                AspectRatio(
                  child: Container(
                      color: Colors.blueAccent,
                      key: _oyunAlaniKey,
                      child: kareYigin()),
                  aspectRatio: 8 / 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child: girilenKelime()),
                      IconButton(
                        onPressed: kontrolKelime,
                        icon: Icon(Icons.check),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            seciliKareler.last.secili = false;
                            seciliKareler.removeLast();
                          });
                        },
                        icon: Icon(Icons.backspace),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }

  void kontrolKelime() {
    setState(() {
      String girilenKlm = "";
      seciliKareler.forEach((element) {
        girilenKlm += element.harf?.harf ?? "";
      });
      print(girilenKlm);
      var liste = sozluk.where((element) {
        return element.toUpperCase() == girilenKlm.toUpperCase();
      });
      if (liste.isNotEmpty) {
        seciliKareler.forEach((element) {
          skor += element.harf?.puan ?? 0;
          kareler.remove(element);
        });
        seciliKareler.clear();
      } else {
        hata++;
        if (hata == 3) {
          hataCiz();
          hata = 0;
        }
      }
    });
  }
}
