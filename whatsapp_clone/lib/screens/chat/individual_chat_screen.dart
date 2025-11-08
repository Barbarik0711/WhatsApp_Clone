import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/model/chat_model.dart';
import 'package:whatsapp_clone/utils/color.dart';

class IndividualChatScreen extends StatefulWidget {
  const IndividualChatScreen({super.key, required this.chatModel});
  final ChatModel chatModel;
  @override
  State<IndividualChatScreen> createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> with SingleTickerProviderStateMixin {
  bool show = false; // Controls visibility of the emoji picker
  FocusNode focusNode = FocusNode(); // Manages focus for the text input
  final TextEditingController _controller = TextEditingController(); // Controller for text input

  // TabController is not used in this screen, it can be removed if not intended for use here.
  // TabController? _tabController; // Remove if not needed

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 4, vsync: this, initialIndex: 1); // Remove if not used
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false; // Hide emoji picker when text field gains focus
        });
      }
    });

    // Add a listener to the text controller to rebuild the UI when text changes
    // This allows the mic/send icon to dynamically change.
    _controller.addListener(() {
      setState(() {
        // Rebuilds the widget tree to update the send/mic icon.
        // No actual state variable needed, just forcing a rebuild.
      });
    });
  }

  @override
  void dispose() {
    // _tabController?.dispose(); // Dispose if used
    _controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 231, 159), // Background for chat screen, often a tiled image
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leadingWidth: 70,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_back, size: 24, color: Colors.white),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueGrey,
                child: widget.chatModel.isGroup!
                    ? SvgPicture.asset("assets/svg/group.svg", colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn), height: 20, width: 20)
                    : SvgPicture.asset("assets/svg/person.svg", colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn), height: 20, width: 20),
              ),
            ],
          ),
        ),
        titleSpacing: 0,
        title: InkWell(
          onTap: () {
            // Navigate to contact info screen
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chatModel.name!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
                Text(
                  "Last seen today at ${widget.chatModel.time}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.video_call, color: Colors.white)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call, color: Colors.white)),
          PopupMenuButton<String>(
            onSelected: (value) {
              debugPrint(value);
            },
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem<String>(
                  value: "View contact",
                  child: Text("View contact"),
                ),
                PopupMenuItem<String>(
                  value: "Media, links, and docs",
                  child: Text("Media, links, and docs"),
                ),
                PopupMenuItem<String>(
                  value: "Search",
                  child: Text("Search"),
                ),
                PopupMenuItem<String>(
                  value: "Mute notifications",
                  child: Text("Mute notifications"),
                ),
                PopupMenuItem<String>(
                  value: "Wallpaper",
                  child: Text("Wallpaper"),
                ),
                PopupMenuItem<String>(
                  value: "More",
                  child: Text("More"),
                ),
              ];
            },
            color: Colors.white,
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WillPopScope( // Added to handle back button for emoji picker
          onWillPop: () {
            if (show) {
              setState(() {
                show = false;
              });
              return Future.value(false); // Do not pop the screen, just hide emoji picker
            } else {
              return Future.value(true); // Pop the screen
            }
          },
          child: Stack(
            children: [
              ListView(), // This will eventually hold your chat messages
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Important: Makes the Column take minimum vertical space
                  children: [
                    // --- Message Input Row ---
                    Row(
                      children: [
                        // Text input field with prefix and suffix icons
                        SizedBox( // Use SizedBox for explicit width instead of Container if it only contains one child
                          width: MediaQuery.of(context).size.width - 55, // Adjusted width for text field
                          child: Card(
                            margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8, top: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextFormField(
                              controller: _controller,
                              focusNode: focusNode,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              onTap: () {
                                if (show) {
                                  setState(() {
                                    show = false; // Hide emoji picker if text field is tapped
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type a message",
                                // Emoji icon
                                prefixIcon: IconButton(
                                  icon: const Icon(Icons.emoji_emotions, color: Colors.grey),
                                  onPressed: () {
                                    if (!show) {
                                      // If emoji picker is currently hidden, hide keyboard and show emoji picker
                                      focusNode.unfocus();
                                      setState(() {
                                        show = true;
                                      });
                                    } else {
                                      // If emoji picker is shown, hide it and request focus for keyboard
                                      focusNode.requestFocus();
                                      setState(() {
                                        show = false;
                                      });
                                    }
                                  },
                                ),
                                // The corrected suffix icons (only icons within the text field)
                                suffixIcon: SizedBox(
                                  width: 100, // Adjust this width based on number of icons and desired spacing
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // Attach file icon (rotated)
                                      Transform.rotate(
                                        angle: -45 * (3.1415926535 / 180), // Convert degrees to radians
                                        child: InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              backgroundColor: Colors.transparent,
                                              context: context,
                                               builder: (builder) => bottomSheet()
                                               );
                                          },
                                          child: const Icon(Icons.attach_file, color: Colors.grey, size: 24),
                                        ),
                                      ),
                                      const SizedBox(width: 10), // Spacing between icons
                                      // Camera icon
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(Icons.camera_alt, color: Colors.grey, size: 24),
                                      ),
                                      const SizedBox(width: 5), // Small right padding for the last icon
                                    ],
                                  ),
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(0, 12, 0, 12), // Adjust padding
                              ),
                            ),
                          ),
                        ),
                        // Send/Mic button
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, right: 2), // Adjust padding to align with Card
                          child: CircleAvatar(
                            radius: 25, // Adjust size as needed
                            backgroundColor: AppColors.primaryColor,
                            child: IconButton(
                              icon: Icon(
                                _controller.text.isNotEmpty ? Icons.send : Icons.mic, // Dynamic icon based on text
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Handle mic/send button press
                                if (_controller.text.isNotEmpty) {
                                  // Send message
                                  debugPrint("Sending message: ${_controller.text}");
                                  _controller.clear();
                                } else {
                                  // Record voice message
                                  debugPrint("Recording voice message...");
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    // --- Emoji Picker ---
                    // This is placed below the message input row
                    show ? emojiSelector() : const SizedBox.shrink(), // Use SizedBox.shrink when not showing
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for the emoji picker, now with a defined height
  Widget emojiSelector() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35, // Adjust height as needed
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {
          // Add the selected emoji to the text field
          _controller.text = _controller.text + emoji.emoji;
        },
        onBackspacePressed: () {
          // Handle backspace (delete last character)
          _controller.text = _controller.text.characters.skipLast(1).toString();
        },
        
      ),
    );
  }

  Widget bottomSheet(){
    return SizedBox( // Use SizedBox instead of Container for fixed height to avoid potential issues if no constraints exist
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20,),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconCreationName(Icons.insert_drive_file,Colors.indigo,"Document"),
                const SizedBox(width: 40,),
                iconCreationName(Icons.camera_alt,Colors.pink,"Camera"),
                const SizedBox(width: 40,),
                iconCreationName(Icons.insert_photo,Colors.purple,"Gallery"),
              ],
            ),
            const SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconCreationName(Icons.headset,Colors.orange,"Audio"),
                const SizedBox(width: 40,),
                iconCreationName(Icons.location_pin,Colors.teal,"Location"),
                const SizedBox(width: 40,),
                iconCreationName(Icons.person,Colors.blue,"Contact"),
              ],
            )
          ],),
        ),
      ),
    );
  }

  Widget iconCreationName(IconData icon, Color color,String text){
    return InkWell(
      onTap: (){
        // Handle tap for each icon
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon, size: 28,
              color: Colors.white,),
          ),
          const SizedBox(height: 5,),
          Text(text,style: const TextStyle(
            fontSize: 12,
          ),),

        ],
      ),
    );
  }
}