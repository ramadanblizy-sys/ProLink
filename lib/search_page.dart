import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final professionController = TextEditingController();
  final provinceController = TextEditingController();
  final districtController = TextEditingController();
  final neighborhoodController = TextEditingController();

  @override
  void dispose() {
    professionController.dispose();
    provinceController.dispose();
    districtController.dispose();
    neighborhoodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar profissionais'),
        backgroundColor: const Color(0xFF123B65),
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Encontre o profissional ideal',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Indique a profissão e a localização desejada.',
            ),

            const SizedBox(height: 25),

            searchField(
              'Profissão',
              Icons.work,
              professionController,
            ),

            searchField(
              'Província',
              Icons.location_on,
              provinceController,
            ),

            searchField(
              'Distrito',
              Icons.map,
              districtController,
            ),

            searchField(
              'Bairro',
              Icons.home,
              neighborhoodController,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'A pesquisa será ligada à base de dados na próxima fase.',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.search),
                label: const Text('Pesquisar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF123B65),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchField(
    String label,
    IconData icon,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
