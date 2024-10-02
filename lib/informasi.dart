import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InformasiScreen extends StatefulWidget {
  const InformasiScreen({super.key});

  @override
  _InformasiScreenState createState() => _InformasiScreenState();
}

class _InformasiScreenState extends State<InformasiScreen> {
  List<dynamic> _informasiData = []; // Ubah menjadi List<dynamic> untuk tipe yang lebih tepat

  @override
  void initState() {
    super.initState();
    fetchInformasiData();
  }

  Future<void> fetchInformasiData() async {
    try {
      final response = await http.get(
          Uri.parse('https://ujikom2024pplg.smkn4bogor.sch.id/0067163570/informasi.php'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _informasiData = data;
        });
      } else {
        throw Exception('Failed to load informasi data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Informasi',
                style: GoogleFonts.josefinSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.brown,
      ),
      body: _informasiData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: _informasiData.map((informasi) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.brown, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DataTable(
                          columnSpacing: 20.0,
                          headingRowColor: WidgetStateProperty.all(Colors.brown[200]), // Perbaiki penggunaan
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Judul',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Tanggal Post',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                          rows: [
                            DataRow(
                              cells: [
                               DataCell(
                                  SizedBox(
                                    width: 200, // Atur lebar kolom Judul
                                    child: Text(informasi['judul_info'] ?? 'N/A', maxLines: 2, overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                               DataCell(
                                  SizedBox(
                                    width: 200, // Atur lebar kolom Judul
                                    child: Text(informasi['tgl_post_info'] ?? 'N/A', maxLines: 2, overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Keterangan: ${informasi['isi_info'] ?? 'Tidak ada keterangan'}', // Penanganan null
                            softWrap: true,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
