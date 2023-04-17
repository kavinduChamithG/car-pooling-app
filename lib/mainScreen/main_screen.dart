import 'package:carpooling_app/tabPages/earning_tab.dart';
import 'package:carpooling_app/tabPages/home_tab.dart';
import 'package:carpooling_app/tabPages/profile_tab.dart';
import 'package:carpooling_app/tabPages/ride_tab.dart';
import 'package:flutter/material.dart';


class MainScreen extends StatefulWidget
{

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin
{
  TabController? tabController;
  int selectedIndex = 0;

  onItemCLicked(int index)
  {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  void initState(){
    super.initState();

    tabController = TabController(length: 4, vsync: this);
  }
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: const [
              HomeTabPage(),
              EarningsTabPage(),
              RideTabPage(),
              ProfileTabPage(),
            ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: const [
                BottomNavigationBarItem(
                   icon: Icon(Icons.home),
                   label: "Home",
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.credit_card),
                  label: "Earnings",
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.car_rental),
                  label: "Ride",
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Account",
                ),
            ],
            unselectedItemColor: Colors.white54,
            selectedItemColor: Colors.white,
            backgroundColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(fontSize: 14),
            showUnselectedLabels: true,
            currentIndex: selectedIndex,
            onTap: onItemCLicked,
        ),
    );
  }
}
