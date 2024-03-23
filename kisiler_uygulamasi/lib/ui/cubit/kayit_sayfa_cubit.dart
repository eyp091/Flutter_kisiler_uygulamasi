import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/data/repo/kisilerdao_repository.dart';

class KayitSayfaCubit extends Cubit<void>{
  KayitSayfaCubit():super(0);

  var krepo = KisilerDaoRepository();

  Future<void> kaydet(String kisi_adi, String kisi_tel) async {
    await krepo.kaydet(kisi_adi, kisi_tel);
  }
}