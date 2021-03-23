import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:perial/DataLayer/DataService.dart';
import 'package:perial/DataLayer/Models/CurrentUser.dart';
import 'package:perial/DataLayer/Models/DUsers.dart';
import 'package:perial/DataLayer/Models/Member.dart';
import 'package:perial/DataLayer/Models/UserDislike.dart';
import 'package:perial/DataLayer/Models/UserLike.dart';
import 'package:perial/DataLayer/Operations/DislikesOperations.dart';
import 'package:perial/DataLayer/Operations/LikesOperations.dart';
import 'package:perial/DataLayer/Operations/MemberOperations.dart';
import 'package:perial/DataLayer/Providers/LikesProvider.dart';
import 'package:perial/DataLayer/Providers/MemberProvider.dart';
import 'package:perial/DataLayer/Providers/feedback_position_provider.dart';
import 'package:perial/Screens/RegisterScreen.dart';
import 'package:perial/Widgets/bottom_buttons_widget.dart';
import 'package:perial/Widgets/user_card_widget.dart';
import 'package:provider/provider.dart';
import '../DataLayer/dummyData.dart';

class LoggedInHomeScreen extends StatefulWidget {
  @override
  _LoggedInHomeScreenState createState() => _LoggedInHomeScreenState();
}

class _LoggedInHomeScreenState extends State<LoggedInHomeScreen>
    with TickerProviderStateMixin {
  List<Member> members = [];
  List<UserLike> likedUsers = [];
  List<UserDislike> dislikedUsers = [];
  Member currentUser;

  TabController _tabController;
//todo: create profile page

  @override
  void initState() {
    super.initState();
    getMembers();
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.index = 1;
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  Future<void> getMembers() async {
    await getLikes("liked");
    await getDislikes("disliked");
    var data = await MemberOperations().getMembers();
    setState(() {
      members = _getUniqueList(likedUsers, data);
      members = _getUniqueListFromDislikes(dislikedUsers, members);
    });
  }

  Future<void> getLikes(String command) async {
    var data = await LikesOperations().getLikes(command);
    setState(() {
      likedUsers = data;
    });
  }

  Future<void> getDislikes(String command) async {
    var data = await DislikesOperations().getDislikes(command);
    setState(() {
      dislikedUsers = data;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              elevation: 2,
              backgroundColor: Colors.white,
              leading: Container(),
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                      child: Icon(FontAwesomeIcons.dog,
                          color: _tabController.index == 0
                              ? Colors.deepOrange
                              : Colors.grey)),
                  Tab(
                      child: FaIcon(FontAwesomeIcons.paw,
                          color: _tabController.index == 1
                              ? Colors.deepOrange
                              : Colors.grey)),
                  Tab(
                    child: Icon(Icons.chat,
                        color: _tabController.index == 2
                            ? Colors.deepOrange
                            : Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [_profilePage(), _swipePage(), _chattPage()],
          ),
        ),
      ),
    );
  }

  List<Member> _getUniqueList(List<UserLike> likedUsers, List<Member> members) {
    List<Member> uniqueListMember = [];
    for (var member in members) {
      bool match = false;
      for (var likedUser in likedUsers) {
        if (member.userName == likedUser.username) {
          match = true;
          break;
        }
      }
      if (!match) uniqueListMember.add(member);
    }
    return uniqueListMember;
  }

  List<Member> _getUniqueListFromDislikes(
      List<UserDislike> dislikedUsers, List<Member> members) {
    List<Member> uniqueListMember = [];
    for (var member in members) {
      bool match = false;
      for (var dislikedUser in dislikedUsers) {
        if (member.userName == dislikedUser.username) {
          match = true;
          break;
        }
      }
      if (!match) uniqueListMember.add(member);
    }
    return uniqueListMember;
  }

  Widget _swipePage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          members.isEmpty
              ? Column(
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Looking for that special dog...'),
                  ],
                )
              : Stack(children: members.map(buildUser).toList()),
          Expanded(child: Container()),
          BottomButtonsWidget()
        ],
      ),
    );
  }

  Widget _profilePage() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                DataService().getCurrentUser().mainPhoto,
              ),
              radius: 50.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            DataService().getCurrentUser().username,
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.grey[900],
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            DataService().getCurrentUser().city,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.grey[700],
            ),
          )
        ]);
  }

  Widget _chattPage() {
    return Text("chatt");
  }

  Widget buildAppBar() => AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Icon(Icons.chat, color: Colors.grey),
          SizedBox(width: 16),
        ],
        leading: GestureDetector(
            onTap: () {},
            child: Icon(FontAwesomeIcons.dog, color: Colors.grey)),
        title: FaIcon(FontAwesomeIcons.paw, color: Colors.deepOrange),
      );

  Widget buildUser(Member member) {
    final userIndex = members.indexOf(member);
    final isUserInFocus = userIndex == members.length - 1;
    return Listener(
      onPointerMove: (pointerEvent) {
        final provider =
            Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.updatePosition(pointerEvent.localDelta.dx);
      },
      onPointerCancel: (_) {
        final provider =
            Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.resetPosition();
      },
      onPointerUp: (_) {
        final provider =
            Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.resetPosition();
      },
      child: Draggable(
        child: UserCardWidget(member: member, isUserInFocus: isUserInFocus),
        feedback: Material(
          type: MaterialType.transparency,
          child: UserCardWidget(member: member, isUserInFocus: isUserInFocus),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) => onDragEnd(details, member),
      ),
    );
  }

  Future<void> onDragEnd(DraggableDetails details, Member member) async {
    print(details.offset.dx);
    final minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      setState(() => members.remove(member));
      await LikesOperations().addLike(member.userName);
      await getMembers();
    } else if (details.offset.dx < -minimumDrag) {
      setState(() => members.remove(member));
      await DislikesOperations().addDislike(member.userName);
      await getMembers();
    }
  }
}
