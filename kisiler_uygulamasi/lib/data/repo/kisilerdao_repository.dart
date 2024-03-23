import 'package:kisiler_uygulamasi/sqlite/veritabani_yardimcisi.dart';

import '../entity/kisiler.dart';

class KisilerDaoRepository{
  Future<void> kaydet(String kisi_adi, String kisi_tel) async {
    var db = await VeritabaniYardimcisi.vertabaniErisim();
    var yeniKisi = Map<String, dynamic>();
    yeniKisi["kisi_ad"] = kisi_adi;
    yeniKisi["kisi_tel"] = kisi_tel;
    await db.insert("kisiler", yeniKisi);
  }

  Future<void> guncelle(int kisi_id, String kisi_adi, String kisi_tel) async {
    var db = await VeritabaniYardimcisi.vertabaniErisim();
    var guncellenenKisi = Map<String, dynamic>();
    guncellenenKisi["kisi_ad"] = kisi_adi;
    guncellenenKisi["kisi_tel"] = kisi_tel;
    await db.update("kisiler", guncellenenKisi, where: "kisi_id = ?", whereArgs: [kisi_id]);
  }

  Future<List<Kisiler>> kisileriYukle() async {
    var db = await VeritabaniYardimcisi.vertabaniErisim();
    // Veri tabanındaki nesneleri "hash,map" olarak alır.
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM kisiler");

    // Maps'in uzunluğu kadar bu listeyi döndürür.
    return List.generate(maps.length, (index) {
      var satir = maps[index];

      // Null kontrolü ekleyelim
      if (satir != null) {
        return Kisiler(
          kisi_id: satir["kisi_id"] ?? 0, kisi_ad: satir["kisi_ad"] ?? "", kisi_tel: satir["kisi_tel"] ?? "",
        );
      } else {
        // Eğer satır null ise, bir hata oluşmuş olabilir,Bu örnek için sadece boş bir List döndürelim.
        return Kisiler(
          kisi_id: 0, kisi_ad: "", kisi_tel: "",
        );
      }
    });
  }


  Future<List<Kisiler>> ara(String aramaKelimesi) async{
    var db = await VeritabaniYardimcisi.vertabaniErisim();
    // Veri tabanındaki nesneleri "hash,map" olarak alır.
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM kisiler WHERE kisi_ad like '%$aramaKelimesi%'");

    // Maps'in uzunluğu kadar bu listeyi döndürür.
    return List.generate(maps.length, (index) {
      var satir = maps[index];

      // Null kontrolü ekleyelim
      if (satir != null) {
        return Kisiler(
          kisi_id: satir["kisi_id"] ?? 0, kisi_ad: satir["kisi_ad"] ?? "", kisi_tel: satir["kisi_tel"] ?? "",
        );
      } else {
        return Kisiler(
          kisi_id: 0, kisi_ad: "", kisi_tel: "",
        );
      }
    });
  }

  Future<void> sil(int kisi_id) async {
    var db = await VeritabaniYardimcisi.vertabaniErisim();
    await db.delete("kisiler", where: "kisi_id = ?", whereArgs: [kisi_id]);
  }
}