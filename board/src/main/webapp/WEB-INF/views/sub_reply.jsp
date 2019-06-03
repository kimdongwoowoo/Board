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
	<section class='content container-fluid'>
        	<!-- 새 댓글 작성 -->
        	<div class='col-lg-12'>
        		<div class='box box-warning'>
        			<div class='box-header with-border'>
        				<a class='link-black text-lg'><i class='fa fa-pencil'></i>댓글작성</a>
        			</div>
        			<div class='box-body'>
        				<div class='form-horizontal'>
        					<div class='form-group margin'>
        						<div class='col-sm-10'>
        							<textarea class="form-control" id="subReplyText" rows="5" placeholder="비속어 금지" style="resize: none;"></textarea>
        						</div>
        					
        						<div class='col-sm-2'>
        							<input class='form-control' id='subReplyWriter' type='text' placeholder='댓글 작성자'>	
        						</div>
        						<hr/>
        						<div class='col-sm-2'>
        							<input class='form-control' id='subReplyPassword' type='password' placeholder='비밀번호'>	
        						</div>
        						<hr/>
        						<hr/>
        						<div class='col-sm-2'>
        							<button type='button' class='btn btn-primary btn-block subReplyAddBtn'><i class='fa fa-save'></i>저장</button>
        						</div>
        					</div>
        				</div>
        			</div>
        		</div>
        	</div>
        </section>
        
        <script>
        	$('.subReplyAddBtn').on('click',function(){
        		var boardNumber="${boardNumber}";
        		var parentNumber="${parentNumber}";
        		var replyWriter=$('#subReplyWriter').val();
        		var replyText=$('#subReplyText').val();
        		var replyPassword=$('#subReplyPassword').val();
        		var json = {
        				boardNumber : boardNumber,
        				parentNumber : parentNumber,
        				content : replyText,
        				writer : replyWriter,
        				password : replyPassword	
        				
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
        			url : "add_reply",
        			data : json,
        			dataType : "json",
        			success : function(data) {
        				alert("서브댓글 등록!");
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