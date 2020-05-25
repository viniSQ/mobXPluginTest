import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learning/AddGroupScreen.dart';
import 'package:firebase_learning/controllers/main_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_mobx_plugin/app/base_screen.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';


final MainScreenController _controller = MainScreenController();

class MainScreen extends BaseScreen{

  // When it was in here, as in the plugin example, it would build ok once. But in the second time _controller groups would be null and the screen would stay forever with the progress indicator
  // final MainScreenController _controller = MainScreenController();

  @override
  Widget builder(BuildContext context, TextTheme textTheme) {
    return Column (
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible (
          child: Observer(
            builder: (_) {
              if(_controller.groups == null) return Center (child: CircularProgressIndicator());
              return ListView.builder(
                shrinkWrap: true,
                itemCount: _controller.groups.length,
                itemBuilder: (context, index) {
                  return _buildListItem(context, _controller.groups[index]);
                },
              );
            },
          ),
        )
      ],
    );
  }


  @override
  void didChangeDependencies(BuildContext context) {
    // TODO: implement didChangeDependencies
  }

  @override
  void dispose(BuildContext context) {
  }

  @override
  void init(BuildContext context) {
    _controller.fetchGroups();
    addReaction('test', reaction(
        (r) => _controller.groups,
        (groups) {
            /* Print always work */ print(groups.length);
            /* showMessage only work fisrt time*/ showMessage(groups.length.toString());

            Future.delayed(Duration(seconds: 2), () => showMessage(groups.length.toString()));
            // Unhandled Exception: NoSuchMethodError: The method 'showSnackBar' was called on null.
        }
    ));
  }

  @override
  String get title => "Test";

  @override
  Widget floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _addGroup(context),
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }


  void _addGroup(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddGroupScreen()));
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return InkWell (
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Stack (
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10),
              width: double.infinity,
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(document['title'], style: TextStyle(fontSize: 16)),
                  Text(document['description'], style: TextStyle(), maxLines: 2),
                ],
              ),
            ),
            Positioned (
              top: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20))
                ),
                child: IconButton (icon: Icon(Icons.open_in_new), onPressed: () {},),
              ),
            )
          ],
        ),

      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddGroupScreen(edit: document)));
      },
      onLongPress: () async {
        await document.reference.delete();
      },
    );
  }

}

