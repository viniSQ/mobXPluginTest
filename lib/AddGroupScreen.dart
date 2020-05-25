import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learning/controllers/add_group_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class AddGroupScreen extends StatefulWidget {

  AddGroupScreen({this.edit});

  final DocumentSnapshot edit;
  final String title = "Add Group";

  @override
  _AddGroupScreenState createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {

  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _urlController = TextEditingController();

  AddGroupController controller = AddGroupController();

  @override
  void initState() {
    super.initState();

    if(widget.edit != null) {
      _titleController.text = widget.edit['title'];
      _descriptionController.text = widget.edit['description'];
      _urlController.text = widget.edit['url'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTextField(_titleController, 'Title'),
                _buildTextField(_descriptionController, 'Description'),
                _buildTextField(_urlController, 'URL'),
                _buildSubmitButton()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextFormField (
      controller: controller,
      decoration: InputDecoration (
        hasFloatingPlaceholder: true,
        labelText: hint
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container (
      width: double.infinity,
      child: RaisedButton.icon (
        color: Theme.of(context).primaryColor,
        label: Text(widget.edit == null ? "Submit" : "Apply Changes", style: TextStyle(color: Colors.white)),
        icon: controller.loading ? Padding (padding: EdgeInsets.only(right: 5), child: _getLoadingIcon()) : Container(),
        onPressed: () async {

          if(controller.loading) return;

          if(widget.edit == null) {
            controller.setLoading(true);
            await Firestore.instance.collection('groups').add({
              'title': _titleController.text,
              'description': _descriptionController.text,
              'url': _urlController.text
            });
            Navigator.of(context).pop();
          } else {

            controller.setLoading(true);

            dynamic data = {
              'title': _titleController.text,
              'description': _descriptionController.text,
              'url': _urlController.text
            };

            await Firestore.instance.runTransaction((transaction) async {
              DocumentSnapshot freshSnap = await transaction.get(widget.edit.reference);
              if(freshSnap != null) {
                await transaction.update(freshSnap.reference, data);
              }
            });
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }

  Widget _getLoadingIcon() {
    return SizedBox (
      width: 15,
      height: 15,
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }

}