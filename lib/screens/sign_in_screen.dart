import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';
import '../providers/app_state.dart';
import 'home_screen.dart';
import '../widgets/primary_button.dart';
import '../widgets/ghost_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _logoRotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _logoRotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.alabaster,
              AppTheme.pinkContainer.withOpacity(0.3),
            ],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 20 : 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: isSmallScreen ? 60 : 80),

              // Animated Logo/Header
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Animated Logo with rotation
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 1000),
                        builder: (context, double value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Transform.rotate(
                              angle: _logoRotationAnimation.value * 0.5,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppTheme.primaryGreen,
                                      AppTheme.primaryContainer,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.primaryGreen
                                          .withOpacity(0.3),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: AnimatedIcon(
                                  icon: AnimatedIcons.menu_arrow,
                                  progress: _animationController,
                                  color: AppTheme.alabaster,
                                  size: 40,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      // Animated text with gradient shimmer
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            AppTheme.primaryGreen,
                            AppTheme.richGold,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 500),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                fontSize: isSmallScreen ? 36 : 48,
                                height: 1.1,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ) ?? const TextStyle(),
                          child: const Text('The Floral\nAtelier'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOut,
                        child: Text(
                          'WELCOME BACK TO THE WORLD OF BOTANICAL PRESTIGE.',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppTheme.outline,
                                    height: 1.5,
                                    letterSpacing: 1.2,
                                    fontSize: isSmallScreen ? 10 : 12,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // Form Fields with staggered animations
              ..._buildAnimatedFormFields(isSmallScreen),

              const SizedBox(height: 40),

              // Sign In Button
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.1),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
                    ),
                  ),
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppTheme.primaryGreen,
                                ),
                              ),
                            )
                          : PrimaryButton(
                              label: 'Sign In',
                              onPressed: () => _handleSignIn(),
                            ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Divider with animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppTheme.outline.withOpacity(0.3),
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontSize: 10,
                                    color: AppTheme.outline.withOpacity(0.5),
                                  ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppTheme.outline.withOpacity(0.3),
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Google Sign In Button
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.1),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
                    ),
                  ),
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.95, end: 1.0),
                    duration: const Duration(milliseconds: 400),
                    builder: (context, double value, child) {
                      return Transform.scale(scale: value, child: child);
                    },
                    child: GhostButton(
                      label: 'Continue with Google',
                      onPressed: () => _handleGoogleSignIn(),
                      icon: Icons.g_mobiledata,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // Sign Up Link
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.1),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
                    ),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        _navigateToSignUp();
                      },
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: 10,
                              color: AppTheme.outline,
                              letterSpacing: 0.8,
                            ) ?? const TextStyle(),
                        child: Text.rich(
                          TextSpan(
                            text: "DON'T HAVE AN ACCOUNT? ",
                            children: [
                              TextSpan(
                                text: 'CREATE ONE',
                                style: TextStyle(
                                  color: AppTheme.primaryGreen,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppTheme.primaryGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAnimatedFormFields(bool isSmallScreen) {
    return [
      FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.2),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
            ),
          ),
          child: _buildEmailField(isSmallScreen),
        ),
      ),
      const SizedBox(height: 24),
      FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.2),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
            ),
          ),
          child: _buildPasswordField(isSmallScreen),
        ),
      ),
      const SizedBox(height: 12),
      FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.2),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0.35, 1.0, curve: Curves.easeOut),
            ),
          ),
          child: _buildForgotPasswordButton(),
        ),
      ),
    ];
  }

  Widget _buildEmailField(bool isSmallScreen) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'EMAIL ADDRESS',
          prefixIcon: Icon(
            Icons.email_outlined,
            color: AppTheme.primaryGreen.withOpacity(0.6),
            size: 20,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppTheme.primaryGreen,
              width: 2,
            ),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
      ),
    );
  }

  Widget _buildPasswordField(bool isSmallScreen) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          labelText: 'PASSWORD',
          prefixIcon: Icon(
            Icons.lock_outline,
            color: AppTheme.primaryGreen.withOpacity(0.6),
            size: 20,
          ),
          suffixIcon: IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                key: ValueKey(_obscurePassword),
                color: AppTheme.primaryGreen.withOpacity(0.6),
              ),
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppTheme.primaryGreen,
              width: 2,
            ),
          ),
        ),
        style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 600),
        builder: (context, double value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(20 * (1 - value), 0),
              child: child,
            ),
          );
        },
        child: TextButton(
          onPressed: () {
            _showForgotPasswordDialog();
          },
          style: TextButton.styleFrom(
            foregroundColor: AppTheme.richGold,
          ),
          child: Text(
            'FORGOT PASSWORD?',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 10,
                  color: AppTheme.richGold,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignIn() async {
    if (_emailController.text.trim().isEmpty) {
      _showErrorSnackBar('Please enter your email');
      return;
    }

    if (_passwordController.text.isEmpty) {
      _showErrorSnackBar('Please enter your password');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final appState = Provider.of<AppState>(context, listen: false);

      await appState.signIn(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (mounted) {
        context.go('/profile');
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar(e.toString().replaceAll('Exception:', ''));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final appState = Provider.of<AppState>(context, listen: false);

      await appState.signInWithGoogle();

      if (mounted) {
        context.go('/profile');
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar(e.toString().replaceAll('Exception:', ''));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showForgotPasswordDialog() {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.8, end: 1.0),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutBack,
          builder: (context, double scale, child) {
            return Transform.scale(scale: scale, child: child);
          },
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [Colors.white, AppTheme.pinkContainer.withOpacity(0.3)],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryGreen.withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.email_outlined,
                    size: 60,
                    color: AppTheme.primaryGreen,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Reset Password',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Enter your email address to receive a password reset link.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    prefixIcon: Icon(Icons.email_outlined,
                        color: AppTheme.primaryGreen),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);

                          try {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                              email: emailController.text.trim(),
                            );
                            _showErrorSnackBar(
                              'Password reset email sent! Check your inbox.',
                            );
                          } catch (e) {
                            _showErrorSnackBar(
                              'Failed to send reset email. Please try again.',
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryGreen,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Send'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToSignUp() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SignUpScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}

// Sign Up Screen with Enhanced Animations
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _formScaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _formScaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.alabaster,
              AppTheme.pinkContainer.withOpacity(0.3),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 20 : 32,
              vertical: isSmallScreen ? 20 : 40,
            ),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _formScaleAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Animated Back Button
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: -20, end: 0),
                        duration: const Duration(milliseconds: 500),
                        builder: (context, double value, child) {
                          return Transform.translate(
                            offset: Offset(value, 0),
                            child: child,
                          );
                        },
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Animated Title
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            AppTheme.primaryGreen,
                            AppTheme.richGold,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 500),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                fontSize: isSmallScreen ? 28 : 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ) ?? const TextStyle(),
                          child: const Text('Create Account'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        child: Text(
                          'Join the world of botanical prestige',
                          style: TextStyle(
                            color: AppTheme.outline,
                            fontSize: isSmallScreen ? 12 : 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Animated Form Fields
                      ..._buildAnimatedFormFields(isSmallScreen),
                      const SizedBox(height: 32),
                      // Sign Up Button
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppTheme.primaryGreen,
                                  ),
                                ),
                              )
                            : PrimaryButton(
                                label: 'Sign Up',
                                onPressed: _handleSignUp,
                              ),
                      ),
                      const SizedBox(height: 24),
                      // Sign In Link
                      Center(
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              fontSize: isSmallScreen ? 11 : 12,
                              color: AppTheme.outline,
                            ),
                            child: Text.rich(
                              TextSpan(
                                text: "ALREADY HAVE AN ACCOUNT? ",
                                children: [
                                  TextSpan(
                                    text: 'SIGN IN',
                                    style: TextStyle(
                                      color: AppTheme.primaryGreen,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
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
      ),
    );
  }

  List<Widget> _buildAnimatedFormFields(bool isSmallScreen) {
    final fields = [
      _buildTextField(
        controller: _usernameController,
        label: 'USERNAME',
        icon: Icons.person_outline,
        delay: 0.1,
        isSmallScreen: isSmallScreen,
      ),
      const SizedBox(height: 20),
      _buildTextField(
        controller: _emailController,
        label: 'EMAIL ADDRESS',
        icon: Icons.email_outlined,
        delay: 0.2,
        isSmallScreen: isSmallScreen,
        keyboardType: TextInputType.emailAddress,
      ),
      const SizedBox(height: 20),
      _buildPasswordField(
        controller: _passwordController,
        label: 'PASSWORD',
        obscure: _obscurePassword,
        delay: 0.3,
        isSmallScreen: isSmallScreen,
        onToggle: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
      ),
      const SizedBox(height: 20),
      _buildPasswordField(
        controller: _confirmPasswordController,
        label: 'CONFIRM PASSWORD',
        obscure: _obscureConfirmPassword,
        delay: 0.4,
        isSmallScreen: isSmallScreen,
        onToggle: () {
          setState(() {
            _obscureConfirmPassword = !_obscureConfirmPassword;
          });
        },
      ),
    ];

    List<Widget> animatedFields = [];
    for (var i = 0; i < fields.length; i++) {
      animatedFields.add(
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Interval(0.1 * (i + 1), 1.0, curve: Curves.easeOut),
              ),
            ),
            child: fields[i],
          ),
        ),
      );
      if (i < fields.length - 1) {
        animatedFields.add(const SizedBox(height: 20));
      }
    }
    return animatedFields;
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required double delay,
    required bool isSmallScreen,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: (400 + (delay * 200)).toInt()),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(20 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(
              icon,
              color: AppTheme.primaryGreen.withOpacity(0.6),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.primaryGreen,
                width: 2,
              ),
            ),
          ),
          keyboardType: keyboardType,
          style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required double delay,
    required bool isSmallScreen,
    required VoidCallback onToggle,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: (400 + (delay * 200)).toInt()),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(20 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: AppTheme.primaryGreen.withOpacity(0.6),
            ),
            suffixIcon: IconButton(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  key: ValueKey(obscure),
                  color: AppTheme.primaryGreen.withOpacity(0.6),
                ),
              ),
              onPressed: onToggle,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.primaryGreen,
                width: 2,
              ),
            ),
          ),
          style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
        ),
      ),
    );
  }

  Future<void> _handleSignUp() async {
    if (_usernameController.text.trim().isEmpty) {
      _showError('Please enter a username');
      return;
    }

    if (_emailController.text.trim().isEmpty) {
      _showError('Please enter your email');
      return;
    }

    if (_passwordController.text.isEmpty) {
      _showError('Please enter a password');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showError('Passwords do not match');
      return;
    }

    if (_passwordController.text.length < 6) {
      _showError('Password must be at least 6 characters');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final appState = Provider.of<AppState>(context, listen: false);

      await appState.signUp(
        _emailController.text.trim(),
        _passwordController.text,
        _usernameController.text.trim(),
      );

      if (mounted) {
        context.go('/profile');
      }
    } catch (e) {
      if (mounted) {
        _showError(e.toString().replaceAll('Exception:', ''));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
