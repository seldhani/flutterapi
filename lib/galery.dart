import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GaleryScreen extends StatefulWidget {
  const GaleryScreen({super.key});

  @override
  _GaleryScreenState createState() => _GaleryScreenState();
}

class _GaleryScreenState extends State<GaleryScreen> {
  List<dynamic> _galeryData = [];

  @override
  void initState() {
    super.initState();
    fetchGaleryData();
  }

  Future<void> fetchGaleryData() async {
    try {
      final response = await http.get(
        Uri.parse('https://ujikom2024pplg.smkn4bogor.sch.id/0067163570/galery.php'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _galeryData = data;
        });
      } else {
        throw Exception('Failed to load gallery data');
      }
    } catch (e) {
      print('Error: $e');
      // Anda dapat menampilkan dialog kesalahan atau snackbar di sini
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gallery',
          style: GoogleFonts.josefinSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.brown,
      ),
      body: _galeryData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: _galeryData.map((galery) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.brown, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Menampilkan gambar di atas tabel
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.network(
                            galery['isi_galery'] ?? '', // Pastikan 'foto_galery' ada dalam data
                            fit: BoxFit.cover, // Mengatur tampilan gambar
                            width: double.infinity, // Mengisi lebar kontainer
                            height: 400, // Atur tinggi gambar sesuai kebutuhan
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(child: Text('Gambar tidak tersedia'));
                            },
                          ),
                        ),
                        DataTable(
                          columnSpacing: 20.0,
                          headingRowColor: WidgetStateProperty.all(Colors.brown[200]),
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Judul',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Tanggal Post',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          rows: [
                            DataRow(
                              cells: [
                                DataCell(
                                  SizedBox(
                                    width: 200, // Atur lebar kolom Judul
                                    child: Text(galery['judul_galery'] ?? 'N/A', maxLines: 2, overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: 150, // Atur lebar kolom Tanggal Post
                                    child: Text(galery['tgl_post_galery'] ?? 'N/A', maxLines: 1, overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
