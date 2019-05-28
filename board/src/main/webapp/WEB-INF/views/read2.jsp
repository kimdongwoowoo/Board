<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="header.jsp" %>
<%@ include file="include/head.jsp"%>
</head>
<body class="hold-transition skin-blue sidebar-mini">

<div class="wrapper">

    <!-- Main Header -->
    <%@ include file="include/main_header.jsp"%>

    <!-- Left side column. contains the logo and sidebar -->
    <%@ include file="include/left_column.jsp"%>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                게시판
                <small>조회페이지</small>
            </h1>
            <ol class="breadcrumb">
                <li><i class="fa fa-edit"></i> board</li>
                <li class="active"><a href="${path}/board/write"> 글쓰기</a></li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content container-fluid">
			<!--  본문 내용,수정,삭제 -->
            <div class="col-lg-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">글제목 : ${board.title}</h3>
                    </div>
                    <div class="box-body" style="height: 200px">
                        ${board.content}
                    </div>
                    <div class="box-footer">
                        <div class="user-block">
                            <img class="img-circle img-bordered-sm" src="/dist/img/user1-128x128.jpg" alt="user image">
                            <span class="username">
                                <a href="#">${board.writer}</a>
                            </span>
                            <span class="description"><fmt:formatDate pattern="yyyy-MM-dd a HH:mm" value="${board.regDate}"/></span>
                        </div>
                    </div>
                    <div class="box-footer">
                        <input type="hidden" name="number" value="${board.number}">
                        <button type="submit" class="btn btn-primary listBtn"><i class="fa fa-list"></i> 목록</button>
                        
                        <div class="pull-right">
                            <button type="submit" class="btn btn-warning modBtn"><i class="fa fa-edit"></i> 수정</button>
                            <button type="submit" class="btn btn-danger delBtn"><i class="fa fa-trash"></i> 삭제</button>
                        </div>
                        <div class="pull-right">
                        	<input type="password" style='margin-right' class="form-control" id="boardPassword" placeholder="비밀번호">
                        </div>
                    </div>
                </div>
            </div>

        </section>
        <!-- /.content -->
        
        <!-- 댓글부분 -->
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
        							<textarea class="form-control" id="newReplyText" rows="5" placeholder="댓글 내용" style="resize: none;"></textarea>
        						</div>
        					
        						<div class='col-sm-2'>
        							<input class='form-control' id='newReplyWriter' type='text' placeholder='댓글 작성자'>	
        						</div>
        						<hr/>
        						<div class='col-sm-2'>
        							<input class='form-control' id='newReplyPassword' type='password' placeholder='비밀번호'>	
        						</div>
        						<hr/>
        						<hr/>
        						<div class='col-sm-2'>
        							<button type='button' class='btn btn-primary btn-block replyAddBtn'><i class='fa fa-save'></i>저장</button>
        						</div>
        					</div>
        				</div>
        				
        			</div>
        			
        			<div class='box-footer'>
        				<ul id='replies'>
        				
        				
        				</ul>
        			</div>
        			<!-- 댓글 페이징 -->
        			<div class='box-footer'>
        				<div class='text-center'>
        					<ul class='pagination patination-sm no-margin'>
        					</ul>
        				</div>
        			
        			</div>
        		
        		</div>
        	</div>
        	
        	<!-- 댓글 수정,삭제 -->
        	<div class='modal fade' id='modifyModal' role='dialog'>
        		<div class='modal-dialog'>
        			<div class='modal-content'>
        				<div class='modal-header'>
        					<button type='button' class='close' data-dismiss='modal'>&times;</button>
        					<h4 class='modal-title'>댓글 수정창</h4>
        				
        				</div>
        				<div class='modal-body'>
        					<div class='form-group'>
        						<label for='replyNo'>댓글 번호</label>
        						<input class='form-control' id='replyNo' name='replyNo' readonly>
        					</div>
        					<div class='form-group'>
        						<label for='replyText'>댓글 내용</label>
        						<input class='form-control' id='replyText' name='replyText' readonly>
        					</div>
        					<div class='form-group'>
        						<label for='replyWriter'>댓글 작성자</label>
        						<input class='form-control' id='replyWriter' name='replyWriter' readonly>
        					</div>
        				</div>
        				<div class='modal-footer'>
	        				 <div class="pull-right">
	                            <button type="button" class='btn btn-success modalModBtn'>수정</button>
	                            <button type='button' class='btn btn-danger modalDelBtn'>삭제</button>
	                        </div>
	                        <div class="pull-right">
	                        	<input type="password"  class="form-control pull-right" id="replyPassword" placeholder="비밀번호"> 	
	                        </div>
	        				
        					<button type='button' class='btn btn-default pull-left' data-dismiss='modal'>닫기</button>
        					
        					
        				</div>
        			</div>
        		</div>
        	
        	</div>
        </section>
        
    </div>
    <!-- /.content-wrapper -->

    <!-- Main Footer -->
    <%@ include file="include/main_footer.jsp"%>

