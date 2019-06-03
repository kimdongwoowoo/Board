<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="include/head.jsp" %>
<%@ include file="header.jsp" %>
</head>
<body class="hold-trasition register-page">
<div class="register-box">
	<div class="register-logo">
		<a href="${path}/board/">
			<b>Kim Taoks</b> &nbsp 게시판
		</a>
	</div>
	
	<div class="register-box-body">
		<p class="register-box-msg">회원가입 페이지</p>
		<div class="form-group has-feedback">
			<input type="text" id="userId" class="form-control" placeholder="아이디">
			<span class="glyphicon glyphicon-exclamation-sign form-control-feedback"></span>
		</div>
		<div class="form-group has-feedback">
			<input type="text" id="userName" class="form-control" placeholder="이름">
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		</div>
		<div class="form-group has-feedback">
			<input type="text" id="userEmail" class="form-control" placeholder="이메일">
			<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
		</div>
		<div class="form-group has-feedback">
			<input type="password" id="userPw" class="form-control" placeholder="비밀번호">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		</div>
		<div class="form-group has-feedback">
			<input type="password" class="form-control" placeholder="비밀번호 확인">
			<span class="glyphicon glyphicon-log-in form-control-feedback"></span>
		</div>
		
		<div class="row">
			<div class="col-xs-4">
				<a href="${path }/board/login">로그인</a>
			</div>
			<div class="col-xs-4 pull-right">
				<button class="btn btn-primary btn-block btn-flat" id="registerBtn">가입</button>
			</div>
			
		</div>
		
		
	</div>
	
</div>
<%@ include file="include/plugin_js.jsp" %>
<script>
	

	$('#registerBtn').click(function(){
		var json={
				userId : $('#userId').val(),
				userName : $('#userName').val(),
				userEmail : $('#userEmail').val(),
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
				url : "register",
				data : json,
				dataType : "json",
				success : function(data) {
					alert("가입 완료!");
					window.location.href="/login";
				},
				error : function(error) {
					alert("실패");
				}
		});
	});
</script>

</body>
</html>