import 'package:flutter/material.dart';
import 'package:gigacable/database/gigacable_database.dart';
import 'package:gigacable/models/clientedao.dart';
import 'package:gigacable/settings/global_values.dart';
import 'package:gigacable/views/cliente_view_item.dart';

class ClientesScreen extends StatefulWidget {
  const ClientesScreen({super.key});

  @override
  State<ClientesScreen> createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> {
  late GigacableDatabase gigacableDB;
  @override
  void initState() {
    super.initState();
    gigacableDB = GigacableDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(178, 121, 222, 235),
        title: Text('Clientes'),
        leading: IconButton(
          onPressed: (){}, 
          icon: Icon(Icons.add)
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: GlobalValues.banUpdListClientes,
        builder: (context, value, Widget){
          return FutureBuilder(
            future: gigacableDB.selectCliente(), 
            builder: (context, AsyncSnapshot<List<ClienteDAO>?> snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ClienteViewItem(clienteDAO: snapshot.data![index],);
                  },
                );
              }else{
                if(snapshot.hasError){
                  return Center(child: Text(snapshot.error.toString()),);
                }else{
                  return Center(child: CircularProgressIndicator(),);
                }
              }
            }
          );
        },
      ),
    );
  }
}