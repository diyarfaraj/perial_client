import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:perial/DataLayer/DataService.dart';
import 'package:perial/DataLayer/Models/DUsers.dart';
import 'package:perial/DataLayer/Models/Member.dart';
import 'package:perial/DataLayer/Models/UserLike.dart';
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

class _LoggedInHomeScreenState extends State<LoggedInHomeScreen> {
  List<Member> members = [];
  List<UserLike> likedUsers = [];

  @override
  void initState() {
    super.initState();
    getMembers();
  }

  Future<void> getMembers() async {
    await getLikes("liked");
    var data = await MemberOperations().getMembers();
    setState(() {
      members = _getUniqueList(likedUsers, data);
    });
  }

  Future<void> getLikes(String command) async {
    var data = await LikesOperations().getLikes(command);
    setState(() {
      likedUsers = data;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            members.isEmpty
                ? Text('No more dogs')
                : Stack(children: members.map(buildUser).toList()),
            Expanded(child: Container()),
            BottomButtonsWidget()
          ],
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

  Widget buildAppBar() => AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Icon(Icons.chat, color: Colors.grey),
          SizedBox(width: 16),
        ],
        leading: Icon(FontAwesomeIcons.dog, color: Colors.grey),
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

//todo: make dislike in api and call it here
  Future<void> onDragEnd(DraggableDetails details, Member member) async {
    final minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      setState(() => members.remove(member));
      await LikesOperations().addLike(member.userName);
      await getMembers();
    } else if (details.offset.dx < -minimumDrag) {
      setState(() => members.remove(member));
    }
  }
}
