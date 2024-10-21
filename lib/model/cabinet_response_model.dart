import 'dart:convert';

class CabinetResponseModel {
  final List<DaftarKabinet>? daftarKabinet;

  CabinetResponseModel({
    this.daftarKabinet,
  });

  factory CabinetResponseModel.fromJson(String str) =>
      CabinetResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CabinetResponseModel.fromMap(Map<String, dynamic> json) =>
      CabinetResponseModel(
        daftarKabinet: json["daftar_kabinet"] == null
            ? []
            : List<DaftarKabinet>.from(
                json["daftar_kabinet"]!.map((x) => DaftarKabinet.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "daftar_kabinet": daftarKabinet == null
            ? []
            : List<dynamic>.from(daftarKabinet!.map((x) => x.toMap())),
      };
}

class DaftarKabinet {
  final String? id;
  final String? namaKabinet;
  final String? periode;
  final String? presiden;
  final String? wakilPresiden;
  final String? imagePresiden;
  final String? imageWakil;
  final List<AnggotaKabinet>? anggotaKabinet;

  DaftarKabinet({
    this.id,
    this.namaKabinet,
    this.periode,
    this.presiden,
    this.wakilPresiden,
    this.imagePresiden,
    this.imageWakil,
    this.anggotaKabinet,
  });

  factory DaftarKabinet.fromJson(String str) =>
      DaftarKabinet.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DaftarKabinet.fromMap(Map<String, dynamic> json) => DaftarKabinet(
        id: json["id"],
        namaKabinet: json["nama_kabinet"],
        periode: json["periode"],
        presiden: json["presiden"],
        wakilPresiden: json["wakil_presiden"],
        imagePresiden: json["image_presiden"],
        imageWakil: json["image_wakil"],
        anggotaKabinet: json["anggota_kabinet"] == null
            ? []
            : List<AnggotaKabinet>.from(
                json["anggota_kabinet"]!.map((x) => AnggotaKabinet.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nama_kabinet": namaKabinet,
        "periode": periode,
        "presiden": presiden,
        "wakil_presiden": wakilPresiden,
        "image_presiden": imagePresiden,
        "image_wakil": imageWakil,
        "anggota_kabinet": anggotaKabinet == null
            ? []
            : List<dynamic>.from(anggotaKabinet!.map((x) => x.toMap())),
      };
}

class AnggotaKabinet {
  final String? nama;
  final String? jabatan;
  final String? tanggalDilantik;
  final Profil? profil;

  AnggotaKabinet({
    this.nama,
    this.jabatan,
    this.tanggalDilantik,
    this.profil,
  });

  factory AnggotaKabinet.fromJson(String str) =>
      AnggotaKabinet.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AnggotaKabinet.fromMap(Map<String, dynamic> json) => AnggotaKabinet(
        nama: json["nama"],
        jabatan: json["jabatan"],
        tanggalDilantik: json["tanggal_dilantik"],
        profil: json["profil"] == null ? null : Profil.fromMap(json["profil"]),
      );

  Map<String, dynamic> toMap() => {
        "nama": nama,
        "jabatan": jabatan,
        "tanggal_dilantik": tanggalDilantik,
        "profil": profil?.toMap(),
      };
}

class Profil {
  final String? tempatLahir;
  final String? tanggalLahir;
  final String? pendidikan;
  final String? image;

  Profil({
    this.tempatLahir,
    this.tanggalLahir,
    this.pendidikan,
    this.image,
  });

  factory Profil.fromJson(String str) => Profil.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Profil.fromMap(Map<String, dynamic> json) => Profil(
        tempatLahir: json["tempat_lahir"],
        tanggalLahir: json["tanggal_lahir"],
        pendidikan: json["pendidikan"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "tempat_lahir": tempatLahir,
        "tanggal_lahir": tanggalLahir,
        "pendidikan": pendidikan,
        "image": image,
      };
}
