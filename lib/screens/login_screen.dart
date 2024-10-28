import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final conPwd = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        //backgroundColor: Colors.black,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/fondo.jpg',
              ),
            ),
          ),
        ),
        toolbarHeight: 250,
        title: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 95,
            width: 95,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.live_tv, size: 80,),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/fondo.jpg',
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(90)),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Inicio de sesion',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 38,
                      ),
                    ),
                    const SizedBox(height: 20),
        
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Clave de acceso',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      controller: conPwd,
                      validator: (value) {
                        if (value == null || value.isEmpty || value != '123') {
                          return 'Por favor ingrese la clave de acceso';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
        
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(context, "/home");
                        }
                      },
                      child: const Text(
                        'Acceder',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}