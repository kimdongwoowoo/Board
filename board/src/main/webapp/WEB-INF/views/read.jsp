<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	<!-- menu클래스 아래 a태그는 이렇게 표시한다 -->
    .menu a{cursor:pointer;}
    <!-- menu클래스 hide클래스는 처음 디폴트값이 안보이는상태다-->
    .menu .hide{display:none;}
</style>
<%@ include file="header.jsp" %>

<title>Insert title here</title>
<style type="text/css">

	.border-styles > p{
		margin: 2px 0;
		padding: 1px 3px;
		border-width: 2px;
		border-color: #aaa;
	}
</style>


<script>
$(document).ready(function(){
		
		$("#btnSave").attr('style', 'display:none');
		
		//댓글저장버튼
		$("#btnReplySave").click(function(){
		//여긴걍 쌩 댓글 남기는데라서 boardNumber만 있으면됨, parentNumber필요없
			var json = {
					boardNumber : $("#number").val(),
					content : $("#replyContent").val(),
					writer : $("#replyWriter").val(),
					password : $("#replyPassword").val()	
					
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
						alert("성공");
						//window.location.href = "/board/read?number="+$("#number").val();
						var reply=data['lastReply'];
						
						var boardNumber=reply['boardNumber'];
						var content=reply['content'];
						var writer=reply['writer'];
						var replyNumber=reply['replyNumber'];
						var parentNumber=reply['parentNumber'];
						var regDate=reply['regDate'];
						
						//append방식으로 추가할 html문 만들어야함
						
						var row='';
						var row="";
						row+="<div style='border: 1px solid #48BAE4; margin-top:15px; height: auto; padding:10px; width:600px'>"
						row+=writer;
						row+=":";
						row+=content;
						row+="<input type='text'  placeholder='비밀번호' aria-describedby='basic-addon2'>";
						row+="<button class='btn btn-outline-secondary' type='button'>수정</button>";
						row+="<button class='btn btn-outline-secondary' type='button'>삭제</button>";
						row+="<button class='btn btn-outline-secondary' name='"+replyNumber+"' ";
						row+="id='subReplyBtn' type='button'>대댓글</button>";
						row+="</div>";
						
						row+="<div id='"+replyNumber+"' style='border: 1px solid #48BAE4; margin-left:15px ; height: auto; padding:10px; width:600px; display:none ;margin-top=15px'>";
				 		row+="<div id='contents'>";
				 		
				 		row+="작성자 : <input type='text' id='subReplyWriter-"+replyNumber+"' placeholder='작성자' aria-describedby='basic-addon2'>";
				  		row+="비밀번호 : <input type='text' id='subReplyPassword-"+replyNumber+"' placeholder='비밀번호' aria-describedby='basic-addon2'>";
				 		row+="</div>";
				 		
				 		row+="<div>";
				    	row+="<input type='text' height='10px'  id='subReplyContent-"+replyNumber+"' style='width: 99%' placeholder='내용을 입력하세요'>";
				   		row+="<button class='btn btn-outline-secondary' id='btnSubReplySave' boardNum='"+boardNumber+"'parentNum='"+replyNumber+"' type='button'>저장</button>";
		
				   		row+="</div></div>";
						
				   		$('#replyList').append(row);
						console.log(row);
					
						
					},
					error : function(error) {
						alert("실패");
					}
				});
				
			
		});
	//본문수정
	$("#btnModify").click(function(){
		if($("#password").val()==''){
			alert($("#password").attr("placeholder")+"를 입력하세요");
			return;
		}
			var json = {
				number : $("#number").val(),
				password : $("#password").val()
			};
		
		 $.ajax({
				type : "post",
				url : "password_check",
				data : json,
				dataType : "json",
				success : function(data) {
					
					if(data==1) //비번이 맞으면
					{
						
						alert("수정모드");
						$("#title").prop('readonly', false);
						$("#content").prop('readonly', false);
						$("#password").attr('style','display:none');
						$("#password").val("");
						
						
						$("#btnModify").attr('style','display:none');
						$("#btnDelete").attr('style','display:none');
						$("#btnSave").attr('style', 'visibility:visible');
						
					}
					else
					{
						alert("비번틀림");
						return;
					}
				},
				error : function(error) {
					alert("통신실패");
				}
			});
		
		 
	});
	//본문저장버튼
	$("#btnSave").click(function(){
		var json = {
				number : $("#number").val(),
				title : $("#title").val(),
				content : $("#content").val(),
				writer : $("#writer").val(),
				viewCnt : $("#viewCnt").val()
		};
		 $.ajax({
				type : "post",
				url : "modify",
				data : json,
				dataType : "json",
				success : function(data) {
					alert("수정완료");
					$("#title").prop('readonly', true);
					$("#content").prop('readonly', true);
					$("#password").attr('style','display:visible');
					$("#btnModify").attr('style','display:visible');
					$("#btnDelete").attr('style','display:visible');
					$("#btnSave").attr('style', 'display:none');
					
					
				},
				error : function(error) {
					alert("통신실패");
				}
			});
			
		
	});
	//대댓글 등록창 띄우는 버튼, 각 버튼이 동적으로 배정됐기 때문에 속성(name)에 리플번호를 적어놨음
	$(document).on("click","#subReplyBtn", function(){
		
		var replyNum=$(this).attr("name"); //리플번호
		var div=$("div[id="+replyNum+"]"); //해당리플번호의 div
		div.attr('style','display:visible');
		
		
	});
	//서브댓글 저장버튼, 얘도 동적으로 배정됐기 때문에 속성 두개를 임의로 만들어서 리플번호, 게시글번호를 적어둠
	$(document).on("click","#btnSubReplySave",function(){  
		
		var parentNum=$(this).attr("parentNum"); //부모댓글 번호
		var boardNum=$(this).attr("boardNum"); //게시글 번호
		
		//값을 받아옴
		var content=$("#subReplyContent-"+parentNum).val();
		var writer= $("#subReplyWriter-"+parentNum).val();
		var password = $("#subReplyPassword-"+parentNum).val();	
		
		//기존내용 지워줌
		$("#subReplyContent-"+parentNum).empty();
		$('#subReplyWriter-'+parentNum).empty();
		$('#subReplyPassword-'+parentNum).empty();
		
		
		if(content=='' || writer=='' || password==''){
			alert('항목이 빠졌습니다.');
			return;
		}
		var json = {
				boardNumber : $("#number").val(),
				parentNumber : parentNum,
				content : content,
				writer : writer,
				password : password	
		};
		
		 $.ajax({
				type : "post",
				url : "add_reply",
				data : json,
				dataType : "json",
				success : function(data) {
					alert("서브댓글 저장완료");
					window.location.href = "/board/read?number="+$("#number").val();
				},
				error : function(error) {
					alert("통신실패");
				}
		});
		
		
			
		
	});
	
	
	
	$("#btnDelete").click(function(){
		if($("#password").val()==''){
			alert($("#password").attr("placeholder")+"를 입력하세요");
			return;
		}
		var json = {
				number : $("#number").val(),
				password : $("#password").val()
			};
		
		
		 $.ajax({
				type : "post",
				url : "password_check",
				data : json,
				dataType : "json",
				success : function(data) {
				
					if(data==1) //비번이 맞으면
					{
						alert("삭제완료");
						window.location.href = "/board/delete?number=${board.number}";
					}
					else
					{
						alert("비번틀림");
						return;
					}
				},
				error : function(error) {
					alert("통신실패");
				}
			});
	});
});
	

