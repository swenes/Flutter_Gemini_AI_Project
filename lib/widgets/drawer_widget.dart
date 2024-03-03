import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
        children: [
          const ListTile(
            title: Center(
              child: Text(
                'The VisualBrain',
                style: TextStyle(
                  color: Color.fromARGB(255, 145, 102, 23),
                  fontSize: 30,
                  fontFamily: 'Cera-Pro',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/drawer2.png'),
              ),
            ),
            child: SizedBox(),
          ),
          const ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Enes Aydoğdu',
              style: TextStyle(
                fontFamily: 'Cera-Pro',
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('+90 543 623 4972'),
          ),
          const Divider(height: 1),
          ListTile(
            leading: Image.asset(
              'assets/images/linkedin.png',
              scale: 20,
            ),
            title: const Text(
              'LinkedIn',
              style: TextStyle(
                fontFamily: 'Cera-Pro',
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text('www.linkedin.com/in/swenes'),
          ),
          const Divider(height: 1),
          const ListTile(
            leading: Icon(Icons.location_pin),
            title: Text(
              'Adress',
              style: TextStyle(
                fontFamily: 'Cera-Pro',
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('Fırat Üniversitesi Merkez/Elazığ'),
          ),
          const ListTile(
            leading: Icon(Icons.assignment_ind_outlined),
            title: Text(
              'İbrahim TÜRKOĞLU',
              style: TextStyle(
                fontFamily: 'Cera-Pro',
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('iturkoglu@firat.edu.tr'),
          ),
          const Divider(height: 1),
          const SizedBox(height: 30),
          Container(
            height: 100,
            decoration: const BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/images/firat.png')),
            ),
          )
        ],
      ),
    );
  }
}
