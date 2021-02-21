import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:perial/DataLayer/Models/DUsers.dart';
import 'package:perial/DataLayer/Providers/feedback_position_provider.dart';
import 'package:perial/Widgets/bottom_buttons_widget.dart';
import 'package:perial/Widgets/user_card_widget.dart';
import 'package:provider/provider.dart';
import '../DataLayer/dummyData.dart';

class LoggedInHomeScreen extends StatefulWidget {
  @override
  _LoggedInHomeScreenState createState() => _LoggedInHomeScreenState();
}

class _LoggedInHomeScreenState extends State<LoggedInHomeScreen> {
  final List<DUser> users = dummyUsers;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              users.isEmpty
                  ? Text('No more users')
                  : Stack(children: users.map(buildUser).toList()),
              Expanded(child: Container()),
              BottomButtonsWidget()
            ],
          ),
        ),
      );

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

  Widget buildUser(DUser user) {
    final userIndex = users.indexOf(user);
    final isUserInFocus = userIndex == users.length - 1;

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
        child: UserCardWidget(user: user, isUserInFocus: isUserInFocus),
        feedback: Material(
          type: MaterialType.transparency,
          child: UserCardWidget(user: user, isUserInFocus: isUserInFocus),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) => onDragEnd(details, user),
      ),
    );
  }

  void onDragEnd(DraggableDetails details, DUser user) {
    final minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      user.isSwipedOff = true;
      print("right swipe on user: " + user.name);
      print(details.offset.dx);
      setState(() => users.remove(user));
    } else if (details.offset.dx < -minimumDrag) {
      user.isLiked = true;
      print("left swipe on user: " + user.name);
      print(details.offset.dx);
      setState(() => users.remove(user));
    }
  }
}
