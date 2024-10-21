import 'package:flutter/material.dart';
import 'package:kabinet_indonesia/components/spaces.dart';
import 'package:kabinet_indonesia/constants/theme.dart';
import 'package:kabinet_indonesia/view/cabinet_detail_screen.dart';
import 'package:kabinet_indonesia/view_model/home_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SpaceHeight(20),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                height: 60,
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Daftar Kabinet Indonesia',
                  style: fontPacifico.copyWith(
                    fontSize: fontLarge,
                    color: Colors.black,
                    fontWeight: medium,
                  ),
                ),
              ),
              const SpaceHeight(20),
              Expanded(
                child: FutureBuilder(
                  future: provider.loadCabinets(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data available'));
                    } else {
                      final cabinets = snapshot.data!;
                      return ListView.builder(
                        itemCount: cabinets.length,
                        itemBuilder: (context, index) {
                          final cabinet = cabinets[index];
                          return InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              // Go To Detail Cabinet
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CabinetDetailScreen(
                                      daftarKabinet: cabinet,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Card(
                              child: ListTile(
                                // Image
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    'assets/images/indonesia_emas.png',
                                  ),
                                ),

                                title: Text(
                                  cabinet.namaKabinet ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Presiden: ${cabinet.presiden}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'Wakil: ${cabinet.wakilPresiden}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'Periode: ${cabinet.periode}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                trailing: const Icon(Icons.arrow_right_rounded),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