</script>

</head>
<body>
<input type="hidden" id="number" value="${board.number}">
<input type="hidden" id="viewCnt" value="${board.viewCnt }">

<div class="container">
<h2>No.${board.number} </h2>
<label> 작성일 : <fmt:formatDate value="${board.regDate}" pattern="MM.dd / HH:mm"/> </label><br>
<label> 조회수 : ${board.viewCnt} </label>

<div class="input-group">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">제목</span>
  </div>
  <input type="text" readonly id="title" class="form-control" value="${board.title}" aria-label="title" aria-describedby="basic-addon1">
</div>

<div class="input-group  ">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">내용</span>
  </div>
  <textarea readonly rows="5" id="content" class="form-control"  aria-label="title" aria-describedby="basic-addon1">${board.content}</textarea>
</div>

<div class="input-group  ">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">작성자</span>
  </div>
  <input type="text" readonly  id="writer" class="form-control" value="${board.writer}" aria-label="title" aria-describedby="basic-addon1">
</div>
<div class="input-group mb-3">
<div class="input-group-append my-3">
<input type="text" class="form-control" id="password" placeholder="비밀번호" aria-describedby="basic-addon2">
<button class="btn btn-outline-secondary" id="btnModify">수정하기</button>
<button class="btn btn-outline-secondary" id="btnDelete">삭제하기</button>
</div>



