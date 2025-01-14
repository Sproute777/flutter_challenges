import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterchallenges/modules/hidden_drawer_bottom_bar_fab/widgets/bottom_app_bar.dart';
import 'package:flutterchallenges/modules/hidden_drawer_bottom_bar_fab/widgets/multiple_fab.dart';
import 'package:flutterchallenges/theme/pallete_color.dart';

class HiddenMenuBottomBarFab extends StatefulWidget {
  const HiddenMenuBottomBarFab({super.key});

  @override
  State<HiddenMenuBottomBarFab> createState() => _HiddenMenuBottomBarFabState();
}

class _HiddenMenuBottomBarFabState extends State<HiddenMenuBottomBarFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final Duration duration = const Duration(milliseconds: 400);
  bool isCollapsed = true;
  double xOffset = 0;
  int currentIndex = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool _roundCornersForm = false;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 1.2).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var initial = 0.0;
    var distance = 0.0;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        statusBarIconBrightness:
            isCollapsed ? Brightness.dark : Brightness.light,
        statusBarBrightness: isCollapsed ? Brightness.dark : Brightness.light,
      ),
      child: ColoredBox(
        color:
            isCollapsed ? Colors.white : PalleteColor.backgroundMenuDrawerColor,
        child: SafeArea(
          child: GestureDetector(
            onPanStart: (DragStartDetails details) {
              initial = details.globalPosition.dx;
            },
            onPanUpdate: (DragUpdateDetails details) {
              distance = details.globalPosition.dx - initial;
            },
            onPanEnd: (DragEndDetails details) {
              initial = 0.0;
              if (distance > 180 && isCollapsed) openMenuDrawer();
              if (distance < -180 && !isCollapsed) openMenuDrawer();
              debugPrint('$distance');
            },
            child: Scaffold(
              backgroundColor: PalleteColor.backgroundMenuDrawerColor,
              body: SafeArea(
                child: Stack(
                  children: <Widget>[
                    const _MenuDrawer(),
                    AnimatedContainer(
                      transform: Matrix4.translationValues(xOffset, yOffset, 0)
                        ..scale(scaleFactor),
                      duration: const Duration(milliseconds: 250),
                      onEnd: () {
                        if (isCollapsed) {
                          setState(() {
                            _roundCornersForm = false;
                          });
                        }
                      },
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            _roundCornersForm ? 40.0 : 0.0,
                          ),
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(
                              top: _roundCornersForm ? 8.0 : 0.0,
                            ),
                            child: Scaffold(
                              extendBody: true,
                              body: Stack(
                                alignment: Alignment.bottomCenter,
                                children: <Widget>[
                                  IndexedStack(
                                    index: currentIndex,
                                    children: [
                                      _IndexedPages(
                                        backgroundColor: Colors.green,
                                        title: 'Page One',
                                        openDrawer: openMenuDrawer,
                                      ),
                                      _IndexedPages(
                                        backgroundColor: Colors.blue,
                                        title: 'Page Two',
                                        openDrawer: openMenuDrawer,
                                      ),
                                      _IndexedPages(
                                        backgroundColor: Colors.grey,
                                        title: 'Page Three',
                                        openDrawer: openMenuDrawer,
                                      ),
                                      _IndexedPages(
                                        backgroundColor: Colors.brown,
                                        title: 'Page Four',
                                        openDrawer: openMenuDrawer,
                                      ),
                                    ],
                                  ),
                                  const Positioned(
                                    bottom: 4,
                                    child: _FloatingActionButtonCustom(),
                                  ),
                                ],
                              ),
                              floatingActionButton: IgnorePointer(
                                child: SizedBox(
                                  width: 50,
                                  child: FloatingActionButton(
                                    onPressed: () {},
                                    elevation: 0,
                                    heroTag: null,
                                    foregroundColor: Colors.transparent,
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ),
                              floatingActionButtonLocation:
                                  FloatingActionButtonLocation.centerDocked,
                              bottomNavigationBar: _BottomBarCustom(
                                currentIndex: currentIndex,
                                updateIndex: (index) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void openMenuDrawer() {
    setState(() {
      if (isCollapsed) {
        xOffset = 230;
        _roundCornersForm = true;
        yOffset = 150;
        scaleFactor = 0.6;
        _controller.forward();
      } else {
        xOffset = 0;
        yOffset = 0;
        scaleFactor = 1;
        _controller.reverse();
      }

      isCollapsed = !isCollapsed;
    });
  }
}

class _MenuDrawer extends StatelessWidget {
  const _MenuDrawer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PalleteColor.backgroundMenuDrawerColor,
      body: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        padding: const EdgeInsets.only(left: 10, bottom: 5),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 50),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Sets',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                          const Icon(
                            Icons.arrow_drop_down_sharp,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {},
                        child: const _OptionMenuDrawer(
                          title: 'Navigation 1',
                          icon: Icon(
                            Icons.check_box_outline_blank,
                            size: 25,
                            color: PalleteColor.actionButtonColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const _OptionMenuDrawer(
                          title: 'Navigation 2',
                          icon: Icon(
                            Icons.people,
                            size: 25,
                            color: PalleteColor.actionButtonColor,
                          ),
                        ),
                      ),
                      const _OptionMenuDrawer(title: 'Navigation 3'),
                      GestureDetector(
                        onTap: () {},
                        child: const _OptionMenuDrawer(
                          title: 'Navigation 4',
                          icon: Icon(
                            Icons.chrome_reader_mode,
                            size: 25,
                            color: PalleteColor.actionButtonColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                const _OptionMenuDrawer(
                  title: 'Invite',
                  backgroundColorIcon: Colors.transparent,
                  icon: Icon(
                    Icons.person_add,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                const _OptionMenuDrawer(
                  title: 'Messages',
                  backgroundColorIcon: Colors.transparent,
                  icon: Icon(
                    Icons.textsms,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                const _OptionMenuDrawer(
                  title: 'Points',
                  backgroundColorIcon: Colors.transparent,
                  icon: Icon(
                    Icons.card_giftcard,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.account_circle),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'GuillermoDLCO',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  'Community',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _OptionMenuDrawer extends StatelessWidget {
  const _OptionMenuDrawer({
    required this.title,
    this.icon,
    this.backgroundColorIcon = Colors.white,
  });
  final String title;
  final Widget? icon;
  final Color backgroundColorIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: backgroundColorIcon,
            radius: 20,
            child: icon,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

typedef OnUpdateIndex = void Function(int index);

class _BottomBarCustom extends StatelessWidget {
  const _BottomBarCustom({
    required this.currentIndex,
    required this.updateIndex,
  });

  final int currentIndex;
  final OnUpdateIndex updateIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  color: PalleteColor.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(5),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 65, width: 85),
            Expanded(
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  color: PalleteColor.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(5),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
          child: BottomAppBarCustom(
            onTabSelected: updateIndex,
            notchedShape: const CircularNotchedRectangle(),
            selectedIndex: currentIndex,
            backgroundColor: Colors.white,
            color: PalleteColor.actionButtonColor.withOpacity(0.5),
            selectedColor: PalleteColor.actionButtonColor,
            items: [
              BottomAppBarItem(Icons.format_indent_increase, 'Page 1'),
              BottomAppBarItem(Icons.chrome_reader_mode, 'Page 2'),
              BottomAppBarItem(Icons.notifications, 'Page 3'),
              BottomAppBarItem(Icons.settings, 'Page 4'),
            ],
          ),
        )
      ],
    );
  }
}

class _FloatingActionButtonCustom extends StatefulWidget {
  const _FloatingActionButtonCustom();

  @override
  __FloatingActionButtonCustomState createState() =>
      __FloatingActionButtonCustomState();
}

class __FloatingActionButtonCustomState
    extends State<_FloatingActionButtonCustom>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration duration = const Duration(milliseconds: 600);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultipleFAB(
      controller: _controller,
      actionFirstButton: () {},
      backgroundColor: PalleteColor.actionButtonColor,
      icons: [
        Tooltip(
          message: 'Button 2',
          child: GestureDetector(
            onTap: () => print('Tap Button 2'),
            child: const Icon(
              Icons.create_new_folder,
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
        Tooltip(
          message: 'Button 3',
          child: GestureDetector(
            onTap: () => print('Tap Button 3'),
            child: const Icon(Icons.credit_card, color: Colors.white, size: 25),
          ),
        ),
        Tooltip(
          message: 'Button 1',
          child: GestureDetector(
            onTap: () => print('Tap Button 1'),
            child: const Icon(Icons.credit_card, color: Colors.white, size: 25),
          ),
        ),
        Tooltip(
          message: 'Button 4',
          child: GestureDetector(
            onTap: () => debugPrint('Tap Button 4'),
            child: const Icon(Icons.code, color: Colors.white, size: 25),
          ),
        ),
      ],
    );
  }
}

class _IndexedPages extends StatelessWidget {
  const _IndexedPages({
    required this.backgroundColor,
    required this.title,
    required this.openDrawer,
  });
  final Color backgroundColor;
  final String title;
  final VoidCallback openDrawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 40),
        child: _CustomAppBar(title: title, openDrawer: openDrawer),
      ),
      backgroundColor: PalleteColor.backgroundColor,
      body: const _BodyPage(),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({
    required this.title,
    required this.openDrawer,
  });
  final String title;
  final VoidCallback openDrawer;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: PalleteColor.actionButtonColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          size: 25,
          color: PalleteColor.actionButtonColor,
        ),
        onPressed: openDrawer,
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.format_align_center,
            size: 25,
            color: PalleteColor.actionButtonColor,
          ),
          onPressed: () {},
        )
      ],
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }
}

class _BodyPage extends StatelessWidget {
  const _BodyPage();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: const Column(
        children: <Widget>[
          _SeachBar(),
        ],
      ),
    );
  }
}

class _SeachBar extends StatelessWidget {
  const _SeachBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(8),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 0.1),
            color: PalleteColor.backgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.search, size: 20, color: Color(0xff8b8b8b)),
              ),
              Expanded(
                child: SizedBox(
                  height: 30,
                  child: TextField(
                    onTap: () {},
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0.1,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0.1,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 0.1,
                        ),
                      ),
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                        color: Color(0xff8b8b8b),
                        fontSize: 11,
                      ),
                      contentPadding: EdgeInsets.zero,
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
              ),
              const Icon(Icons.close, color: Colors.black)
            ],
          ),
        ),
      ),
    );
  }
}
