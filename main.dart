import 'package:flutter/material.dart';

void main() => runApp(const ProLinkApp());

const brandBlue = Color(0xFF1769D2);

class ProLinkApp extends StatelessWidget {
  const ProLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProLink',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: brandBlue),
        scaffoldBackgroundColor: const Color(0xFFF5F8FC),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF16324F),
          elevation: 0,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class Professional {
  final String name, category, province, district, neighborhood, description, phone;
  const Professional({
    required this.name, required this.category, required this.province,
    required this.district, required this.neighborhood,
    required this.description, required this.phone,
  });
}

const professionals = [
  Professional(name: 'João Mucavele', category: 'Electricidade',
    province: 'Inhambane', district: 'Homoíne', neighborhood: 'Vila de Homoíne',
    description: 'Instalações eléctricas e pequenas reparações.', phone: '84 000 0000'),
  Professional(name: 'Ana Macuácua', category: 'Beleza',
    province: 'Maputo', district: 'KaMpfumo', neighborhood: 'Central',
    description: 'Cabeleireira e cuidados de beleza.', phone: '86 000 0000'),
  Professional(name: 'Carlos Nhantumbo', category: 'Construção',
    province: 'Inhambane', district: 'Maxixe', neighborhood: ' Chambone',
    description: 'Serviços de pedreiro e pintura.', phone: '87 000 0000'),
  Professional(name: 'Marta Cossa', category: 'Educação',
    province: 'Maputo', district: 'Matola', neighborhood: 'Fomento',
    description: 'Explicações e apoio escolar.', phone: '82 000 0000'),
];

