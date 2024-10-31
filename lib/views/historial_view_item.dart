import 'package:flutter/material.dart';
import 'package:gigacable/database/gigacable_database.dart';
import 'package:gigacable/models/clientedao.dart';
import 'package:gigacable/models/historialdao.dart';
import 'package:gigacable/models/serviciodao.dart';

class HistorialViewItem extends StatefulWidget {
  HistorialViewItem({
    super.key,
    required this.historialDAO,
  });
  HistorialDAO historialDAO;

  @override
  State<HistorialViewItem> createState() => _HistorialViewItemState();
}

class _HistorialViewItemState extends State<HistorialViewItem> {
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
                  title: Text(widget.historialDAO.fecha!),
                  subtitle: Text(widget.historialDAO.nombre! + ' ' + widget.historialDAO.apellido!),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}