import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VeritabaniYardimcisi{
  static final String veritabaniAdi = "rehber.sqlite";

  //Veritabanına erişim yaptığımız fonksiyon.
  static Future<Database> vertabaniErisim() async{
    //Telefondaki veritabanı yolunu temsil ediyor. join ile veritabanının adıyla yoluna erişicez.
    String veritabaniYolu = join(await getDatabasesPath(), veritabaniAdi);

    //Daha önceden kopyalanmış bir veritabanı var mı kontrolü.
    if(await databaseExists(veritabaniYolu)){
      print("Veritabanı zaten var. Kopyalamaya gerek yok");
    }
    else{
      //Veritanabına eriştiğimiz kod.
      ByteData data = await rootBundle.load("veritabani/$veritabaniAdi");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(veritabaniYolu).writeAsBytes(bytes, flush: true);
      print("Veritabanı kopyalandı");
    }

    return openDatabase(veritabaniYolu);
  }

}