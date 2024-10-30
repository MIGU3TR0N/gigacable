import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
    final controller = PageController();
    int asdfs = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only( bottom: 80),
        child: PageView(
          controller: controller,
          children: [
            buildpage(),
            buildpage2(),
            buildpage3(),
            //buildpagebuttons(),
            //buildpage1()
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(onPressed: (){controller.jumpToPage(2);}, child: const Text('skip'),),
          Center(
            child: SmoothPageIndicator(controller: controller, count: 3,
            effect: WormEffect(
              spacing: 16,
              dotColor: Colors.black26,
              activeDotColor: Colors.teal.shade700
            ),
            onDotClicked: (index) => controller.animateToPage(
              index,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeIn,
              ),
            ),
          ),
          TextButton(onPressed: () => controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          ), child: const Text('NEXT')),

        ],),
      ),
    );
  }
  
  Widget buildpage() => Container(
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
                  Image.asset('assets/logos.jpg'),
                  Text('Verificacion', style: TextStyle(color: Colors.teal.shade700,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)
                  ,),
                  const SizedBox(height: 24,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: const Text(
                      'Selecciona a continuacion el servicio a realizar...',
                      style: TextStyle(color: Colors.black26),
                    ),
                  ),
        IconButton(onPressed: (){
          asdfs = 1;
          Navigator.pushNamed(context, "/servicedetails", arguments: asdfs);
        }, icon: const Icon(Icons.admin_panel_settings)),
                  
      ],
    ),

  );

  Widget buildpage2() => Container(
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
                  Image.asset('assets/logos.jpg'),
                  Text('Reparacion', style: TextStyle(color: Colors.teal.shade700,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)
                  ,),
                  const SizedBox(height: 24,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: const Text(
                      'Selecciona a continuacion el servicio a realizar...',
                      style: TextStyle(color: Colors.black26),
                    ),
                  ),
        IconButton(onPressed: (){
          asdfs = 2;
          Navigator.pushNamed(context, "/servicedetails", arguments: asdfs);
        }, icon: const Icon(Icons.admin_panel_settings)),
                  
      ],
    ),
  );

  Widget buildpage3() => Container(
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
                  Image.asset('assets/logos.jpg'),
                  Text('Renovacion', style: TextStyle(color: Colors.teal.shade700,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)
                  ,),
                  const SizedBox(height: 24,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: const Text(
                      'Selecciona a continuacion el servicio a realizar...',
                      style: TextStyle(color: Colors.black26),
                    ),
                  ),
        IconButton(onPressed: (){
          asdfs = 3;
          Navigator.pushNamed(context, "/servicedetails", arguments: asdfs);
        }, icon: const Icon(Icons.admin_panel_settings)),
                  
      ],
    ),
  );

}