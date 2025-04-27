import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Message',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.search, ),
            )
        ],
      ),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Recent',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Container(
            height: 100,
            padding: EdgeInsets.all(5),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildRecentContact(context, 'Harry'),
                _buildRecentContact(context, 'Harry'),
                _buildRecentContact(context, 'Harry'),
                _buildRecentContact(context, 'Harry'),
                _buildRecentContact(context, 'Harry'),
                _buildRecentContact(context, 'Harry'),
                _buildRecentContact(context, 'Harry'),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color:  DefaultColors.messageListPage,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),

                )
              ),
              child: ListView(
                scrollDirection: Axis.vertical,
                  children: [
                    _buildMessageTitle("Kious", "Hiloo", '20:10'),
                    _buildMessageTitle("Kious", "Hiloo", '20:10'),
                    _buildMessageTitle("Kious", "Hiloo", '20:10'),
                    _buildMessageTitle("Kious", "Hiloo", '20:10'),
                    _buildMessageTitle("Kious", "Hiloo", '20:10'),
                  ],
              ),
            )
            )
        ],
      ),
    );
  }
  Widget _buildRecentContact(BuildContext context, String name){
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage:NetworkImage('https://wgwzbsfxetgyropkgmkq.supabase.co/storage/v1/object/public/image//1743416192160.jpg') ,
        ),
        SizedBox(
          height: 5,
        ),
        Text(name, style: Theme.of(context).textTheme.bodyMedium,),
      ],
    ),
    );
  }
  Widget _buildMessageTitle(String name, String message, String time){
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: CircleAvatar(
        radius: 30,
          backgroundImage:NetworkImage('https://wgwzbsfxetgyropkgmkq.supabase.co/storage/v1/object/public/image//1743416192160.jpg') ,
      ),
    title: Text(
      name, 
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      message,
      style: TextStyle(color: Colors.grey),
      overflow: TextOverflow.ellipsis,
    ),
    trailing: Text(
      time,
      style: TextStyle(color: Colors.grey),
    ),
    );
    
  }

}