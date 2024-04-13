import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_expenses/add_expense.dart';

class BottomNavigation extends StatefulWidget {

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> appViews = [
      const Text('home'),
      AddExpenses(),
      const Text('dhgshddwddsh')
    ];

    void _onItemTapped(int index) {
      setState(() {
        print(index);
        _selectedIndex = index;

        String? currentPath;
        print('currentPath: $currentPath');
      });
    }

    return Scaffold(
      body: appViews[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.red,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Expense',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Account',
          )
        ],
      ),
    );

    // return BottomNavigationBar(
    //   backgroundColor: Colors.white,
    //   selectedItemColor: Colors.purple,
    //   unselectedItemColor: Colors.redAccent,
    //   currentIndex: _selectedIndex,
    //   onTap: _onItemTapped,
    //   items: const [
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.home),
    //       label: 'Home',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.add),
    //       label: 'Add Expense',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.people),
    //       label: 'Account',
    //     )
    //   ],
    // );
  }
}
