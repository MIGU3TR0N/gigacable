import 'package:flutter/material.dart';
import 'package:gigacable/database/gigacable_database.dart';
import 'package:gigacable/models/clientedao.dart';
import 'package:gigacable/settings/global_values.dart';
import 'package:gigacable/views/cliente_servicio_view_item.dart';

class Display2Screen extends StatefulWidget {
  const Display2Screen({super.key});

  @override
  State<Display2Screen> createState() => _Display2ScreenState();
}

class _Display2ScreenState extends State<Display2Screen> {
  late GigacableDatabase gigacableDB;
  @override
  void initState() {
    super.initState();
    gigacableDB = GigacableDatabase();
  }
  @override
  Widget build(BuildContext context) {
        int elio = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(178, 121, 222, 235),
        title: Text('Servicio: $elio'),
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
                    return ClienteServicioViewItem(clienteDAO: snapshot.data![index], idser: elio,);
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