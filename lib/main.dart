importimport 'home_page.dart 'package:flutter/material.dart';

void main() {
  runApp(const ProLinkApp());
}

class ProLinkApp extends StatelessWidget {
  const ProLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProLink',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      ),
      home: const HomePage(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final TextEditingController searchController =
      TextEditingController();

  final List<Map<String, String>> professionals = [
    {
      'name': 'João Manuel',
      'profession': 'Electricista',
      'province': 'Inhambane',
      'district': 'Homoíne',
      'bairro': 'Centro'
    },
    {
      'name': 'Carlos Alberto',
      'profession': 'Canalizador',
      'province': 'Maputo',
      'district': 'Matola',
      'bairro': 'Liberdade'
    },
    {
      'name': 'António Luís',
      'profession': 'Pedreiro',
      'province': 'Inhambane',
      'district': 'Homoíne',
      'bairro': 'Morrumbene'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        title: const Text(
          'ProLink',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),

      body: selectedIndex == 0
          ? buildHome()
          : selectedIndex == 1
              ? buildExplore()
              : buildProfile(),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Explorar',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget buildHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bem-vindo à ProLink!',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Encontre profissionais qualificados perto de si.',
            style: TextStyle(fontSize: 15),
          ),

          const SizedBox(height: 22),

          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Pesquisar profissionais...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),

          const SizedBox(height: 25),

          const Text(
            'Profissionais disponíveis',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          ...professionals
              .where((professional) {
                final query =
                    searchController.text.toLowerCase();

                return professional.values.any(
                  (value) => value.toLowerCase().contains(query),
                );
              })
              .map((professional) {
                return professionalCard(professional);
              }),
        ],
      ),
    );
  }

  Widget professionalCard(Map<String, String> professional) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: Color(0xFFE3F2FD),
              child: Icon(
                Icons.person,
                size: 32,
                color: Color(0xFF1565C0),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    professional['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(professional['profession']!),

                  const SizedBox(height: 4),

                  Text(
                    '${professional['province']} - '
                    '${professional['district']} - '
                    '${professional['bairro']}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextButton(
                    onPressed: () {},
                    child: const Text('Ver perfil'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExplore() {
    return const Center(
      child: Text(
        'Explorar profissionais',
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildProfile() {
    return const Center(
      child: Text(
        'O meu perfil',
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
