<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>

</head>

<body>

	<button type="button" id="btnWrite">글쓰기</button>
	<h2>##게시글 목록##</h2>
	<table border="1" width="600px">
		<thead>
			<tr>
				<th scope="col">#</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
			</tr>
		<thead>
		<tbody id="tbody">
		</tbody>

	</table>


	<script>
		//글쓰기 버튼 리스너
		$(document).ready(function() {
			$("#btnWrite").click(function() {
				location.href = "write.do";//여기서 번호 넘겨줘야함
			});
		});
	</script>
	
	<script>
		$(document).ready(function() {
			$.ajax({
				type : "GET",
				url : "list.do",
				dataType : "json",
				success : function(data) {
					alert('성공');
					alert(data);
					for ( var row in data ) {
						var i=1;
						//tr 태그를 생성해서 id를 통해 tobody에 추가
						var tr = "<tr>";
						//리스트 볼때는 이거 3개만
						console.log(data[row]);
						var td1="<td>"+data[row]['number']+"</td>";
						var td2="<td>"+data[row]['title']+"</td>";
						var td3="<td>"+data[row]['owner']+"</td></tr>";
						$("#tbody").append(tr+td1+td2+td3);
					}
				
				},
				error : function(error) {
					alert("오류 발생" + error);
				}
			});
		});
	</script>
</body>
</html>