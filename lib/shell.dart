import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/nav_controller.dart';
import 'screens/home_screen.dart';


class HomeShell extends StatelessWidget{
  const HomeShell({super.key});


  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavController>();


    return Scaffold(
      appBar: AppBar(
        title: Text("Deneme"),
      ),
      body: IndexedStack(
        index: nav.index,
        children: [
          HomeScreen(),
          Center(child: Text('Search')),   // geçici placeholder
          Center(child: Text('Profile')),  // geçici placeholder
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: nav.index,
        onDestinationSelected: context.read<NavController>().setIndex,
        destinations: [
          NavigationDestination(
            icon: Image.asset("assets/icons/homepage.png", width: 24, height: 24),
            label: "Home"),
          NavigationDestination(
            icon: Image.asset("assets/icons/search.png", width: 24, height: 24,),
            label: "Serach"),
          NavigationDestination(
            icon: Image.asset("assets/icons/user.png", width: 24, height: 24),
            label: "User"),
        ],
      ),
    );


  }

}