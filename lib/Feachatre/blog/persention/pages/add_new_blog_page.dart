import 'dart:io';
import 'package:blog_app/Core/Untill/pick_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Theme/App_ballet.dart';
import '../../../../Core/Untill/snackBar.dart';
import '../../../../Core/common/cubits/app_user_cubit.dart';
import '../../../../Core/constans/constans.dart';
import '../../../../Core/widgit/loadding.dart';
import '../bloc/blog_bloc.dart';
import '../widgets/blog_editor.dart';
import 'blog_page.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) =>  AddNewBlogPage(),
  );
   AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(
        BlogUpload(
          posterId: posterId,
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          image: image!,
          topics: selectedTopics,
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              uploadBlog();
            },
            icon:  Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          } else if (state is BlogUploadSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              BlogPage.route(),
                  (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return  Loader();
          }

          return SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                      onTap: selectImage,
                      child: SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                        : GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: DottedBorder(
                        color: AppPallete.borderColor,
                        dashPattern:  [10, 4],
                        radius:  Radius.circular(10),
                        borderType: BorderType.RRect,
                        strokeCap: StrokeCap.round,
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              SizedBox(height: 15),
                              Text(
                                'Select your image',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                     SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: Constants.topics
                            .map(
                              (e) => Padding(
                            padding:  EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                if (selectedTopics.contains(e)) {
                                  selectedTopics.remove(e);

                                  print(e);
                                } else {
                                  selectedTopics.add(e);
                                  print(e);
                                  print(selectedTopics);

                                }
                                setState(() {});
                              },
                              child: Chip(
                                label: Text(e),
                                color: selectedTopics.contains(e)
                                    ?  MaterialStatePropertyAll(
                                  AppPallete.gradient1,
                                )
                                    : null,
                                side: selectedTopics.contains(e)
                                    ? null
                                    :  BorderSide(
                                  color: AppPallete.borderColor,
                                ),
                              ),
                            ),
                          ),
                        )
                            .toList(),
                      ),
                    ),
                     SizedBox(height: 10),
                    BlogEditor(
                      controller: titleController,
                      hintText: 'Blog title',
                    ),
                     SizedBox(height: 10),
                    BlogEditor(
                      controller: contentController,
                      hintText: 'Blog content',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
