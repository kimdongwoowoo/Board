<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="header.jsp" %>

</head>


<body>

	<table class="table">
	<thead class="thead">
		<tr>
			<th scope="col">#</th>
			<th scope="col">제목</th>
			<th scope="col">작성자</th>
			
			
		</tr>
	</thead>
	<tbody id="tbody">
	</tbody>
	</table>
	
	


<script>
$(document).ready(function(){
	$.ajax({
		type:"GET",
		url : "readBoardAndReplys",
		success:function(data){
				alert("게시물,댓글 갖고오기 끝");
				//console.log(data);
				
				for(var i in data['list']){ //key들이 리스트로 넘어옴(숫자)
					var tr=$("<tr></tr>").appendTo("#tbody");
					var boardV0=data['list'][i]['boardV0'];
					tr.append("<td>"+boardV0['number']+"</td>");
					tr.append("<td>"+boardV0['title']+"</td>");
					tr.append("<td>"+boardV0['writer']+"</td>");
					
					//$("<td></td>").text(boardV0['content']).appendTo(tr);
					
					
					var replys=data['list'][i]['replys'];
					for(var j in replys){ //replys배열 key(index)
						tr=$("<tr></tr>").appendTo("#tbody");
						var replyV0=replys[j]['replyV0'];
						tr.append("<td></td>"); //번호 안띄우고
						tr.append("<td>&nbsp&nbsp Re : "+ 
						replyV0['content']
						+<div align="right"></div>
						
						+"</td>");
						
						tr.append("<td>"+ replyV0['writer'] +"</td>");
						
						console.log(replyV0['boardNumber']);
						console.log(replyV0['replyNumber']);
						console.log(replyV0['parentNumber']);
						console.log(replyV0['content']);
						console.log(replyV0['writer']);
						
						
						var subReplys=replys[j]['subReplys'];
						for(var k in subReplys){
							console.log(subReplys);
						}
						
					}
				}
					
		
				
				
		},
		error:function(error){
			alert(error);
		}
		
	});
});

</script>


</body>
</html>