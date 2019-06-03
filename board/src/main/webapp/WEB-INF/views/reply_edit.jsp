<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="header.jsp" %>
<%@ include file="include/head.jsp"%>

<title>Insert title here</title>

</head>
<body>
	<div class='box box-primary'>
		<div class='box-header with-border'>	
			<h3 class='box-title'>댓글 수정/삭제</h3>
		</div>
		<div class='box-body'>
			<input type="password" class="form-control" id="replyPassword" placeholder="비밀번호">
		</div>
		<div class='box-footer'>
			<div class='text-center'>
				<button type="button" class='btn btn-success replyModBtn'><i class="fa fa-edit"></i>수정</button>
                <button type='button' class='btn btn-danger replyDelBtn'><i class="fa fa-trash"></i>삭제</button>
			</div>
		</div>
			
	</div>
	<script>
		var replyNumber="${replyNumber}";
		$('.replyDelBtn').on('click',function(){
			var json = {
    				number : replyNumber,
    				password : $('#replyPassword').val()
    		};
			$.ajax({
				type : "post",
				url : "delete_reply",
				data : json,
				dataType : "json",
				
				success : function(data) {
					
					if(data==1) //비번 맞아서 잘 삭제됐으면
					{
						alert('댓글삭제');
						//부모 창의 reply 목록을 갱신
						opener.getReplies();
						window.close();
					}
					else
					{
						alert('비번틀림');
						return;
					}
				},    	 				
				error : function(error) {
					alert("통신실패");
				}
				
			})
			
		});
		
		$('.replyModBtn').on('click',function(){
			var json = {
    				number : replyNumber,
    				password : $('#replyPassword').val()
    		};
			$.ajax({
				type : "post",
				url : "reply_password_check", //비번만 체크
				data : json,
				dataType : "json",
				
				success : function(data) {
					
					if(data==1) //비번만 체크
					{
						window.location.href='reply_modify?replyNumber='+replyNumber;
					}
					else
					{
						alert('비번틀림');
						return;
					}
				},		
				error : function(error) {
					alert("통신실패");
				}
				
			})
			
		});
	
	</script>
	
</body>
</html>