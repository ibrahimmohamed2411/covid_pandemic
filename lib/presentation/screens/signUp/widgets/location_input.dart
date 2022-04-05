// part of '../sign_up_screen.dart';
//
// class _LocationInput extends StatelessWidget {
//   const _LocationInput({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SignUpCubit, SignUpState>(
//       buildWhen: (previous, current) => previous.location != current.location,
//       builder: (context, state) {
//         return CustomTextField(
//           hint: 'Locations',
//           errorText: state.location.invalid ? 'This can not be empty' : null,
//           onChanged: (value) {
//             context.read<SignUpCubit>().locationChanged(value);
//           },
//           textInputAction: TextInputAction.next,
//         );
//       },
//     );
//   }
// }
