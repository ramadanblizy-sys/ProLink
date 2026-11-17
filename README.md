# ProLink — protótipo inicial Flutter

Este pacote contém a primeira interface demonstrativa da ProLink.

## Abrir
1. Descompacte o ZIP.
2. Coloque a pasta `lib` e o ficheiro `pubspec.yaml` dentro de um projecto Flutter.
3. Execute `flutter pub get` e depois `flutter run`.

## Incluído
- Página inicial com pesquisa por nome/serviço.
- Filtro por categoria e província.
- Lista de profissionais demonstrativos.
- Perfil resumido com província, distrito e bairro.
- Formulário de candidatura de profissional.
- Fotografias opcionais e sem campo de preços.
- Informação de que pagamentos são feitos directamente ao profissional.

## Importante
Esta é apenas uma demonstração visual/local. Os registos ainda não são guardados numa base de dados, a aprovação administrativa ainda não está ligada a um painel real e os contactos não iniciam chamadas. A próxima fase será ligar Firebase Authentication, Cloud Firestore e Storage, com regras de segurança e aprovação real.
