import 'package:egg_note/framework/core/core_behavior.dart';
import 'package:egg_note/framework/core/core_view.dart';
import 'package:egg_note/framework/res/res_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'adjustment/adjusment.dart';
import 'dashboard/dashboard_view.dart';

class HomeData {
  int selectedIndex = 0;
}

class HomeBehavior extends CoreBehavior<HomeView, HomeBehavior, HomeData> {
  @override
  Future<HomeData> initState() async {
    return HomeData();
  }

  void changeMenu(index) {
    state.selectedIndex = index;
    render();
  }
}

class HomeView extends CoreView<HomeView, HomeBehavior, HomeData> {
  @override
  HomeBehavior initBehavior() {
    return HomeBehavior();
  }

  @override
  Widget loadScreen(
      BuildContext context, HomeBehavior behavior, HomeData state) {
    List<Widget> _widgetOptions = <Widget>[DashboardView(), AdjusmentView()];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(state.selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ResColor.appBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300],
              hoverColor: Colors.grey[100],
              gap: 8,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100],
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  backgroundColor: Colors.deepOrange[400],
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.adjust,
                  backgroundColor: Colors.yellow[100],
                  text: 'Pengaturan',
                ),
              ],
              selectedIndex: state.selectedIndex,
              onTabChange: (index) {
                behavior.changeMenu(index);
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget onLoadingView(BuildContext context) {
    return Container();
  }
}