const categories = [
  ('Construção', Icons.construction),
  ('Electricidade', Icons.electrical_services),
  ('Beleza', Icons.face_retouching_natural),
  ('Tecnologia', Icons.computer),
  ('Transporte', Icons.local_shipping),
  ('Educação', Icons.school),
  ('Limpeza', Icons.cleaning_services),
  ('Reparações', Icons.handyman),
  ('Serviços domésticos', Icons.home_repair_service),
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int tab = 0;
  String query = '';
  String category = 'Todas';
  String province = 'Todas';

  List<Professional> get filtered => professionals.where((p) {
    final matchesQuery = '${p.name} ${p.category} ${p.description}'.toLowerCase().contains(query.toLowerCase());
    return matchesQuery && (category == 'Todas' || p.category == category)
      && (province == 'Todas' || p.province == province);
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Container(width: 36, height: 36,
            decoration: BoxDecoration(color: brandBlue, borderRadius: BorderRadius.circular(11)),
            child: const Icon(Icons.link, color: Colors.white)),
          const SizedBox(width: 10),
          const Text('ProLink', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 23)),
        ]),
        actions: [IconButton(onPressed: () => _showRegister(context), icon: const Icon(Icons.person_add_alt_1))],
      ),
      body: tab == 0 ? _home() : tab == 1 ? _categoriesPage() : _aboutPage(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.search), label: 'Pesquisar'),
          NavigationDestination(icon: Icon(Icons.grid_view), label: 'Categorias'),
          NavigationDestination(icon: Icon(Icons.info_outline), label: 'Sobre'),
        ],
      ),
    );
  }

  Widget _home() => ListView(padding: const EdgeInsets.all(18), children: [
    Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: brandBlue, borderRadius: BorderRadius.circular(20)),
      child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Encontre o profissional certo!', style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold)),
        SizedBox(height: 7),
        Text('Pesquise serviços por categoria e localização.', style: TextStyle(color: Colors.white)),
      ]),
    ),
    const SizedBox(height: 18),
    TextField(
      decoration: InputDecoration(
        hintText: 'Pesquisar profissional ou serviço',
        prefixIcon: const Icon(Icons.search),
        filled: true, fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      ),
      onChanged: (v) => setState(() => query = v),
    ),
    const SizedBox(height: 12),
    Row(children: [
      Expanded(child: _dropdown('Categoria', category, ['Todas', ...categories.map((e) => e.$1)], (v) => setState(() => category = v!))),
      const SizedBox(width: 10),
      Expanded(child: _dropdown('Província', province, ['Todas', 'Maputo', 'Gaza', 'Inhambane', 'Sofala', 'Manica', 'Tete', 'Zambézia', 'Nampula', 'Cabo Delgado', 'Niassa'], (v) => setState(() => province = v!))),
    ]),
    const SizedBox(height: 22),
    const Text('Profissionais disponíveis', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    const SizedBox(height: 10),
    if (filtered.isEmpty) const Padding(
      padding: EdgeInsets.all(20), child: Text('Não foram encontrados profissionais.')),
    ...filtered.map((p) => _professionalCard(p)),
    const SizedBox(height: 12),
    OutlinedButton.icon(onPressed: () => _showRegister(context),
      icon: const Icon(Icons.person_add_alt_1), label: const Text('Quero registar-me como profissional')),
  ]);

  Widget _dropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) =>
    DropdownButtonFormField<String>(
      value: value, isExpanded: true, decoration: InputDecoration(labelText: label, filled: true,
      fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, overflow: TextOverflow.ellipsis))).toList(),
      onChanged: onChanged,
    );

  Widget _professionalCard(Professional p) => Card(
    color: Colors.white, elevation: 0, margin: const EdgeInsets.only(bottom: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: ListTile(
      contentPadding: const EdgeInsets.all(13),
      leading: CircleAvatar(backgroundColor: const Color(0xFFE5F0FF), child: Text(p.name[0], style: const TextStyle(color: brandBlue, fontWeight: FontWeight.bold))),
      title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Padding(padding: const EdgeInsets.only(top: 5), child: Text('${p.category}\n${p.province} • ${p.district} • ${p.neighborhood}\n${p.description}')),
      isThreeLine: true,
      trailing: const Icon(Icons.chevron_right),
      onTap: () => showDialog(context: context, builder: (_) => AlertDialog(
        title: Text(p.name),
        content: Text('${p.category}\n${p.description}\n\nLocalização: ${p.province}, ${p.district}, ${p.neighborhood}\nContacto: ${p.phone}\n\nO pagamento é combinado directamente entre cliente e profissional.'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fechar'))],
      )),
    ),
  );

  Widget _categoriesPage() => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Categorias de serviços', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
    const SizedBox(height: 12),
    ...categories.map((c) => Card(color: Colors.white, elevation: 0, child: ListTile(
      leading: CircleAvatar(backgroundColor: const Color(0xFFE5F0FF), child: Icon(c.$2, color: brandBlue)),
      title: Text(c.$1), trailing: const Icon(Icons.chevron_right),
      onTap: () { setState(() { category = c.$1; tab = 0; }); },
    ))),
  ]);

  Widget _aboutPage() => ListView(padding: const EdgeInsets.all(20), children: const [
    Text('Sobre a ProLink', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    SizedBox(height: 12),
    Text('A ProLink liga clientes a profissionais em Moçambique, com possibilidade de expansão internacional.'),
    SizedBox(height: 12),
    Text('Os clientes pesquisam por categoria e localização. Os profissionais candidatam-se e os seus perfis só ficam visíveis após aprovação da administração.'),
    SizedBox(height: 12),
    Text('O pagamento é feito directamente ao profissional. A ProLink não processa pagamentos de serviços nesta versão.'),
    SizedBox(height: 12),
    Text('A publicação de fotografias dos trabalhos é opcional e não é necessário apresentar preços.'),
  ]);

  void _showRegister(BuildContext context) {
    final name = TextEditingController();
    final phone = TextEditingController();
    final district = TextEditingController();
    final neighborhood = TextEditingController();
    final description = TextEditingController();
    String selectedCategory = categories.first.$1;
    String selectedProvince = 'Inhambane';
    showDialog(context: context, builder: (dialogContext) => StatefulBuilder(builder: (context, setDialog) =>
      AlertDialog(
        title: const Text('Candidatura de profissional'),
        content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: name, decoration: const InputDecoration(labelText: 'Nome completo')),
          TextField(controller: phone, decoration: const InputDecoration(labelText: 'Contacto telefónico'), keyboardType: TextInputType.phone),
          DropdownButtonFormField<String>(value: selectedCategory, decoration: const InputDecoration(labelText: 'Categoria'),
            items: categories.map((e) => DropdownMenuItem(value: e.$1, child: Text(e.$1))).toList(),
            onChanged: (v) => setDialog(() => selectedCategory = v!)),
          DropdownButtonFormField<String>(value: selectedProvince, decoration: const InputDecoration(labelText: 'Província'),
            items: ['Maputo', 'Gaza', 'Inhambane', 'Sofala', 'Manica', 'Tete', 'Zambézia', 'Nampula', 'Cabo Delgado', 'Niassa']
              .map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setDialog(() => selectedProvince = v!)),
          TextField(controller: district, decoration: const InputDecoration(labelText: 'Distrito')),
          TextField(controller: neighborhood, decoration: const InputDecoration(labelText: 'Bairro')),
          TextField(controller: description, decoration: const InputDecoration(labelText: 'Descrição dos serviços'), maxLines: 2),
          const SizedBox(height: 10),
          const Text('Fotografias dos trabalhos: opcionais. Não é necessário indicar preços.',
            style: TextStyle(fontSize: 12, color: Colors.black54)),
        ])),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancelar')),
          FilledButton(onPressed: () {
            if (name.text.trim().isEmpty || phone.text.trim().isEmpty || district.text.trim().isEmpty || neighborhood.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preencha nome, contacto e localização.')));
              return;
            }
            Navigator.pop(dialogContext);
            ScaffoldMessenger.of(this.context).showSnackBar(const SnackBar(content: Text('Candidatura de demonstração registada. A publicação real dependerá da aprovação da administração.')));
          }, child: const Text('Enviar candidatura')),
        ],
      )));
  }
}
