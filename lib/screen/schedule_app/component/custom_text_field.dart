import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:study/screen/schedule_app/constant/color.dart';

class CustomTextField extends StatelessWidget {

  final String label;

  // true - 시간 / false - 내용
  final bool isTime;

  final FormFieldSetter<String> onSaved;

  final String initialValue;

  const CustomTextField({required this.label, required this.isTime, required this.onSaved, required this.initialValue, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: PRIMARY_SCHEDULE_COLOR,
            fontWeight: FontWeight.w500,
          ),
        ),
        // TextField에 expands를 위해 Expanded를 추가해줌
        isTime ? renderTxtField() : Expanded(child: renderTxtField()),
      ],
    );
  }
  
  Widget renderTxtField() {
    return TextFormField( // TextField에서 좀더 추가된 기능
      initialValue: initialValue,
      onSaved: onSaved,
      validator: (value) { // 에러가 있으면 에러를 String값으로 리턴 => 에러가 없으면 null
        if(value == null || value.isEmpty) {
          return '값을 입력해주세요.';
        }

        if(isTime) {
          int time = int.parse(value!);

          if(time < 0) {
            return '0 이상의 숫자를 입력해주세요.';
          }

          if(time > 24) {
            return '24이하의 숫자를 입력해주세요.';
          }
        } else {
          // if(value.length > 500) return '500자 이하의 글자를 입력해주세요.';
          // maxLength로 대체
        }

        return null;
      },
      onChanged: (val) {
        // onChanged를 통해 값을 받아올 수 있음(방법 1)
      },
      maxLength: 500,
      maxLines: isTime ? 1 : null, // null로 넣으면 입력할 수 있는 줄 제한이 없어짐
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      expands: !isTime,
      inputFormatters: isTime ? [ // 입력할 수 있는 것 제한
        FilteringTextInputFormatter.digitsOnly
      ] : [],
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true, // 이거 true로 해야 fillColor가 동작함
        fillColor: Colors.grey[300],
        suffixText: isTime ? '시' : null,
      ),
      cursorColor: Colors.grey, // 커서 깜빡이는 칼라
    );
  }
  
}
