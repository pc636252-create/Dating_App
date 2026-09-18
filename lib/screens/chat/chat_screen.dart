  // import 'package:flutter/material.dart';
  // import 'package:get/get.dart';
  // import 'package:cached_network_image/cached_network_image.dart';
  // import 'package:intl/intl.dart';
  // import '../../controllers/chat_controller.dart';
  // import '../../utils/app_colors.dart';
  //
  // class ChatScreen extends StatelessWidget {
  //   const ChatScreen({super.key});
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     final controller = Get.find<ChatController>();
  //
  //     return Scaffold(
  //       backgroundColor: Colors.white,
  //       appBar: AppBar(
  //         backgroundColor: Colors.white,
  //         titleSpacing: 0,
  //         title: Row(
  //           children: [
  //             Container(
  //               padding: const EdgeInsets.all(2),
  //               decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
  //               child: CircleAvatar(
  //                 radius: 22,
  //                 backgroundImage: CachedNetworkImageProvider(controller.conversation.avatar),
  //               ),
  //             ),
  //             // CircleAvatar(radius: 25, backgroundImage: CachedNetworkImageProvider(controller.conversation.avatar)),
  //             const SizedBox(width: 15),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(controller.conversation.name, style: const TextStyle(color: AppColors.textDark, fontSize: 16, fontWeight: FontWeight.bold)),
  //                 Obx(() => Text(
  //                     controller.isTyping.value ? 'typing....' : (controller.conversation.isOnline ? 'Online' : 'Offline'),
  //                     style: TextStyle(fontSize: 12, color: controller.isTyping.value ? AppColors.primary : AppColors.textGrey))),
  //               ],
  //             ),
  //           ],
  //         ),
  //         actions:  [
  //           Padding(
  //             padding: EdgeInsets.only(right: 16),
  //             child: Container(
  //               padding: const EdgeInsets.all(10),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(12),
  //                 boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)],
  //                 border:Border.all(
  //                   color: Colors.grey.shade300
  //                 )
  //               ),
  //               child: const Icon(Icons.more_vert, color: Colors.red),
  //             ),
  //           ),
  //         ],
  //       ),
  //       body: Column(
  //         children: [
  //           Expanded(
  //             child: GetBuilder<ChatController>(
  //               builder: (c) => ListView.builder(
  //                 controller: c.scrollController,
  //                 padding: const EdgeInsets.all(16),
  //                 itemCount: c.conversation.messages.length,
  //                 itemBuilder: (context, index) {
  //                   final msg = c.conversation.messages[index];
  //                   return Align(
  //                     alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
  //                     child: Container(
  //                       margin: const EdgeInsets.symmetric(vertical: 9),
  //                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  //                       constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
  //                       decoration: BoxDecoration(
  //                         color: msg.isMe ? AppColors.primary : const Color(0xFFF0F0F3),
  //                         borderRadius: BorderRadius.only(
  //                           topLeft: const Radius.circular(18),
  //                           topRight: const Radius.circular(18),
  //                           bottomLeft: Radius.circular(msg.isMe ? 18 : 4),
  //                           bottomRight: Radius.circular(msg.isMe ? 4 : 18),
  //                         ),
  //                       ),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.end,
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           Text(
  //                             msg.text,
  //                             style: TextStyle(color: msg.isMe ? Colors.white : AppColors.textDark, fontSize: 15),
  //                           ),
  //                           const SizedBox(height: 4),
  //                           Text(
  //                             DateFormat('HH:mm').format(msg.time),
  //                             style: TextStyle(
  //                               fontSize: 10,
  //                               color: msg.isMe ? Colors.white70 : AppColors.textGrey,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ),
  //           ),
  //           Obx(() => controller.isTyping.value
  //               ? const Padding(
  //                   padding: EdgeInsets.only(left: 20, bottom: 4),
  //                   child: Align(alignment: Alignment.centerLeft, child: Text('typing…', style: TextStyle(color: AppColors.textGrey))),
  //                 )
  //               : const SizedBox.shrink()),
  //           SafeArea(
  //             top: false,
  //             child: Padding(
  //               padding: EdgeInsets.all(12),
  //               child: Row(
  //                 children: [
  //                   Expanded(
  //                     child: Column(
  //                       children: [
  //                         TextField(
  //                           controller: controller.textController,
  //                           textInputAction: TextInputAction.send,
  //                           onSubmitted: (_) => controller.sendMessage(),
  //                           decoration: InputDecoration(
  //                             hintText: 'Your messages',
  //                             hintStyle: TextStyle(color: Colors.grey),
  //                             contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
  //                             suffixIcon: Icon(Icons.emoji_emotions_outlined, color: Colors.grey.shade400),
  //                             border: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(15),
  //                             ),
  //                             enabledBorder: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(15),
  //                               borderSide:  BorderSide(color: Colors.grey.shade300, width: 1.0),
  //                             ),
  //                             focusedBorder: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(15),
  //                               borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
  //                             ),
  //                           ),
  //                         ),
  //                  //        TextField(v
  //                  //      controller: controller.textController,
  //                  //  textInputAction: TextInputAction.send,
  //                  // onSubmitted: (_) => controller.sendMessage(),
  //                  //     decoration: InputDecoration(
  //                  //   hintText: 'Your message',
  //                  //    hintStyle: TextStyle(color: Colors.grey.shade400),
  //                  //      border: InputBorder.none,
  //                  //      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
  //                  //         suffixIcon: Icon(Icons.emoji_emotions_outlined, color: Colors.grey.shade400),
  //                  //   ),
  //                  // ),
  //                       ],
  //                     ),
  //                   ),
  //                   const SizedBox(width: 8),
  //                   GestureDetector(
  //                     onTap: controller.sendMessage,
  //                     child: Container(
  //                       padding: const EdgeInsets.all(10),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(12),
  //                         border: Border.all(
  //                           color: Colors.grey.shade400
  //                         ),
  //                         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)],
  //                       ),
  //                       child: const Icon(Icons.mic, color: Colors.red),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';
import '../../controllers/chat_controller.dart';
import '../../utils/app_colors.dart';

class ChatScreen extends StatelessWidget {
    const ChatScreen({super.key});

    @override
    Widget build(BuildContext context) {
      final controller = Get.put(ChatController());

      return Container(
        height: Get.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundImage: CachedNetworkImageProvider(controller.conversation.avatar),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.conversation.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Obx(() => Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: controller.isTyping.value
                                  ? AppColors.primary
                                  : (controller.conversation.isOnline ? Colors.red : Colors.grey),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            controller.isTyping.value
                                ? 'typing....'
                                : (controller.conversation.isOnline ? 'Online' : 'Offline'),
                            style: TextStyle(
                              color: controller.isTyping.value ? AppColors.primary : Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)],
                        border:Border.all(
                            color: Colors.grey.shade300
                        )
                    ),
                    child: const Icon(Icons.more_vert, color: Colors.black),
                  ),
                ],
              ),
            ),
            const Divider(height: 30),
            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey[200], thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Today',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey[200], thickness: 1)),
              ],
            ),
            Expanded(
              child: GetBuilder<ChatController>(
                builder: (c) => ListView.builder(
                  controller: c.scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: c.conversation.messages.length,
                  itemBuilder: (context, index) {
                    final msg = c.conversation.messages[index];
                    return Align(
                      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 9),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
                        decoration: BoxDecoration(
                          color: msg.isMe ? AppColors.primary : const Color(0xFFF0F0F3),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(18),
                            topRight: const Radius.circular(18),
                            bottomLeft: Radius.circular(msg.isMe ? 18 : 4),
                            bottomRight: Radius.circular(msg.isMe ? 4 : 18),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              msg.text,
                              style: TextStyle(color: msg.isMe ? Colors.white : AppColors.textDark, fontSize: 15),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat('HH:mm').format(msg.time),
                              style: TextStyle(
                                fontSize: 10,
                                color: msg.isMe ? Colors.white70 : AppColors.textGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 12,
                top: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.textController,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => controller.sendMessage(),
                      decoration: InputDecoration(
                        hintText: 'Your message',
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        suffixIcon: Icon(Icons.emoji_emotions_outlined, color: Colors.grey.shade400),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: controller.sendMessage,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey.shade100,
                      child: const Icon(Icons.mic, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }