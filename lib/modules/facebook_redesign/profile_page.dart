import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterchallenges/gen/assets.gen.dart';
import 'package:flutterchallenges/modules/facebook_redesign/blocs/theme_bloc.dart';
import 'package:flutterchallenges/modules/facebook_redesign/widgets/avatar_profile.dart';
import 'package:flutterchallenges/theme/app_theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeBloc = context.watch<ThemeBloc>();
    final isLight = themeBloc.state.appThemeType == AppTheme.light;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor:
            isLight ? Colors.white : theme.bottomAppBarColor,
        systemNavigationBarIconBrightness:
            isLight ? Brightness.dark : Brightness.light,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: theme.colorScheme.background,
          body: const _ProfileBody(),
        ),
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Stack(
      children: [
        Stack(
          children: [
            SizedBox(
              height: size.height * .3,
              width: double.infinity,
              child: Assets.facebookRedesign.banner.image(
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  height: size.width * .08,
                  width: size.width * .08,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.hoverColor,
                  ),
                  padding: const EdgeInsets.only(right: 2),
                  alignment: Alignment.center,
                  child: Assets.facebookRedesign.iosArrowBack.svg(
                    width: size.width * .02,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: size.width * .08,
                  width: size.width * .08,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.hoverColor,
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/facebook_redesign/search.svg',
                    color: Colors.white,
                    width: size.width * .03,
                  ),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: size.height * .7,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(34),
                    topRight: Radius.circular(34),
                  ),
                  color: theme.primaryColor,
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(height: size.height * .1),
                    Column(
                      children: [
                        Text(
                          'Mao Lop',
                          style: TextStyle(
                            color: theme.textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _TextInformation(text: 'Mauricio Lopez'),
                            _VerticalDivider(),
                            _TextInformation(text: 'Diseñador UI/UX'),
                            _VerticalDivider(),
                            _TextInformation(text: 'Developer'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff1977F3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                minimumSize: const Size(105, 34),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/facebook_redesign/messenger.svg',
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Mensaje',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24)),
                                ),
                                side: BorderSide(
                                  color: theme.highlightColor,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                              ),
                              child: Text(
                                'Llamar',
                                style: TextStyle(
                                  color: theme.highlightColor,
                                  fontSize: 15,
                                  height: 1.3,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffE2E2E2)),
                                shape: BoxShape.circle,
                                color: theme.primaryColor,
                              ),
                              padding: const EdgeInsets.all(10),
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              child: Assets.facebookRedesign.moreOptions.svg(
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: const Color(0xff707070).withOpacity(.3),
                            thickness: 1,
                            height: 30,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              _BasicInformationText(
                                icon: 'assets/facebook_redesign/home.svg',
                                text: 'Vive en Zihuatanejo, Guerrero, México.',
                              ),
                              _BasicInformationText(
                                icon: 'assets/facebook_redesign/clock.svg',
                                text: 'Se unió en: Septiembre de 2010',
                              ),
                              _BasicInformationText(
                                icon:
                                    'assets/facebook_redesign/information.svg',
                                text: 'Ver más información de Mao',
                              ),
                            ],
                          ),
                        ),
                        const _ScrollCollections(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: const Color(0xff707070).withOpacity(.3),
                            thickness: 0.7,
                            height: 10,
                          ),
                        ),
                        const _FriendsSection(),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -size.height * .14,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff1977F3),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: AvatarProfile(
                    radius: size.height * .1,
                    image: 'assets/facebook_redesign/stories_1.png',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FriendsSection extends StatelessWidget {
  const _FriendsSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Amigos',
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                '(2,004 amigos)',
                style: TextStyle(
                  color: theme.textTheme.bodyMedium?.color,
                  fontSize: 19,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xff1977F3),
                  padding: const EdgeInsets.only(left: 2),
                  alignment: Alignment.centerLeft,
                  textStyle: const TextStyle(fontSize: 14),
                ),
                child: const Text('Ver todos'),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _FriendAvatar(
                profileImage: 'assets/facebook_redesign/stories_2.png',
                name: 'Wilber Garcia',
              ),
              _FriendAvatar(
                profileImage: 'assets/facebook_redesign/stories_4.png',
                name: 'Michael Gais',
              ),
              _FriendAvatar(
                profileImage: 'assets/facebook_redesign/stories_3.png',
                name: 'Daniela López',
              ),
              _FriendAvatar(
                profileImage: 'assets/facebook_redesign/stories_6.png',
                name: 'Sarai Perez',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScrollCollections extends StatelessWidget {
  const _ScrollCollections();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .17,
      margin: const EdgeInsets.only(top: 22),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          SizedBox(width: 15),
          _CollectionCard(
            profileImage: 'assets/facebook_redesign/stories_1.png',
            name: 'Colección',
          ),
          _CollectionCard(
            profileImage: 'assets/facebook_redesign/stories_5.png',
            name: 'Colección',
          ),
          _CollectionCard(
            profileImage: 'assets/facebook_redesign/stories_4.png',
            name: 'Colección',
          ),
          _CollectionCard(
            profileImage: 'assets/facebook_redesign/stories_5.png',
            name: 'Colección',
          ),
          _CollectionCard(
            profileImage: 'assets/facebook_redesign/stories_6.png',
            name: 'Colección',
          ),
          SizedBox(width: 15),
        ],
      ),
    );
  }
}

class _CollectionCard extends StatelessWidget {
  const _CollectionCard({
    required this.profileImage,
    required this.name,
  });

  final String profileImage;
  final String name;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: size.height * .13,
                width: size.height * .1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(profileImage),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              name,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FriendAvatar extends StatelessWidget {
  const _FriendAvatar({
    required this.profileImage,
    required this.name,
  });

  final String profileImage;
  final String name;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: size.height * .1,
                width: size.height * .1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(profileImage),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              name,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BasicInformationText extends StatelessWidget {
  const _BasicInformationText({
    required this.icon,
    required this.text,
  });

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: size.width * .03,
            color: const Color(0xffC5CBDD),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontSize: 14,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _TextInformation extends StatelessWidget {
  const _TextInformation({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: TextStyle(color: theme.textTheme.bodyMedium?.color, fontSize: 15),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 1,
        height: 20,
        color: const Color(0xff707070).withOpacity(.2),
      ),
    );
  }
}
