import 'package:flutter/material.dart';
import 'package:gigacable/database/gigacable_database.dart';
import 'package:gigacable/models/clientedao.dart';
import 'package:gigacable/models/serviciodao.dart';
import 'package:gigacable/settings/global_values.dart';
import 'package:gigacable/views/cliente_view.dart';
import 'package:quickalert/quickalert.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ServicioItemVer extends StatefulWidget {
  ServicioItemVer({
    super.key,
    required this.servicioDAO
  });
  ServicioDAO servicioDAO;

  @override
  State<ServicioItemVer> createState() => _ServicioItemVerState();
}

class _ServicioItemVerState extends State<ServicioItemVer> {
  GigacableDatabase? gigacableDatabase;
  @override
  void initState() {
    super.initState();
    gigacableDatabase = GigacableDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.lightGreen
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(widget.servicioDAO.fecha!.toString()),
                  subtitle: Text('chavo'),
                ),
              ),
              
            ],
          )
        ],
      ),
    );
  }
}