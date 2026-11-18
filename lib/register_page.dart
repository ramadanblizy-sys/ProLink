import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? userType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registo ProLink'),
        backgroundColor: const Color(0xFF123B65),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bem-vindo à ProLink!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text('Como pretende utilizar a ProLink?'),

            const SizedBox(height: 20),

            roleCard(
              'Cliente',
              'Quero encontrar profissionais.',
              Icons.person,
            ),

            roleCard(
              'Profissional',
              'Quero oferecer os meus serviços.',
              Icons.work,
            ),

            if (userType != null) ...[
              const SizedBox(height: 25),

              Text(
                'Registo de $userType',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              textField('Nome completo'),
              textField('Número de telefone'),

              if (userType == 'Profissional') ...[
                textField('Profissão'),
                textField('Província'),
                textField('Distrito'),
                textField('Bairro'),
              ],

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF123B65),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Criar conta'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget roleCard(String title, String description, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFF123B65),
        ),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          setState(() {
            userType = title;
          });
        },
      ),
    );
  }

  Widget textField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
