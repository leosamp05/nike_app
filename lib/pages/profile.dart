import 'package:flutter/material.dart';
import 'package:fui_kit/fui_kit.dart';
import 'package:nike_app/models/user_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isEditing = false;
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: UserService.instance.userName);
    _focusNode = FocusNode();
    UserService.instance.addListener(_onNameChanged);
  }

  @override
  void dispose() {
    UserService.instance.removeListener(_onNameChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onNameChanged() => setState(() {});

  void _toggleEditing() {
    setState(() {
      if (_isEditing) {
        // Salva e esci dalla modalità editing
        UserService.instance.setUserName(_controller.text);
        _isEditing = false;
      } else {
        // Entra in modalità editing
        _controller.text = UserService.instance.userName;
        _isEditing = true;
        // mette subito a fuoco il TextField
        Future.delayed(Duration(milliseconds: 100), () {
          FocusScope.of(context).requestFocus(_focusNode);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final name = UserService.instance.userName;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade500, width: 4),
              ),
              child: Center(
                child: FUI(
                  RegularRounded.USER,
                  height: 150,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_isEditing) ...[
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 4),
                        enabledBorder: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(),
                      ),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                      onSubmitted: (_) => _toggleEditing(),
                    ),
                  ),
                ] else ...[
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
                const SizedBox(width: 8),

                InkWell(
                  onTap: _toggleEditing,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child:
                        _isEditing
                            ? Icon(Icons.check, color: Colors.black54, size: 20)
                            : FUI(
                              RegularRounded.PENCIL,
                              color: Colors.black54,
                              height: 20,
                            ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
