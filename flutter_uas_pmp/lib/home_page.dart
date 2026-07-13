import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controller disesuaikan untuk data sepatu
  final merkController = TextEditingController();
  final ukuranController = TextEditingController();

  // Nama box diganti menjadi sepatuBox
  final box = Hive.box("sepatuBox");

  bool isEdit = false;
  int selectedIndex = -1;

  void simpanData() {
    String merk = merkController.text.trim();
    String ukuran = ukuranController.text.trim();

    if (merk.isEmpty || ukuran.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Merk dan Ukuran Sepatu wajib diisi")),
      );
      return;
    }

    // Struktur Map disesuaikan untuk sepatu
    Map<String, dynamic> data = {'merk': merk, 'ukuran': ukuran};

    if (isEdit) {
      box.putAt(selectedIndex, data);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data sepatu berhasil diupdate")),
      );
    } else {
      box.add(data);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data sepatu berhasil disimpan")),
      );
    }

    clearform();
    setState(() {});
  }

  void editData(int index) {
    var data = box.getAt(index);
    merkController.text = data['merk'];
    ukuranController.text = data['ukuran'];

    isEdit = true;
    selectedIndex = index;

    setState(() {});
  }

  void hapusData(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Yakin ingin menghapus data sepatu?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                box.deleteAt(index);
                Navigator.pop(context);
                setState(() {});

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data sepatu berhasil dihapus')),
                );
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void clearform() {
    merkController.clear();
    ukuranController.clear();

    isEdit = false;
    selectedIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD HIVE DATA SEPATU"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input Merk Sepatu
            TextField(
              controller: merkController,
              decoration: const InputDecoration(
                labelText: "Merk Sepatu",
                hintText: "Contoh: Nike, Adidas, Ventela",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.branding_watermark),
              ),
            ),
            const SizedBox(height: 12),

            // Input Ukuran Sepatu (Tipe Keyboard Angka)
            TextField(
              controller: ukuranController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Ukuran Sepatu",
                hintText: "Contoh: 42",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.straighten),
              ),
            ),
            const SizedBox(height: 16),

            // Tombol Simpan / Update
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: simpanData,
                child: Text(isEdit ? "UPDATE DATA" : "SIMPAN DATA"),
              ),
            ),
            const SizedBox(height: 20),

            // List Tampilan Data Sepatu
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, value, child) {
                  if (box.isEmpty) {
                    return const Center(child: Text("Belum ada data sepatu"));
                  }

                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      var data = box.getAt(index);
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Icon(Icons.ice_skating, color: Colors.white),
                          ),
                          title: Text(
                            data['merk'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("Ukuran: ${data['ukuran']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.orange,
                                ),
                                onPressed: () => editData(index),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => hapusData(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
