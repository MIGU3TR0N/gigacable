import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gigacable/database/gigacable_database.dart';
import 'package:gigacable/models/detalleserviciodao.dart';
import 'package:gigacable/settings/global_values.dart';
import 'package:gigacable/views/servicio_view_item.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  late GigacableDatabase gigacableDB;
  late int opcion;
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
        title: Text('Servicios'),
       /* leading: IconButton(
          onPressed: (){}, 
          icon: Icon(Icons.add)
        ),*/
      ),
      body: ValueListenableBuilder(
        valueListenable: GlobalValues.banUpdListClientes,
        builder: (context, value, Widget){
          return FutureBuilder(
            future: gigacableDB.selectDetalleServicioespec(elio), 
            builder: (context, AsyncSnapshot<List<DetalleServicioDAO>?> snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ServicioViewItem(detalleserviceDAO: snapshot.data![index],);
                    //var asda = snapshot.data!.elementAt(index).id;
                    //return Center(child: Text('$asda'));
                    //Center(child: Text('$elio'));
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