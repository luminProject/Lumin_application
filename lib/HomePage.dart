import 'package:flutter/material.dart';
import 'Widgets/gradient_background.dart';
import 'Widgets/responsive_layout.dart';
import 'theme/app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: ResponsiveLayout(
        showAppBar: false, // لإعطاء مساحة أكبر للتصميم فوق الصورة
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // العنوان الرئيسي بنفس نمط Lumin
            const Text(
              "Welcome to Lumin",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 48),

            // حقل البريد الإلكتروني
            TextField(
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: "Email address",
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                prefixIcon: const Icon(Icons.email, color: AppColors.textSecondary),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05), // شفافية خفيفة لتناسب الخلفية
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // حقل كلمة المرور
            TextField(
              obscureText: true,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                prefixIcon: const Icon(Icons.lock, color: AppColors.textSecondary),
                suffixIcon: const Icon(Icons.visibility, color: AppColors.textSecondary),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // زر إنشاء الحساب باستخدام لون AppColors.button
            ElevatedButton(
              onPressed: () {
                // منطق تسجيل الدخول هنا
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Create Account",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}