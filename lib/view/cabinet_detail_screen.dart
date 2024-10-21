import 'package:flutter/material.dart';
import 'package:kabinet_indonesia/components/spaces.dart';
import 'package:kabinet_indonesia/constants/theme.dart';
import 'package:kabinet_indonesia/model/cabinet_response_model.dart';

class CabinetDetailScreen extends StatelessWidget {
  final DaftarKabinet daftarKabinet;

  const CabinetDetailScreen({
    super.key,
    required this.daftarKabinet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cabinet Detail',
          style: fontJakartaSans.copyWith(
            fontSize: fontExtra,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(defaultMargin),
        children: [
          // Header
          _buildHeader(context),

          const SpaceHeight(12),

          // Anggota Kabinet
          Text(
            'Anggota Kabinet',
            style: fontJakartaSans.copyWith(
              fontSize: fontExtra,
              fontWeight: semiBold,
            ),
          ),

          // List Anggota Kabinet
          if (daftarKabinet.anggotaKabinet != null &&
              daftarKabinet.anggotaKabinet!.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: daftarKabinet.anggotaKabinet!.length,
              itemBuilder: (context, index) {
                final anggota = daftarKabinet.anggotaKabinet![index];
                return _buildAnggotaKabinetCard(context, anggota);
              },
            ),

          if (daftarKabinet.anggotaKabinet == null &&
              daftarKabinet.anggotaKabinet!.isEmpty)
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text('Tidak ada anggota kabinet yang tersedia.'),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // Photo Presiden & Wakil
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPhoto(context, daftarKabinet.imagePresiden ?? 'Null'),
              const SpaceWidth(12),
              _buildPhoto(context, daftarKabinet.imageWakil ?? 'Null'),
            ],
          ),
          const SpaceHeight(20),
          // Presiden Name
          _buildTitleAndContent('Presiden', daftarKabinet.presiden ?? 'N/A'),
          const SpaceHeight(8),
          // Wakil Presiden Name
          _buildTitleAndContent(
              'Wakil Presiden', daftarKabinet.wakilPresiden ?? 'N/A'),
        ],
      ),
    );
  }

  Widget _buildPhoto(BuildContext context, String image) {
    return GestureDetector(
      onTap: () {
        // Show dialog with enlarged image
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Image.network(
              image,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
      child: Image.network(
        height: 170,
        image,
        fit: BoxFit.contain,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child; // Gambar sudah dimuat
          }
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          // Menampilkan gambar default atau widget lain jika gagal load gambar
          return const Icon(
            Icons.broken_image,
            size: 100,
            color: Colors.red,
          );
        },
      ),
    );
  }

  Widget _buildTitleAndContent(String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: fontJakartaSans.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: fontSmall,
          ),
        ),
        Expanded(
          child: Text(
            content,
            textAlign: TextAlign.end,
            style: fontJakartaSans.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: fontSmall,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnggotaKabinetCard(
      BuildContext context, AnggotaKabinet anggota) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: defaultMargin),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profil Image
          _buildAnggotaImage(context, anggota),
          const SpaceHeight(defaultMargin),
          _buildTitleAndContent('Nama', anggota.nama ?? 'N/A'),
          const SpaceHeight(12),
          _buildTitleAndContent('Jabatan', anggota.jabatan ?? 'N/A'),
          const SpaceHeight(12),
          _buildTitleAndContent(
              'Tanggal Dilantik', anggota.tanggalDilantik ?? 'N/A'),
          const SpaceHeight(12),
          _buildTitleAndContent(
              'Tempat Lahir', anggota.profil?.tempatLahir ?? 'N/A'),
          const SpaceHeight(12),
          _buildTitleAndContent(
              'Tanggal Lahir', anggota.profil?.tanggalLahir ?? 'N/A'),
          const SpaceHeight(12),
          _buildTitleAndContent(
              'Pendidikan', anggota.profil?.pendidikan ?? 'N/A'),
        ],
      ),
    );
  }

  Widget _buildAnggotaImage(BuildContext context, AnggotaKabinet anggota) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Image.network(
              anggota.profil?.image ?? 'Null',
              fit: BoxFit.contain,
              width: 200,
            ),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        child: Image.network(
          anggota.profil?.image ?? 'Null',
          height: 150,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child; // Gambar sudah dimuat
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.broken_image,
            size: 100,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
