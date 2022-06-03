import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prueba_3a/ui/gift_bloc/gift_bloc.dart';

class EatView extends StatefulWidget {
  const EatView({Key? key}) : super(key: key);

  @override
  State<EatView> createState() => _EatViewState();
}

class _EatViewState extends State<EatView> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: 1,
      length: 5,
      child: Scaffold(
          appBar: _customAppBar(context),
          bottomNavigationBar: _customBottomNV(),
          body: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: _rowNameButton(context, Icons.add)),
              _buttonsTabBar(),
              _tapBarViews(context, screenSize),
            ],
          )),
    );
  }

  Expanded _tapBarViews(BuildContext context, Size screenSize) {
    return Expanded(
      child: TabBarView(
        children: [
          Container(
            color: Colors.pink,
            child: const Center(
              child: Text(
                'All',
              ),
            ),
          ),
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: _rowNameButton(context, FontAwesomeIcons.trashCan),
                  ),
                  _locationCard(context, screenSize, 0),
                  _locationCard(context, screenSize, 1),
                  _locationCard(context, screenSize, 2),
                  _locationCard(context, screenSize, 0),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.red,
            child: const Center(
              child: Text(
                'Drinks',
              ),
            ),
          ),
          Container(
            color: Colors.pink,
            child: const Center(
              child: Text(
                'Beer',
              ),
            ),
          ),
          Container(
            color: Colors.pink,
            child: const Center(
              child: const Text(
                'Whatever',
              ),
            ),
          ),
        ],
      ),
    );
  }

  ButtonsTabBar _buttonsTabBar() {
    return ButtonsTabBar(
      radius: 15,
      elevation: 5,
      height: 60,
      buttonMargin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      backgroundColor: const Color(0xffEE7F3D),
      unselectedDecoration: const BoxDecoration(color: Colors.white),
      tabs: const [
        Tab(
          text: 'All',
        ),
        Tab(
          text: 'Happy Hours',
        ),
        Tab(
          text: 'Drinks',
        ),
        Tab(
          text: 'Beer',
        ),
        Tab(
          text: 'whatever',
        ),
      ],
    );
  }

  BottomNavyBar _customBottomNV() {
    return BottomNavyBar(
      items: [
        BottomNavyBarItem(
          icon: Icon(
            FontAwesomeIcons.house,
            color: Colors.black,
          ),
          title: Text(
            'Home',
            style: TextStyle(color: Colors.black),
          ),
          textAlign: TextAlign.center,
          activeColor: Colors.white,
        ),
        BottomNavyBarItem(
          icon: Icon(
            FontAwesomeIcons.calendar,
            color: Colors.black,
          ),
          title: Text(
            'Events',
            style: TextStyle(color: Colors.black),
          ),
          textAlign: TextAlign.center,
          activeColor: Colors.white,
        ),
        BottomNavyBarItem(
          icon: Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
          title: Text(
            'Search',
            style: TextStyle(color: Colors.black),
          ),
          activeColor: Colors.white,
        ),
        BottomNavyBarItem(
          icon: Icon(
            FontAwesomeIcons.heart,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
          title: Text(
            'Favoritos',
            style: TextStyle(color: Colors.black),
          ),
          activeColor: Colors.white,
        ),
      ],
      selectedIndex: _currentIndex,
      onItemSelected: (index) {
        setState(() => _currentIndex = index);
      },
    );
  }

  AppBar _customAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      leading: Image.asset('assets/nassaLogo.png'),
      leadingWidth: 100,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      actions: [
        Center(
          child: _neumoButton(context, FontAwesomeIcons.bell),
        ),
        const SizedBox(
          width: 10,
        ),
        Center(
          child: _neumoButton(context, FontAwesomeIcons.gear),
        ),
        const SizedBox(
          width: 30,
        ),
      ],
    );
  }

  NeumorphicButton _neumoButton(BuildContext context, IconData iconData) {
    return NeumorphicButton(
        margin: const EdgeInsets.only(top: 12),
        onPressed: () {
          NeumorphicTheme.of(context)?.themeMode =
              NeumorphicTheme.isUsingDark(context)
                  ? ThemeMode.light
                  : ThemeMode.dark;
        },
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          color: Colors.white,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(100)),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Icon(iconData, color: Colors.black));
  }

  Row _rowNameButton(BuildContext context, IconData iconData) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'Favorites',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
          ),
          _neumoButton(
            context,
            iconData,
          ),
        ]);
  }

  Center _gifBuild(Size screenSize, int index) {
    return Center(
      child: BlocBuilder<GiftBloc, GiftState>(
        builder: (context, state) {
          if (state is GiftInitial) {
            return const CircularProgressIndicator();
          } else if (state is GiftLoadedState) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: FadeInImage(
                placeholder: const AssetImage('assets/nassaLogo.png'),
                image: NetworkImage(state.model[index].original.url!),
                width: screenSize.width * .38,
                height: screenSize.height * .14,
                fit: BoxFit.cover,
              ),
            );
          } else {
            return Container(
              child: TextButton(onPressed: () {}, child: const Text("ok")),
            );
          }
        },
      ),
    );
  }

  _locationCard(BuildContext context, Size screenSize, int index) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: screenSize.width * .9,
        height: screenSize.height * .23,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Neumorphic(
            style: const NeumorphicStyle(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(FontAwesomeIcons.ellipsis, color: Colors.grey)
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: _gifBuild(screenSize, index),
                          ),
                          Positioned(
                            bottom: 0,
                            left: screenSize.width * .15,
                            child: Material(
                              borderRadius: BorderRadius.circular(30),
                              elevation: 4,
                              color: Colors.transparent,
                              child: Ink(
                                height: 35,
                                width: 35,
                                decoration: const ShapeDecoration(
                                  shape: CircleBorder(),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        FontAwesomeIcons.solidHeart,
                                        size: 18,
                                        color: Color(0xffEE7F3D)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          width: screenSize.width * .4,
                          child: const Text(
                            'Broken Shaker at Freehand Miani',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
