importimport 'register_page.dart'; 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(actions: [
  TextButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        ),
      );
    },
    child: const Text(
      'Registar',
      style: TextStyle(color: Colors.white),
    ),
  ),
],
        backgroundColor: const Color(0xFF123B65),
        title: const Text(
          'ProLink',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: false,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Encontre o profissional certo!',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Encontre profissionais perto de si.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              decoration: InputDecoration(
                hintText: 'Pesquisar profissão...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Localização',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            locationField('Província'),
            const SizedBox(height: 10),

            locationField('Distrito'),
            const SizedBox(height: 10),

            locationField('Bairro'),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF123B65),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Pesquisar profissionais'),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Profissionais disponíveis',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            professionalCard(
              Icons.build,
              'Técnico de Construção',
              'Disponível para serviços',
            ),

            professionalCard(
              Icons.electrical_services,
              'Electricista',
              'Disponível para serviços',
            ),

            professionalCard(
              Icons.plumbing,
              'Canalizador',
              'Disponível para serviços',
            ),
          ],
        ),
      ),
    );
  }

  Widget locationField(String label) {
    return TextField(
      decoration: InputDecoration(
        hintText: label,
        prefixIcon: const Icon(Icons.location_on_outlined),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget professionalCard(
    IconData icon,
    String name,
    String description,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE1EBF5),
          child: Icon(icon, color: const Color(0xFF123B65)),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ProfessionalProfile(),
    ),
  );
},
      ),
    );
  }
}
