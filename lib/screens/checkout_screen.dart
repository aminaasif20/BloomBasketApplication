import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../app_theme.dart';
import '../providers/app_state.dart';
import '../widgets/primary_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;

  // ✅ Controllers for validation
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();

  DateTime? _selectedDate;

  // ✅ Validation
  bool _validateStep() {
    if (_currentStep == 0) {
      if (_nameController.text.trim().isEmpty ||
          _addressController.text.trim().isEmpty ||
          _cityController.text.trim().isEmpty ||
          _zipController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all address fields")),
        );
        return false;
      }
    }

    if (_currentStep == 1 && _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select delivery date")),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CHECKOUT',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            letterSpacing: 4,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // ✅ Overflow FIX
      body: SafeArea(
        child: Stepper(
          type: StepperType.horizontal,
          elevation: 0,
          currentStep: _currentStep,

          // ✅ CONTINUE
          onStepContinue: () {
            if (!_validateStep()) return;

            if (_currentStep < 2) {
              setState(() => _currentStep++);
            } else {
              appState.placeOrder("${_addressController.text}, ${_cityController.text}");
              context.go('/confirmation');
            }
          },

          // ✅ BACK
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);
            } else {
              context.pop();
            }
          },

          // ✅ BUTTONS
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: _currentStep == 2 ? 'Place Order' : 'Continue',
                      onPressed: details.onStepContinue!,
                    ),
                  ),
                  if (_currentStep > 0) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: details.onStepCancel,
                        child: const Text('BACK'),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },

          steps: [
            // ✅ STEP 1 - ADDRESS
            Step(
              isActive: _currentStep >= 0,
              title: const SizedBox(),
              label: Text(
                'ADDRESS',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(fontSize: 8),
              ),
              content: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'FULL NAME'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'STREET ADDRESS',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _cityController,
                          decoration: const InputDecoration(labelText: 'CITY'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _zipController,
                          decoration: const InputDecoration(labelText: 'ZIP'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ✅ STEP 2 - DELIVERY
            Step(
              isActive: _currentStep >= 1,
              title: const SizedBox(),
              label: Text(
                'DELIVERY',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(fontSize: 8),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SELECT DELIVERY DATE',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(letterSpacing: 2),
                  ),
                  const SizedBox(height: 12),
                  CalendarDatePicker(
                    initialDate: DateTime.now().add(const Duration(days: 1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                    onDateChanged: (date) {
                      setState(() => _selectedDate = date);
                    },
                  ),
                ],
              ),
            ),

            // ✅ STEP 3 - PAYMENT
            Step(
              isActive: _currentStep >= 2,
              title: const SizedBox(),
              label: Text(
                'PAYMENT',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(fontSize: 8),
              ),
              content: Column(
                children: [
                  _PaymentOption(
                    title: 'CREDIT CARD',
                    subtitle: '**** **** **** 4242',
                    icon: Icons.credit_card,
                    isSelected: true,
                  ),
                  const SizedBox(height: 12),
                  _PaymentOption(
                    title: 'APPLE PAY',
                    subtitle: '**** 9012',
                    icon: Icons.apple,
                    isSelected: false,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TOTAL',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        '\$${appState.cartTotal.toStringAsFixed(0)}',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineMedium?.copyWith(fontSize: 22),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ PAYMENT WIDGET
class _PaymentOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;

  const _PaymentOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected
              ? AppTheme.primaryGreen
              : AppTheme.outline.withOpacity(0.2),
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryGreen),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(subtitle, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          if (isSelected)
            const Icon(Icons.check_circle, color: AppTheme.primaryGreen),
        ],
      ),
    );
  }
}
