import 'package:flutter/material.dart';
import 'package:gigacable/views/cliente_view.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class Home extends StatefulWidget {
  final Function(int) onUpdateIndex;
  const Home({super.key, required this.onUpdateIndex});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Center(
        child: Column(
          children: [
            Text('Opciones', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,),),
            Divider(),
            ListTile(
              onTap: () {
                widget.onUpdateIndex(1);
                WoltModalSheet.show(
                  context: context, 
                  pageListBuilder: (context) => [
                    WoltModalSheetPage(
                      child: ClienteView()
                    )
                  ]
                );
              },
              title: Text('Agregar nuevo cliente'),
              leading: Icon(Icons.person_add),
              trailing: Icon(Icons.chevron_right),
            ),
            Divider(),
            ListTile(
              onTap: () {
                widget.onUpdateIndex(2); // Cambia el índice a HistoryScreen
              },
              title: Text('Actualizar bitacora'),
              leading: Icon(Icons.note_add_outlined),
              trailing: Icon(Icons.chevron_right),
            ),
            Divider(),
             ListTile(
              onTap: () {
                Navigator.pushNamed(context, "/services");
              },
              title: Text('Agregar servicio'),
              leading: Icon(Icons.note_add_outlined),
              trailing: Icon(Icons.chevron_right),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}