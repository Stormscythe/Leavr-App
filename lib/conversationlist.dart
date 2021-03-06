import 'package:flutter/material.dart';
import 'utils/apiclient.dart';
import './chatpane.dart';

class ConversationList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ConversationListState();
}

class ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: ApiClient.fetchConversations(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return snapshot.data[index];
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
        //children: messages,
        );
  }
}

class ConversationListItem extends StatefulWidget {
  String message;
  String licensePlate;
  int id;
  ConversationListItem(this.id, this.licensePlate, this.message);
  @override
  State<StatefulWidget> createState() => ConversationListItemState(id, licensePlate, message);
}

class ConversationListItemState extends State<ConversationListItem> {
  String message;
  String licensePlate;
  int id;
  ConversationListItemState(this.id, this.licensePlate, this.message);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[Icon(Icons.message)],
      ),
      title: Text(licensePlate),
      subtitle: Text(message),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Conversation(id, licensePlate, licensePlate),
          ),
        ).then((value) => setState(() {message = value;}));
      },
    );
  }
}