</div>
<!-- ./wrapper -->
<%@ include file="include/plugin_js.jsp"%>

<!-- 본문수정삭제관련 -->
<script>
	
    $(document).ready(function () {
        $(".modBtn").on("click", function () {
           
         	var json = {
    				number : "${board.number}",
    				password : $('#boardPassword').val()
    		};
        	
        	 $.ajax({
    				type : "post",
    				url : "password_check",
    				data : json,
    				dataType : "json",
    				success : function(data) {
    					
    					if(data==1) //비번이 맞으면
    					{
    						window.location.href = "/board/modify?number=${board.number}";
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
    	    });
        });
        $(".delBtn").on("click", function () {
        	var json = {
    				number : "${board.number}",
    				password : $('#boardPassword').val()
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
    						alert('비번틀림');
    						return;
    					}
    				},    	 				
    				error : function(error) {
    					alert("통신실패");
    				}
    	    });
        });
        $(".listBtn").on("click", function () {
           self.location = "/board/list"
        });
        
    });
    function checkPassword(){
    	
   
    	
    }
</script>

<!-- 댓글관련 -->
<script>
	$(document).ready(function(){
		var boardNumber="${board.number}";
		getReplies('/board/readReplys?number='+boardNumber);
	});

	function getReplies(repliesURI){
		$.getJSON(repliesURI, function(data){
			var str='';
			var list=data['replys'];
			
			$(list).each(function(){
				var reply=this.replyV0;
				console.log(reply);
				var date=new Date(reply.regDate);
				console.log(reply.boardNumber);
				console.log(reply.replyNumber);
				//<li data-replyNumber=''> 이부분 나중에 식별자로 쓰이게끔
				str+="<li data-replyNumber='"+reply.replyNumber+"' class='replyLi'>"
					+	"<p class='replyWriter'>"+reply.writer+"</p>"
					+	"<p class='replyText'>"+reply.content+"</p>"
					+	"<p class='replyRegDate'>"+date.getMonth()+"월"+date.getDate()+"일"+date.getHours()+"시"+date.getMinutes()+"분"+"</p>"
					+	"<button type='button' class='btn btn-xs btn-success' data-toggle='modal' data-target='#modifyModal'>댓글 수정</button>"
					+"</li>"
					+"<hr/>";
					
				
			});
			$('#replies').html(str);			
		});
	}
	
	$(".replyAddBtn").on("click",function(){
		
		var boardNumber="${board.number}";
		var replyWriter=$('#newReplyWriter').val();
		var replyText=$('#newReplyText').val();
		var replyPassword=$('#newReplyPassword').val();
		
		var json = {
				boardNumber : boardNumber,
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
				alert("댓글 등록!");
				
			
				$('#newReplyText').val('');
				$('#newReplyWriter').val('');
				$('#newReplyPassword').val('');
				getReplies('/board/readReplys?number='+boardNumber);
				
				
			}
		});
		
	});
	//replies ul 안에 클래스명이 replyLi인 li 밑에 버튼이라는 뜻
	$('#replies').on('click', '.replyLi button',function(){
		var reply=$(this).parent(); //li를 찾아줌
		
		var replyNumber=reply.attr('data-replyNumber'); //li안에 data-속성
		var replyText=reply.find('.replyText').text();  //클래스명으로 엘리먼트 검색
		var replyWriter=reply.find('.replyWriter').text();
		
		$('#replyNo').val(replyNumber);  //#replyNo는 modal안에 id임
		$('#replyText').val(replyText); //#replyText는 겹치지만 modal에서는 id이고, 다른데선 class라 괜찮음
		$('#replyWriter').val(replyWriter); //#replyNo는 modal안에 id임
		
		
	});
	
	$('.modalDelBtn').on('click',function(){
		debugger;
		var password=$('#replyPassword').val();
		var number = $('#replyNo').val();
		var jsonData={
				number:number,
				password:password
				
		};
		$.ajax({
			type:'post',
			url:'password_check_reply',
			data : jsonData,
			success:function(data){
				if(data==1)
				{
					alert('댓글비번 맞음')
				}	
				else
				{
					alert('댓글비번 틀림');
					return;
				}
			}
		})
		//비번부터 갖고오고, 이미 modal에 값들이 세팅돼있으니깐 걔네 readonly 해제해주고
		
		
	});
	
</script>
</body>
</html> 