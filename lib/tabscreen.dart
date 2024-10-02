import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'agenda.dart'; 
import 'informasi.dart'; // Tambahkan import ini
import 'galery.dart'; // Tambahkan import ini

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _selectTab(int index) {
    _tabController.animateTo(index);
    Navigator.pop(context); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8D6E63), Color(0xFF795548)], // Warna cokelat
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          children: [
            const Icon(Icons.school, size: 40, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'SMK Negeri 4 Bogor',
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
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6D4C41), Color(0xFF5D4037)], // Nuansa cokelat
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.brown[200],
          tabs: const [
            Tab(icon: Icon(Icons.info_outline), text: 'Informasi'),
            Tab(icon: Icon(Icons.view_agenda_outlined), text: 'Agenda'),
            Tab(icon: Icon(Icons.photo_library_outlined), text: 'Gallery'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF8D6E63), Color(0xFF795548)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const Icon(Icons.school, size: 100, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(
                    'SMK Negeri 4 Bogor',
                    style: GoogleFonts.josefinSans(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Informasi'),
              onTap: () => _selectTab(0),
            ),
            ListTile(
              leading: const Icon(Icons.view_agenda_outlined),
              title: const Text('Agenda'),
              onTap: () => _selectTab(1),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Gallery'),
              onTap: () => _selectTab(2),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          InformasiScreen(), // Ganti Center widget dengan InformasiScreen
          AgendaScreen(),
          GaleryScreen(),
          
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
