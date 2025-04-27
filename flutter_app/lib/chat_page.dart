import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://wgwzbsfxetgyropkgmkq.supabase.co/storage/v1/object/public/image//1743416192160.jpg')
            ),
            SizedBox(width: 10,),
            Text('Danny', style: Theme.of(context).textTheme.titleLarge,)
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.search, ),
            )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                _buildReceiveMessage(context, 'hihihihi'),
                _buildReceiveMessage(context, 'hihihihi'),
                _buildSentMessage(context, 'hihihihi')

              ],
            )
            ),
            _buildMessageInput()
        ],
      ),
    );
  }

  Widget _buildReceiveMessage(BuildContext context, String message){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(right: 30, top: 5, bottom: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: DefaultColors.receiverMessage,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
  Widget _buildSentMessage(BuildContext context, String message){
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      margin: EdgeInsets.only(right: 30, top: 5, bottom: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: DefaultColors.senderMessage,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
    ),
  );
}
  Widget _buildMessageInput(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: DefaultColors.sentMessageInput,
        borderRadius: BorderRadius.circular(25)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            GestureDetector(
              child: Icon(
                Icons.camera_alt,
                color: Colors.grey,
              ),
              onTap:(){},
            ),
            SizedBox(width: 10,),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Message",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none
                ),
                style: TextStyle(color: Colors.white),
              )
              ),
              const SizedBox(width: 10,),
              GestureDetector(
                child: Icon(
                Icons.send,
                color: Colors.grey,
                ),
                onTap: (){},
              )
          ],
        ),
      ),
    );
  }
}