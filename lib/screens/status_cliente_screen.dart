import 'package:flutter/material.dart';

class StatusClienteScreen extends StatefulWidget {
  const StatusClienteScreen({super.key});

  @override
  State<StatusClienteScreen> createState() => _StatusClienteScreenState();
}

class _StatusClienteScreenState extends State<StatusClienteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){}, 
          icon: Icon(Icons.add)
        ),
      ),
    );
  }
  
}