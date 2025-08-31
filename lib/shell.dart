// This is for navigating on the app

import 'package:demo/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/nav_controller.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';


class HomeShell extends StatelessWidget{
  const HomeShell({super.key});


  @override
  Widget build(BuildContext context) {

    
    final nav = context.watch<NavController>();
    

    return Scaffold(
      appBar: AppBar(
        title: Text("Film Rehberi"),
        backgroundColor: const Color.fromARGB(255, 100, 44, 97),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: IndexedStack(
        index: nav.index,
        children: [
          HomeScreen(),
          SearchScreen(),   
          ProfileScreen(),  // geçici placeholder
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: nav.index,
        onDestinationSelected: context.read<NavController>().setIndex,
        //backgroundColor: const Color.fromARGB(0, 80, 77, 77),
        destinations: [
          NavigationDestination(
            icon: Image.asset("assets/icons/homepage.png", width: 24, height: 24),
            label: "Ana"),
          NavigationDestination(
            icon: Image.asset("assets/icons/search.png", width: 24, height: 24,),
            label: "Ara"),
          NavigationDestination(
            icon: Image.asset("assets/icons/user.png", width: 24, height: 24),
            label: "Profil"),
        ],
      ),
    );


  }

}