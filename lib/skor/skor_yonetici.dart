import 'package:proje_kelime/skor/skor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkorYoneticisi {
  static final SkorYoneticisi _yonetici = SkorYoneticisi._();
  SkorYoneticisi._();
  factory SkorYoneticisi() => _yonetici;
  late final SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> skorEkle(int skor) async {
    List<Skor> skorlar = skorAl();
    String skorlarStr = "";
    skorlar.forEach((element) {
      skorlarStr += "${element.id},${element.skor};";
    });
    int id = skorlar.isEmpty ? 0 : int.parse(skorlar.last.id ?? "0");
    skorlarStr += "${id.toString()},$skor;";
    await prefs.setString("skorlar", skorlarStr);
  }

  List<Skor> skorAl() {
    String sonuclar = prefs.getString("skorlar") ?? "";
    List<Skor> skorlar = [];
    List<String> skorlarStr = sonuclar.split(";");
    if (skorlarStr.length > 0) {
      skorlarStr.removeLast();
    }
    skorlarStr.forEach((element) {
      skorlar
          .add(Skor(element.split(",")[0], int.parse(element.split(",")[1])));
    });
    return skorlar;
  }
}
