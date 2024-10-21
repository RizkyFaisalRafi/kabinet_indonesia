import 'package:flutter/material.dart';

import '../model/cabinet_response_model.dart';

class HomeProvider extends ChangeNotifier {
  Future<List<DaftarKabinet>> loadCabinets(
    BuildContext context,
  ) async {
    final jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/local_kabinet.json');

    final cabinetModel = CabinetResponseModel.fromJson(jsonString);
    return cabinetModel.daftarKabinet ?? [];
  }
}