</div>
<button class="btn btn-outline-secondary" id="btnSave">저장</button>

<hr size="5px">
<label> 댓글 </label>
<!-- 오리지날 댓글 작성창 -->
<div style="border: 1px solid #48BAE4; margin-bottom:15px ; height: auto; padding:10px; width:600px">
 <div>
   작성자 : <input type="text" id="replyWriter" placeholder="작성자" aria-describedby="basic-addon2">
  비밀번호 : <input type="text" id="replyPassword" placeholder="비밀번호" aria-describedby="basic-addon2">
  </div>
 
  <div>
   <input type="text" height="10px"  id="replyContent"style="width: 99%" placeholder="내용을 입력하세요">
   <button class="btn btn-outline-secondary" id="btnReplySave" type="button">저장</button>
  
  </div> 
</div>



<!-- 댓글  리스트 -->
<div id="replyList">
<c:forEach items="${replys}" var="reply">
	<c:set var="replyV0" value="${reply.replyV0}" />
	
	<!-- 댓글 내용,수정,삭제,대댓글 버튼-->
	<div style="border: 1px solid #48BAE4; margin-top:15px; height: auto; padding:10px; width:600px">
		${replyV0.writer}:
		${replyV0.content} / 
	 	<fmt:formatDate value="${replyV0.regDate}" pattern="MM.dd HH:mm"/>
		
		<input type="text"  placeholder="비밀번호" aria-describedby="basic-addon2">
		<button class="btn btn-outline-secondary" type="button">수정</button>
		<button class="btn btn-outline-secondary" type="button">삭제</button>
		<button class="btn btn-outline-secondary" name="${replyV0.replyNumber}" id="subReplyBtn" type="button">대댓글</button>
	</div>
	
	<!-- 대댓글(숨겨져있는상태) -->
	<div id="${replyV0.replyNumber}" style="border: 1px solid #48BAE4; margin-left:15px ; height: auto; padding:10px; width:600px; display:none ;margin-top=15px">
 		<div id="contents">
   		작성자 : <input type="text" id="subReplyWriter-${replyV0.replyNumber}" placeholder="작성자" aria-describedby="basic-addon2">
  		비밀번호 : <input type="text" id="subReplyPassword-${replyV0.replyNumber}" placeholder="비밀번호" aria-describedby="basic-addon2">
 		</div>
 		<div>
    	<input type="text" height="10px"  id="subReplyContent-${replyV0.replyNumber}" style="width: 99%" placeholder="내용을 입력하세요">
   		<button class="btn btn-outline-secondary" id="btnSubReplySave" boardNum="${board.number}"  parentNum="${replyV0.replyNumber}" type="button">저장</button>
   		</div> 
	</div>
	
	<!-- 서브댓글  리스트 -->	
	<c:forEach items="${reply.subReplys}" var="subReply">
		<div style=" margin-left:15px ; border: 1px solid #48BAE4; height: auto; padding:10px; width:600px">
			${subReply.writer}:${subReply.content} / <fmt:formatDate value="${subReply.regDate}" pattern="MM.dd HH:mm"/>
		</div>
	</c:forEach>
	
</c:forEach>

</div>
</div>
</body>
</html>