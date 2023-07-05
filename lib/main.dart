import 'package:flutter/material.dart';
import 'package:proje_kelime/ekran_oyun/oyun.dart';
import 'package:proje_kelime/skor/skor_yonetici.dart';
import 'package:proje_kelime/skor/yuksek_skor.dart';
import 'skor/skor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SkorYoneticisi().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: EkranAna(),
    );
  }
}

class EkranAna extends StatelessWidget {
  const EkranAna({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EkranOyun(),
                  ));
                },
                child: Text("Oyna")),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
                onPressed: () {
                  List<Skor> skorlar = SkorYoneticisi().skorAl();
                  skorlar.sort(
                    (a, b) => (b.skor ?? 0).compareTo(a.skor ?? 0),
                  );
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => YuksekSkorlar(skorlar: skorlar),
                  ));
                },
                child: Text("Yüksek Skorlar")),
          ],
        ),
      ),
    );
  }
}
