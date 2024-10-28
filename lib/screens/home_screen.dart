import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:gigacable/provider/profile_provider.dart';
import 'package:gigacable/screens/clientes_screen.dart';
import 'package:gigacable/screens/home.dart';
import 'package:gigacable/screens/status_cliente_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int a_index=0;
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            icon: Icon(Icons.logout)
          )
        ],
      ),
      body: Builder(
        builder: (context){
          switch (a_index){
            case 0: return Home();
            case 1: return ClientesScreen();
            case 3: return StatusClienteScreen();
            default: return Text('algo diferente');
          }
        }
      ),
      drawer: myDrawer(profileProvider),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icon(Icons.home), title: 'Inicio'),
          TabItem(icon: Icon(Icons.person), title: 'Clientes'),
          TabItem(icon: Icon(Icons.history), title: 'Historial')
        ],
        backgroundColor: Colors.cyan,
        onTap: (index) => setState(() {
          a_index = index;
        }),
      ),
    );
  }
  Widget myDrawer(ProfileProvider profileProvider){
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              color: Colors.cyan,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(60), topRight: Radius.circular(60))
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person_2, size: 50,)
            ),
            accountName: Text(profileProvider.nombre+' '+profileProvider.apellido), 
            accountEmail: Text(profileProvider.nombre+'_'+profileProvider.apellido+'@gigacable.com'),
          ),
          ListTile(
            onTap: () => setState(() {
              a_index = 3;
              Navigator.pop(context);
            }),
            title: Text('Tipos de membresia'),
            leading: Icon(Icons.card_membership),
            trailing: Icon(Icons.chevron_right),
          )
        ],
      ),
    );
  }
}