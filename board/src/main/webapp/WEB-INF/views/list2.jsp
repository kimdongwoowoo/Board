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
<a href="write" ><font size="4px">글쓰기</font></a>
	<table class="table">
		<thead class="thead-light">
			<tr>
				<th scope="col">#</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
				<th scope="col">조회수</th>
			</tr>
		</thead>
		<tbody id="tbody">
			<c:forEach items="${boards.list}" var="boardWrapper">
			<c:set var="board" value="${boardWrapper.boardV0}" />

			<tr>
				<td>${board.number}</td>
				<td><a href="read?number=${board.number}"> ${board.title}</a></td>
				<td>${board.writer}</td>
				<td>
				<fmt:formatDate value="${board.regDate}" pattern="MM.dd HH:mm"/>				
				</td>
				<td>${board.viewCnt}</td>
			</tr>
			</c:forEach>
		</tbody>

	</table>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>


</body>
</html>