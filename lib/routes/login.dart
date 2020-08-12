import 'package:flutter/material.dart';
import 'package:github_client/common/funs.dart';
import 'package:provider/provider.dart';
import '../common/Global.dart';
import '../common/git.dart';
import '../models/index.dart';

class LoginRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginRouteState();
  }
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _unameCtr = new TextEditingController();
  TextEditingController _pwdCtr = new TextEditingController();
  bool pwdShow = false;
  GlobalKey _fromKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    _unameCtr.text = Global.profile.lastLogin;
    if (_unameCtr.text != null) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            autovalidate: false,
            key: _fromKey,
            child: Column(
              children: [
                TextFormField(
                  autofocus: _nameAutoFocus,
                  controller: _unameCtr,
                  decoration: InputDecoration(
                    labelText: "登录",
                    hintText: '用户名或密码',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (v) {
                    return v.trim().isNotEmpty ? null : "用户名错误";
                  },
                ),
                TextFormField(
                  controller: _pwdCtr,
                  autocorrect: !_nameAutoFocus,
                  obscureText: pwdShow,
                  decoration: InputDecoration(
                    labelText: '密码',
                    hintText: '密码',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        icon: Icon(
                            pwdShow ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            pwdShow = !pwdShow;
                          });
                        }),
                  ),
                  validator: (v) {
                    return v.trim().isNotEmpty ? null : "密码错误";
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(height: 55),
                    child: RaisedButton(
                      onPressed: _onLogin,
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      child: Text("登录"),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  void _onLogin() async {
    if ((_fromKey.currentState as FormState).validate()) {
      showLoading(context);
      User user;
      try {
        user = await Git(context).login(_unameCtr.text, _pwdCtr.text);
        Provider.of<UserModel>(context, listen: false).user = user;
      } catch (e) {
        if (e.response?.statucCode == 401) {
          showToast("失败");
        } else {
          showToast(e.toString());
        }
      } finally {
        Navigator.of(context).pop();
        if (user != null) {
          Navigator.of(context).pop();
        }
      }
    }
  }
}
