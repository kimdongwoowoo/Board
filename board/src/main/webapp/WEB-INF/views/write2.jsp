<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="header.jsp" %>
<%@ include file="include/head.jsp"%>
 <%@ include file="include/main_header.jsp"%>
<%@ include file="include/left_column.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

<div class="content-wrapper">
	 
 	<section class="content-header">
       <h1>
                게시판
       <small>입력페이지</small>
       </h1>
       <ol class="breadcrumb">
       	<li><i class="fa fa-edit"></i> article</li>
       	<li class="active"><a href="${path}/article/write"> write</a></li>
       </ol>
    </section>
	<section class="content container-fluid">
	
	<div class='col-lg-12'>
  		<div class='box box-primary'>
  			<!-- 헤더 -->
			<div class='box-header with-border'>
   			 	<h3 class='box-title'>게시글 작성</h3> 
   			</div>
   			<!-- 바디 -->
  		 	<div class='box-body'>
  		 		<div class="form-group">
                    <label for="title">제목</label>
                    <input class="form-control" id="title" name="title" placeholder="최대 20자">
                </div>
  		 		<div class="form-group">
                    <label for="content">내용</label>
                    <textarea class="form-control" id="content" rows="5" placeholder="최대 50자" style="resize: none;"></textarea>
   	 			</div>
   	 			<div>
   	 				<label for="writer">작성자</label>
                    <input class="form-control" id="writer" name="writer" placeholder="최대 10자">
   	 			</div>
				<div>
					<label for='password'>비밀번호</label>
					<input class="form-control" type="password" id="password" placeholder="">
				</div>
			</div>
			<!-- 발 -->
			<div class="box-footer">
				<div class="pull-right">
              		<button type="button" id='toList' class="btn btn-primary"><i class="fa fa-list"></i> 목록</button>
                  	<button type="submit" id='btnSave'class="btn btn-success"><i class="fa fa-save"></i> 저장</button>
                </div>
             </div>
        </div>
	</div>
	</section>
	<!-- ./content -->
</div>
<!-- ./content-wrapper -->
<%@ include file="include/main_footer.jsp"%>
</div>
<!-- ./wrapper -->
<%@ include file="include/plugin_js.jsp"%>
<script>
//칸이 비었는지 체크해주는 함수
	$(document).ready(function(){
		
		$('#title').keyup(function(){
			
            //alert($('#title').val().length);
        	if($(this).val().length > 20)
        	{
        		alert('최대 20자');
        		
        		$(this).val($(this).val().substring(0, 20 ));
        	}
		});
		$('#content').keyup(function(){
			
            //alert($('#title').val().length);
        	if($(this).val().length > 50)
        	{
        		alert('최대 50자');
        		$(this).val($(this).val().substring(0, 50 ));
        	}
		});
		$('#writer').keyup(function(){
			
            //alert($('#title').val().length);
        	if($(this).val().length > 10)
        	{
        		alert('최대 10자');
        		$(this).val($(this).val().substring(0, 10 ));
        	}
		});
		$('#toList').click(function(){
			
			window.history.back();
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
			/*if(!chkPwd( $.trim($('#password').val()))){ 
				 
				 alert('비밀번호를 확인하세요.₩n(영문,숫자,특수기호를 혼합하여 8~20자 이내)');    

				 $('#password').val('');

				 $('#password').focus(); 
				 return ;

			}*/ //비밀번호 체크
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
					
						alert("성공");
						window.location.href = "/board";
						
					},
					error : function(error) {
						alert("실패");
					}
				});
				
			
		});
	});
</script>



		
<input type="hidden" id="number" value="${board.number}">
<input type="hidden" id="viewCnt" value="${board.viewCnt}">
		
</body>
</html>