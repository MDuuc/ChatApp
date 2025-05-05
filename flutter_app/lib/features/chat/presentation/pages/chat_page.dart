import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme.dart';
import 'package:flutter_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:flutter_app/features/chat/presentation/bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatPage extends StatefulWidget {
  final String conversationId;
  final String mate;
  const ChatPage({super.key, required this.conversationId, required this.mate});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final _storage = FlutterSecureStorage();
  String userId='';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatBloc>(context).add(LoadMessagesEvent(widget.conversationId));
    fetchUserId();
  }

  fetchUserId() async{
    userId = await _storage.read(key: 'userId')?? '';
    setState(() {
      userId = userId;
    });
  }

  void sendMessage() {
    final content = _messageController.text.trim();
    if (content.isNotEmpty) {
      BlocProvider.of<ChatBloc>(context).add(SendMessageEvent(widget.conversationId, content));
    }
    _messageController.clear();
  }

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
            Text(widget.mate, style: Theme.of(context).textTheme.titleLarge,)
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
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state){
                if(state is ChatLoadingState){
                  return Center(child: CircularProgressIndicator(),);
                }else if (state is ChatLoadedState){
                  return ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index){
                      final message = state.messages[index];
                      final isSentImage = message.senderId == userId;
                      if(isSentImage){
                        return _buildSentMessage(context, message.content);
                      }else{
                      return _buildReceiveMessage(context, message.content);
                      }
                    }
                  );
                }else if (state is ChatErrorState){
                  return Center(child: Text(state.message),);
                }
                return Center(child: Text("No messages found"),);
              }
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
                controller:  _messageController,
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
                onTap: (){
                  sendMessage();
                },
              )
          ],
        ),
      ),
    );
  }
}