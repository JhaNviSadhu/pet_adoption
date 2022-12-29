import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/bloc/pet_bloc.dart';

import 'package:pet_adoption/model/model_animal.dart';
import 'package:pet_adoption/screens/animal_detail_screen.dart';
import 'package:pet_adoption/utils/colors.dart';
import 'package:pet_adoption/utils/constant.dart';
import 'package:pet_adoption/utils/images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _controller = ScrollController();
  static const _kBasePadding = 16.0;
  final maxExtent = 100.0;
  double currentExtent = 0.0;
  final ValueNotifier<double> _titlePaddingNotifier =
      ValueNotifier(_kBasePadding);
  static const double _appBarBottomBtnPosition = 42.0;

  final petBloc = PetBloc();

  @override
  void initState() {
    petBloc.eventSink.add(PetAction.fetch);
    _controller.addListener(() {
      setState(() {
        currentExtent = maxExtent - _controller.offset;
        if (currentExtent < 0) currentExtent = 0.0;
        if (currentExtent > maxExtent) currentExtent = maxExtent;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          _buildPetListView(deviceWidth),
        ],
      )),
    );
  }

  SliverToBoxAdapter _buildPetListView(deviceWidth) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Theme.of(context).primaryColor.withOpacity(0.3),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)),
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: const <Widget>[
                    Icon(
                      FontAwesomeIcons.search,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 18.0),
                        decoration: InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: 'Search pets to adopt'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder<List<Animal>>(
              stream: petBloc.petStream,
              builder: (context, snapshot) {
                return (snapshot.hasData)
                    ? ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AnimalDetailScreen(
                                    animal: snapshot.data?[index] ?? Animal(),
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 10.0,
                                right: 20.0,
                                left: 20.0,
                              ),
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(20.0),
                                    elevation: 4.0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                        vertical: 20.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(
                                            width: deviceWidth * 0.4,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: <Widget>[
                                                    Text(
                                                      "${snapshot.data?[index].name}",
                                                      style: TextStyle(
                                                        fontSize: 26.0,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Icon(
                                                      (snapshot.data?[index]
                                                                  .isFemale ==
                                                              true)
                                                          ? FontAwesomeIcons
                                                              .venus
                                                          : FontAwesomeIcons
                                                              .mars,
                                                      color: Colors.grey,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                Text(
                                                  "${snapshot.data?[index].scientificName}",
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                Text(
                                                  '${snapshot.data?[index].age}years old',
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .mapMarkerAlt,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      size: 16.0,
                                                    ),
                                                    const SizedBox(
                                                      width: 6.0,
                                                    ),
                                                    Text(
                                                      '${snapshot.data?[index].distanceToUser}',
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          color: primarycolor1,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        height: 190.0,
                                        width: deviceWidth * 0.4,
                                      ),
                                      Hero(
                                        tag: "${snapshot.data?[index].name}",
                                        child: Image(
                                          image: const AssetImage(
                                              "assets/icons/sola.png"),
                                          height: 220.0,
                                          fit: BoxFit.fitHeight,
                                          width: deviceWidth * 0.4,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text("${snapshot.error}"),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      titleTextStyle: const TextStyle(fontSize: 20),
      expandedHeight: maxExtent,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: false,
        titlePadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Pets",
            style: NunitoSemiBold.kTextStyle20,
          ),
        ),
      ),
    );
  }
}
