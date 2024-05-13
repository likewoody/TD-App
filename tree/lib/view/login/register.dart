import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:td_app/model/login/checkValidate.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  late TextEditingController emailCon;
  late TextEditingController passwordCon;
  late TextEditingController passwordCon2;
  
  // 이메일 정규성 포커싱 
  late FocusNode _emailFocus;
  // 비밀번호 정규성 포커싱
  late FocusNode _pwFocus1;
  late FocusNode _pwFocus2;
  // 1번째 TextField가 정규성, 중복이 끝나면 true로 보여주기 위함
  late bool showPasswordTextField;
  // test용 아이디 만들기
  late String testId;
  // 정규성이 통과됬을 때 alert 띄우기 위한 변수
  late bool alertCheck;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailCon = TextEditingController();
    passwordCon = TextEditingController();
    passwordCon2 = TextEditingController();

    _emailFocus = FocusNode();
    _pwFocus1 = FocusNode();
    _pwFocus2 = FocusNode();
    showPasswordTextField = false;
    // textFieldList = [firstTextField()];

    alertCheck = false;
    
    // 테스트용 아디
    testId = "test@naver.com";
  }

  // DB 연결시 DB에 있는 이메일과 비교 중복확인 필요
  // DB 연결시 DB에 있는 이메일과 비교 중복확인 필요
  // DB 연결시 DB에 있는 이메일과 비교 중복확인 필요
  // DB 연결시 DB에 있는 이메일과 비교 중복확인 필요
  // DB 연결시 DB에 있는 이메일과 비교 중복확인 필요
  // DB 연결시 DB에 있는 이메일과 비교 중복확인 필요
  // DB 연결시 DB에 있는 이메일과 비교 중복확인 필요



  // ---- Functions ----
  alertEmailCheck(){
    if (testId == emailCon.text){
      Get.defaultDialog(
        title: "경고",
        middleText: "중복된 이메일입니다.",
        actions: [
          TextButton(
            onPressed: () {Get.back();}, 
            child: const Text("확인")
          ),
        ]
      );
    }else {
      Get.defaultDialog(
        title: "알림",
        middleText: "사용 가능한 Email입니다.",
        actions: [
          TextButton(
            onPressed: () {
              showPasswordTextField = true;
              // body View에서만 이걸 보여줘도 되지 않는가?
              // 근데 alert창 이후에 바로 화면에 보여주려면 여기서 있어야 바로 화면에 보여진다.
              showPasswordTextField ? secondTextField() : const SizedBox(width: 0, height: 0,);
              Get.back();
            }, 
            child: const Text("확인")
          ),
        ]
      );
    }
  }





  // ---- View ----
  Widget firstTextField() {
    return Column(
      children: [
        const SizedBox(height: 100),
        Row(
          children: [
            SizedBox(
              width: 260,
              height: 80,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(35, 0, 15, 0),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: emailCon,
                      focusNode: _emailFocus,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        hintText: "이메일",
                      ).copyWith(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                      ),validator: (value) => CheckValidate().validateEmail(value ?? ""),
                      // Change가 발생하면 그리고 정규성이 통과됬을 때 alertCheck를 true로 바꾸고 alert 실행
                      onChanged: (value) {
                        if (CheckValidate().validateEmail(value) != null) {
                          print("check onfieldSubmitted");
                          alertCheck = true;
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 90,
                // height: ,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,0,33),
                  child: ElevatedButton(
                    onPressed: () {
                      // 정규성이 통과 되었을 때만 alert을 통해 중복확인 체크
                      if (alertCheck){
                        alertEmailCheck();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(60, 172, 19, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    
                    child: const Text(
                      "중복확인",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        // backgroundColor: Colors.grey
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget secondTextField(){
    setState(() {});
    print("get in secondTextField $showPasswordTextField");
    return Center(
      child: Column(children: [
        // 비밀번호
        Row(
          children: [
            SizedBox(
              width: 290,
              // height: 500,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(38,0,45,0),
                child: Form(
                  // 이게 없으면 밑에 표시가 나오지 않음
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    controller: passwordCon,
                    focusNode: _pwFocus1,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black
                        )
                      ),
                      hintText: "비밀번호",
                    ).copyWith(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                    ),
                    // 정규성 검사
                    validator: (value) => CheckValidate().validatePassword(_pwFocus1, value!),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),

        // 비밀번호 확인
        Row(
          children: [
            SizedBox(
              width: 290,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(38,0,45,0),
                child: Form(
                  // 이게 없으면 밑에 표시가 나오지 않음
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    
                    controller: passwordCon2,
                    focusNode: _pwFocus2,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black
                        )
                      ),
                      hintText: "비밀번호 확인",
                    ).copyWith(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                    ),
                    // 정규성 검사
                    validator: (value) => CheckValidate().validatePassword2(_pwFocus2, value!, passwordCon.text, passwordCon2.text),
                  ),
                ),
              ),
            ),
          ],
        ),
        // Password Textfield

        // 회원가입 버튼
        const SizedBox(
          width: 0,
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0,0,0,33),
          child: ElevatedButton(
            onPressed: () {
              // 디비 연결시 디비에 저장하는 회원가입 func 실행
              // 디비 연결시 디비에 저장하는 회원가입 func 실행
              // 디비 연결시 디비에 저장하는 회원가입 func 실행
              // 디비 연결시 디비에 저장하는 회원가입 func 실행
              // 디비 연결시 디비에 저장하는 회원가입 func 실행
              // 디비 연결시 디비에 저장하는 회원가입 func 실행
              
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(60, 172, 19, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            
            child: const Text(
              "회원가입",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                // backgroundColor: Colors.grey
              ),
            ),
          ),
        ),
      ],),
    
    );
  }

    
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
          
                firstTextField(),
                // Email TextField가 진행이 되면 Password TextField Show
                showPasswordTextField ? secondTextField() : const SizedBox(width: 0, height: 0,)
              ]
            ),
          ),
        )
      ),
    );
  }
}