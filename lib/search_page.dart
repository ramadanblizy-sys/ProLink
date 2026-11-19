import 'package:flutter/material.dart';
import 'professional_data.dart';
import 'professional_profile.dart';
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

  List<Professional> results = [];
  bool hasSearched = false;

  @override
  void dispose() {
    professionController.dispose();
    provinceController.dispose();
    districtController.dispose();
    neighborhoodController.dispose();
    super.dispose();
  }

  void searchProfessionals() {
    final profession = professionController.text.trim().toLowerCase();
    final province = provinceController.text.trim().toLowerCase();
    final district = districtController.text.trim().toLowerCase();
    final neighborhood = neighborhoodController.text.trim().toLowerCase();

    setState(() {
      results = professionals.where((professional) {
        return professional.profession.toLowerCase().contains(profession) &&
            professional.province.toLowerCase().contains(province) &&
            professional.district.toLowerCase().contains(district) &&
            professional.neighborhood.toLowerCase().contains(neighborhood);
      }).toList();

      hasSearched = true;
    });
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

            searchField('Profissão', Icons.work, professionController),
            searchField('Província', Icons.location_on, provinceController),
            searchField('Distrito', Icons.map, districtController),
            searchField('Bairro', Icons.home, neighborhoodController),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: searchProfessionals,
                icon: const Icon(Icons.search),
                label: const Text('Pesquisar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF123B65),
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 25),

            if (hasSearched) ...[
              const Text(
                'Resultados da pesquisa',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              if (results.isEmpty)
                const Text(
                  'Nenhum profissional encontrado. '
                  'Verifique os dados e tente novamente.',
                ),
...results.map(
  (professional) => Card(
    margin: const EdgeInsets.only(bottom: 12),
    child: ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(professional.name),
      subtitle: Text(
        '${professional.profession}\n'
        '${professional.province}, '
        '${professional.district}, '
        '${professional.neighborhood}',
      ),
      isThreeLine: true,
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfessionalProfile(
              professional: professional,
            ),
          ),
        );
      },
    ),
  ),
),
              
            ],
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
