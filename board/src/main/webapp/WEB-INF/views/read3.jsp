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
                            <img class="img-circle img-bordered-sm" src="dist/img/humoseok.png" alt="user image">
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
    						window.location.href = "/board/delete?number=${board.number}"; //댓글도 지워줘야함
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
        	history.back();
        });
        
    });
    function checkPassword(){
    	
   
    	
    }
</script>

<!-- 댓글관련 -->
<script>
	var boardNumber="${board.number}";
	var getRepliesURI='/board/readReplys?number='+boardNumber;
	$(document).ready(function(){
		
		getReplies();
	});

	function getReplies(){
		$.getJSON(getRepliesURI, function(data){
			var str='';
			var list=data['replys'];
			
			
			$(list).each(function(){
				var reply=this.replyV0; //json으로 넘어온 댓글 리스트
				var date=new Date(reply.regDate);
				//<li data-replyNumber=''> 이부분 나중에 식별자로 쓰이게끔
				str+="<li data-replyNumber='"+reply.replyNumber+"'class='replyLi'>"
					+	"<p class='replyWriter'>"+reply.writer+"</p>"
					+	"<p class='replyText'>"+reply.content+"</p>"
					+	"<p class='replyRegDate'>"+(date.getMonth()+1)+"월"+date.getDate()+"일"+date.getHours()+"시"+date.getMinutes()+"분"+"</p>"
					+	"<p class='replyButtons'>"
					+	"<button type='button' class='btn btn-xs btn-success modReplyBtn'>댓글 수정</button>&nbsp;"
					+	"<button type='button' class='btn btn-xs btn-warning subReplyBtn'>답글 달기</button>"
					+	"</p>"
					+	"<ul class='subReplyUl'>";
					
					var subReplys=this.subReplys;
					$(subReplys).each(function(){
						var subDate=new Date(this.regDate);
						str+="<li data-subReplyNumber='"+this.replyNumber+"' class='subReplyLi'>"
							+	"<p>"+this.writer+"</p>"
							+	"<p>"+this.content+"</p>"
							+	"<p>"+(subDate.getMonth()+1)+"월"+subDate.getDate()+"일"+subDate.getHours()+"시"+subDate.getMinutes()+"분"+"</p>"
							+	"<p>"
							+	"<button type='button' class='btn btn-xs btn-success'>댓글 수정</button>"
							+	"</p>"
							+"</li>";
					});
					str+="</ul>"
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
				getReplies();
				
				
			},
			error : function(data){
				alert('통신실패');
			}
		});
		
	});
	//밑에밑에밑에 타고들어가야함. replies이하는 다 append됐기 때문에 셀렉터를 일케찾아가야한다.
	$('#replies').on('click', '>.replyLi >.replyButtons >.modReplyBtn',function(){
		var reply=$(this).parent().parent(); //li를 찾아줌
		var replyNumber=reply.attr('data-replyNumber'); //li안에 data-속성
		window.open('reply_editor?replyNumber='+replyNumber,'댓글 에디터','width=400,height=500'); 
		//굳이 컨트롤러 안거치고 가는 방법 알아볼것
		
	});
	$('#replies').on('click', '>.replyLi >.replyButtons >.subReplyBtn',function(){
		var reply=$(this).parent().parent(); //li를 찾아줌
	
		var replyNumber=reply.attr('data-replyNumber'); //li안에 data-속성
		window.open('sub_reply?parentNumber='+replyNumber+'&boardNumber='+boardNumber,'대댓글 에디터','width=400,height=500'); 
		//굳이 컨트롤러 안거치고 가는 방법 알아볼것
		
	});
	
	$('#replies').on('click', '>.replyLi >.subReplyUl >.subReplyLi button',function(){
		alert('클릭');
	});
	
	
	
</script>
</body>
</html> 