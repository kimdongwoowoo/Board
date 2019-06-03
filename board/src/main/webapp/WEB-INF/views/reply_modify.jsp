<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="header.jsp" %>
<%@ include file="include/head.jsp"%>
    
</head>
<body>
	<div class='box box-primary'>
		<div class='box-header with-border'>	
			<h3 class='box-title'>댓글 수정</h3>
		</div>
		<div class='box-body'>
			<div class='form-group'>
        		<label for='replyNo'>댓글 번호</label>
        		<input class='form-control' id='replyNo' name='replyNo' placeholder='${replyV0.replyNumber }' readonly>
        	</div>
        	<div class='form-group'>
        		<label for='replyText'>댓글 내용</label>
        		<input class='form-control' id='replyText' name='replyText'  placeholder='${replyV0.content }'>
        	</div>
        	<div class='form-group'>
        		<label for='replyWriter'>댓글 작성자</label>
        		<input class='form-control' id='replyWriter' name='replyWriter'  placeholder='${replyV0.writer }' readonly>
        	</div>
		</div>
		
		<div class='box-footer'>
			<div class='text-center'>
				<button type="button" class='btn btn-default cancle'><i class="fa fa-edit"></i>취소</button>
                <button type='button' class='btn btn-danger replyModBtn'><i class="fa fa-trash"></i>확인</button>
			</div>
		</div>
			
	</div>
	<script>
	
		$('.cancle').on('click',function(){
			window.close();
		});
		
		$('.replyModBtn').on('click',function(){
			var replyNumber="${replyV0.replyNumber}"; 

			var writer="${replyV0.writer}";
			var content=$('#replyText').val();
			
			alert(content);
			if(content==''){
				alert('내용입력');
				return;
			}
			var json={
				replyNumber:replyNumber,
				content : content,
				writer:writer
					
			}
			$.ajax({
				type : "post",
				url : "update_reply", 
				data : json,
				dataType : "json",
				success : function(data){ //업뎃시켜주고 부모 목록 갱신후, 닫는다.
					
					opener.getReplies();
					window.close();
				},
				error : function(data){
					alert('통신실패');
				}
			});
				
		});
		
	
	</script>
</body>
</html>