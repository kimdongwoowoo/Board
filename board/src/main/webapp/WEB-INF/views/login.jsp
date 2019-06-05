<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="header.jsp" %>
<%@ include file="include/head.jsp" %>
</head>
<body class="hold-trasition login-page">
<div class="login-box">
	<div class="login-logo">
		<a href="${path}/board/">
			<b>Kim Taoks</b> &nbsp 게시판
		</a>
	</div>
	<div class="login-box-body">
		<p class="login-box-msg">로그인 페이지</p>
		<div class="form-group has-feedback">
			<input type="text" id="userId" class="form-control" placeholder="아이디">
			<span class="glyphicon glyphicon-exclamation-sign form-control-feedback"></span>
		</div>
		<div class="form-group has-feedback">
			<input type="password" id="userPw" class="form-control" placeholder="비밀번호">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		</div>
		<div class="row">
			<div class="col-xs-8">
				<div class="checkbox">
					<label>
						<input type="checkbox" name="userCookie">로그인유지
					</label>
				</div>
			</div>
			<div class="col-xs-4">
				<button class="btn btn-primary btn-block btn-flat" id="loginBtn">
					<i class="fa fa-sign-in"></i>로그인
				</button>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-8">
				<a href="register">회원가입</a>
			</div>
		</div>
		
	</div>
</div>
<%@ include file="include/plugin_js.jsp" %>
<script>
$('#loginBtn').click(function(){
	var json={
			userId : $('#userId').val(),
			userPw : $('#userPw').val()
	}
	for(var str in json){
		if(json[str]==''){
			alert($('#'+str).attr('placeholder')+'를 입력하세요');
			$('#'+str).focus();
			return;
		}
	}
	 $.ajax({
			type : "post",
			url : "loginPost",
			data : json,
			dataType : "json",
			success : function(data) {
				var code=data.code;
				if(code==1) //로그인성공시
				{
					alert('하염^^');
					
					location.href=document.referrer;
				}	
				else if(code==2) //아이디 잘못됐을때
				{
					alert('아이디가 없습니다');
					return;
				}
				else if(code==3)
				{
					alert('비밀번호 틀렸습니다');
					return;
				}
			},
			error : function(error) {
				alert("실패");
			}
	});
});
</script>
</body>
</html>