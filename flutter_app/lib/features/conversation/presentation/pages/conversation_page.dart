import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme.dart';
import 'package:flutter_app/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:flutter_app/features/conversation/presentation/bloc/conversations_event.dart';
import 'package:flutter_app/features/conversation/presentation/bloc/conversations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ConversationsBloc>(context).add(FetchConversations()); 
    }

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
              child: BlocBuilder<ConversationsBloc, ConversationsState>(
                builder: (context, state){
                  if (state is ConversationsLoading){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  else if (state is ConversationsLoaded){
                    return  ListView.builder(
                      itemCount: state.conversations.length,
                      itemBuilder: (context, index){
                        final conversation = state.conversations[index];
                        return _buildMessageTitle(
                          conversation.participantName, 
                          conversation.lastMessage,
                          conversation.lastMessageTime
                           );
                      },
                );
                  }
                  else if (state is ConversationsError) { 
                    return Center(child: Text(state.message),);
                  }
                  return Center(child: Text("No Conversation found"),);
                },
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
  Widget _buildMessageTitle(String name, String message, DateTime time){
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
      DateFormat('HH:mm').format(time),
      style: TextStyle(color: Colors.grey),
    ),
    );
    
  }

}