import 'package:flutter/material.dart';
import 'screens/home_screen.dart';   // your Tickets tab (with header + tiles)
import 'screens/purchase_screen.dart';   // placeholder or your flow root
import 'screens/account_screen.dart';    // placeholder or your profile root

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  static _AppShellState? of(BuildContext context) {
    return context.findAncestorStateOfType<_AppShellState>();
  }

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  // one Navigator per tab, so each tab has independent back stack
  final _navKeys = List.generate(3, (_) => GlobalKey<NavigatorState>());

  void setTab(int i) => setState(() => _index = i);

  Future<bool> _onWillPop() async {
    final NavigatorState currentNav = _navKeys[_index].currentState!;
    if (currentNav.canPop()) {
      currentNav.pop();
      return false; // handled
    }
    return true; // allow app to close if nothing to pop
  }

  @override
  Widget build(BuildContext context) {
    final tabs = <Widget>[
      _TabNavigator(
        navKey: _navKeys[0],
        initial: const HomeScreen(), // your header + tiles tab
      ),
      _TabNavigator(
        navKey: _navKeys[1],
        initial: const PurchaseRoot(),
      ),
      _TabNavigator(
        navKey: _navKeys[2],
        initial: const AccountRoot(),
      ),
    ];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(index: _index, children: tabs),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: (i) => setTab(i),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_number),
              label: "Tickets",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Purchase",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "Account",
            ),
          ],
        ),
      ),
    );
  }
}

// A tiny Navigator wrapper used by each tab
class _TabNavigator extends StatelessWidget {
  const _TabNavigator({required this.navKey, required this.initial});

  final GlobalKey<NavigatorState> navKey;
  final Widget initial;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => initial,
        );
      },
    );
  }
}
