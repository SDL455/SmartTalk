import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp/cores/colors/%E0%BA%B1app_theme.dart';
import 'package:whatsapp/features/chat/views/widgets/editable_profile_field.dart';
import 'package:whatsapp/features/chat/controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryColor.withValues(alpha: 0.01),
                AppTheme.primaryColor,
                AppTheme.primaryColor.withValues(alpha: 0.01),
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        Center(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      AppTheme.primaryColor,
                                      AppTheme.primaryColor.withValues(
                                        alpha: 0.7,
                                      ),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.primaryColor.withValues(
                                        alpha: 0.2,
                                      ),
                                      blurRadius: 18,
                                      offset: Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 48,
                                  backgroundColor: Colors.grey[200],
                                  backgroundImage:
                                      controller.profileImage.value != null
                                      ? FileImage(
                                          controller.profileImage.value!,
                                        )
                                      : null,
                                  child: controller.profileImage.value == null
                                      ? Icon(
                                          Icons.person,
                                          size: 48,
                                          color: Colors.grey[400],
                                        )
                                      : null,
                                ),
                              ),
                              if (controller.isEditing.value ||
                                  controller.profileImage.value == null)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: controller.pickImage,
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppTheme.primaryColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.1,
                                            ),
                                            blurRadius: 8,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        controller.profileImage.value == null
                                            ? Icons.add_a_photo
                                            : Icons.camera_alt,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 24,
                              horizontal: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'ຂໍ້ມູນສ່ວນຕົວ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.primaryColor,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: controller.toggleEditMode,
                                      icon: Icon(
                                        controller.isEditing.value
                                            ? Icons.close
                                            : Icons.edit,
                                        color: AppTheme.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24),
                                EditableProfileField(
                                  label: 'ຊື່',
                                  controller: controller.firstNameController,
                                  isEditing: controller.isEditing.value,
                                  icon: Icons.person,
                                ),
                                SizedBox(height: 16),
                                EditableProfileField(
                                  label: 'ນາມສະກຸນ',
                                  controller: controller.lastNameController,
                                  isEditing: controller.isEditing.value,
                                  icon: Icons.person_outline,
                                ),
                                SizedBox(height: 16),
                                EditableProfileField(
                                  label: 'ເບີໂທ',
                                  controller: controller.phoneController,
                                  isEditing: controller.isEditing.value,
                                  icon: Icons.call,
                                ),
                                SizedBox(height: 16),
                                EditableProfileField(
                                  label: 'ອີເມວ',
                                  controller: controller.emailController,
                                  isEditing: controller.isEditing.value,
                                  icon: Icons.email,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(height: 16),
                                EditableProfileField(
                                  label: 'ລະຫັດ',
                                  controller: controller.passwordController,
                                  isEditing: controller.isEditing.value,
                                  icon: Icons.lock,
                                  isPassword: true,
                                  isPasswordVisible:
                                      controller.isPasswordVisible.value,
                                  onTogglePassword:
                                      controller.togglePasswordVisibility,
                                ),
                                if (controller.isEditing.value) ...[
                                  SizedBox(height: 32),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: controller.isLoading.value
                                          ? null
                                          : controller.saveProfile,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppTheme.primaryColor,
                                        foregroundColor: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        elevation: 2,
                                      ),
                                      child: controller.isLoading.value
                                          ? SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2.5,
                                              ),
                                            )
                                          : Text(
                                              'ບັນທຶກ',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          shape: const CircleBorder(),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: AppTheme.primaryColor,
                              size: 24,
                            ),
                            onPressed: () => Get.back(),
                            tooltip: 'ກັບຄືນ',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
