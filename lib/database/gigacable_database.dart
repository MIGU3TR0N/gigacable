import 'dart:io';

import 'package:gigacable/models/clientedao.dart';
import 'package:gigacable/models/detalleserviciodao.dart';
import 'package:gigacable/models/empleadoDAO.dart';
import 'package:gigacable/models/serviciodao.dart';
import 'package:gigacable/models/statusclientedao.dart';
import 'package:gigacable/models/statusdao.dart';
import 'package:gigacable/models/tiposerviciodao.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class GigacableDatabase {
  static const NAMEDB = 'GIGACABLEDB';
  static const VERSIONDB = 1;
  static Database? _database;

  Future<Database> get database async{
    if(_database != null) return _database!;
    return _database = await initDatabase();
  }

  Future<Database> initDatabase() async{
    Directory folder = await getApplicationDocumentsDirectory();
    String path = join(folder.path,NAMEDB);
    return openDatabase(
      path,
      version: VERSIONDB,
      onCreate: (db, version) {
        String query = '''
          CREATE TABLE status(
          id char(1) PRIMARY KEY,
          status VARCHAR(50)  
        );
        ''';
        db.execute(query);
        String query2 = '''
          CREATE TABLE status_cliente(
          id char(1) PRIMARY KEY,
          estatus_cliente VARCHAR(50)  
        );
        ''';
        db.execute(query2);
        String query3 = '''
          CREATE TABLE tipo_servicio(
          id char(1) PRIMARY KEY,
          tipo_servicio VARCHAR(50)  
        );
        ''';
        db.execute(query3);
        String query4 = '''
          CREATE TABLE empleado(
          id char(1) PRIMARY KEY,
          nombre VARCHAR(50),
          clave VARCHAR(14),
          apellido VARCHAR(50),
          RFC VARCHAR(13),
          fecha_ingreso VARCHAR(10)
        );
        ''';
        db.execute(query4);
        String query5 = '''
          CREATE TABLE detalle_servicio(
          id char(1) PRIMARY KEY,
          servicio VARCHAR(50),
          id_tipo_servicio char(1),
          CONSTRAINT fk_tipo_servicio FOREIGN KEY(id_tipo_servicio) REFERENCES tipo_servicio(id)
        );
        ''';
        db.execute(query5);
        String query6 = '''
          CREATE TABLE cliente(
          id char(1) PRIMARY KEY,
          nombre VARCHAR(50),
          apellido VARCHAR(50),
          direccion TEXT,
          id_status_cliente char(1),
          CONSTRAINT fk_status_cliente FOREIGN KEY(id_status_cliente) REFERENCES status_cliente(id)
        );
        ''';
        db.execute(query6);
        String query7 ='''
         CREATE TABLE servicio(
          id INTEGER PRIMARY KEY,
          fecha VARCHAR(10),
          id_cliente char(1),
          id_detalle_servicio char(1),
          id_status char(1),
          id_empleado char(1),
          CONSTRAINT fk_cliente FOREIGN KEY(id_cliente) REFERENCES cliente(id),
          CONSTRAINT fk_detalle_servicio FOREIGN KEY(id_detalle_servicio) REFERENCES detalle_servicio(id),
          CONSTRAINT fk_status FOREIGN KEY(id_status) REFERENCES status(id),
          CONSTRAINT fk_empleado FOREIGN KEY(id_empleado) REFERENCES empleado(id)
        );''';
        db.execute(query7);
      },
    );
  }
  Future<int> INSERT(String table, Map<String,dynamic> row) async {
    var con = await database;
    return await con.insert(table, row);
  }

  Future<int> UPDATE(String table, Map<String,dynamic> row) async {
    var con = await database;
    return await con.update(table, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> DELETE(String table, int id) async {
    var con = await database;
    return await con.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<StatusDAO>?> selectStatus() async {
    var con = await database;
    var result = await con.query('status');
    return result.map((obj) => StatusDAO.fromMap(obj)).toList(); 
  }

  Future<List<StatusClienteDAO>?> selectStatusCliente() async {
    var con = await database;
    var result = await con.query('status_cliente');
    return result.map((obj) => StatusClienteDAO.fromMap(obj)).toList(); 
  }

  Future<List<TipoServicioDAO>?> selectTipoServicio() async {
    var con = await database;
    var result = await con.query('tipo_servicio');
    return result.map((obj) => TipoServicioDAO.fromMap(obj)).toList(); 
  }

  Future<List<EmpleadoDAO>?> selectEmpleado() async {
    var con = await database;
    var result = await con.query('empleado');
    return result.map((obj) => EmpleadoDAO.fromMap(obj)).toList(); 
  }

  Future<List<DetalleServicioDAO>?> selectDetalleServicio() async {
    var con = await database;
    var result = await con.query('detalle_servicio');
    return result.map((obj) => DetalleServicioDAO.fromMap(obj)).toList(); 
  }

  Future<List<ClienteDAO>?> selectCliente() async {
    var con = await database;
    var result = await con.query('cliente');
    return result.map((obj) => ClienteDAO.fromMap(obj)).toList(); 
  }

  Future<List<ServicioDAO>?> selectServicio() async {
    var con = await database;
    var result = await con.query('servicio');
    return result.map((obj) => ServicioDAO.fromMap(obj)).toList(); 
  }
}