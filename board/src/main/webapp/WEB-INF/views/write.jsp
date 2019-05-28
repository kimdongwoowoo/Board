<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="header.jsp" %>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">

<div class="input-group">
  <div class="input-group-prepend">

    <span class="input-group-text" id="basic-addon1">제목</span>
  </div>
  <input type="text" id="title" class="form-control" placeholder="최대 5자" aria-label="title" aria-describedby="basic-addon1">
</div>

<div class="input-group  ">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">내용</span>
  </div>
  <textarea rows="5" id="content" class="form-control" placeholder="최대 10자" aria-label="title" aria-describedby="basic-addon1"></textarea>
</div>

<div class="input-group  ">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">작성자</span>
  </div>
  <input type="text" id="writer" class="form-control" placeholder="최대 5자" aria-label="title" aria-describedby="basic-addon1">
</div>

<div class="input-group  ">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">비밀번호</span>
  </div>
  <input type="password" id="password" class="form-control" placeholder="영문,숫자,특수기호를 혼합하여 4~8자 이내" aria-label="title" aria-describedby="basic-addon1">
</div>

<div class="input-group  ">
<button id = "btnSave" class="btn btn-primary">저장</button>
</div>

</div>
<script>
//칸이 비었는지 체크해주는 함수
	$(document).ready(function(){
		
		$('#title').keyup(function(){
			
            //alert($('#title').val().length);
        	if($(this).val().length > 5)
        	{
        		alert('최대 5자');
        		$(this).val($(this).val().substring(0, 5 ));
        	}
		});
		$('#content').keyup(function(){
			
            //alert($('#title').val().length);
        	if($(this).val().length > 10)
        	{
        		alert('최대 10자');
        		$(this).val($(this).val().substring(0, 10 ));
        	}
		});
		$('#writer').keyup(function(){
			
            //alert($('#title').val().length);
        	if($(this).val().length > 5)
        	{
        		alert('최대 5자');
        		$(this).val($(this).val().substring(0, 5 ));
        	}
		});
    
		function chkPwd(str){
			 var pw = str;
			 var num = pw.search(/[0-9]/g);
			 var eng = pw.search(/[a-z]/ig);
			 var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
			 if(pw.length < 4 || pw.length > 8){
			  alert("4자리 ~ 8자리 이내로 입력해주세요.");
			  return false;
			 }

			 if(pw.search(/₩s/) != -1){
			  alert("비밀번호는 공백업이 입력해주세요.");
			  return false;
			 } if(num < 0 || eng < 0 || spe < 0 ){
			  alert("영문,숫자, 특수문자를 혼합하여 입력해주세요.");
			  return false;
			 }
			 return true;
			}



		$("#btnSave").click(function(){
			if(!chkPwd( $.trim($('#password').val()))){ 
				 
				 alert('비밀번호를 확인하세요.₩n(영문,숫자,특수기호를 혼합하여 8~20자 이내)');    

				 $('#password').val('');

				 $('#password').focus(); 
				 return ;

			}
			var json = {
					title : $("#title").val(),
					writer : $("#writer").val(),
					content : $("#content").val(),
					password : $("#password").val()
			};
			
			for(var str in json){
				if(json[str]==''){
					alert($("#" + str).attr("placeholder") + "를 입력해주세요.");
					$("#" + str).focus();
					return;
				}
			}
			 $.ajax({
					type : "post",
					url : "write",
					data : json,
					dataType : "json",
					success : function(data) {
						debugger;
						alert("성공");
						window.location.href = "/board/list";
						
					},
					error : function(error) {
						alert("실패");
					}
				});
				
			
		});
	});
</script>



		
</body>
</html>