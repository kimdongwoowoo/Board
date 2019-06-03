<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="header.jsp" %>
<%@ include file="include/head.jsp"%>

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
                <small>목록페이지</small>
            </h1>
            <ol class="breadcrumb">
                <li><i class="fa fa-edit"></i> article</li>
                <li class="active"><a href="${path}/board/write"> 글쓰기 </a></li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content container-fluid">

            <div class="col-lg-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">게시글 목록</h3>
                    </div>
                    <div class="box-body">
						<table class="table table-bordered">
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
						<c:forEach items="${boards}" var="board">
						<tr>
							<td>${board.number}</td>
							<td>
								<a href="read3?number=${board.number}"> ${board.title}</a>
								<span class="badge bg-teal"><i class="fa fa-comment-o"></i> + ${board.replyCnt}</span>
							
							</td>
							<td>${board.writer}</td>
							<td>
							<fmt:formatDate value="${board.regDate}" pattern="MM.dd HH:mm"/>				
							</td>
							<td><span class="badge bg-red">${board.viewCnt}</span></td>
				
						</tr>
						</c:forEach>
						</tbody>
						</table>
					</div>
					<div class="box-footer">
						<div class='text-center'>
							<ul class='pagination'>
								<c:if test="${pageMaker.prev}">
								<!-- prev버튼이 있으면 startPage바로 이전페이지를 파라미터로 준 후 리로드 -->
								 <li><a href="listPaging?page=${pageMaker.startPage-1}">이전</a></li> 
								</c:if>
									
									 <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" step="1" var="x">
									  <li <c:out value="${pageMaker.criteria.page == x ? 'class=active' : '' }"/>><a href="listPaging?page=${x}">
										${x}</a></li>
									 </c:forEach>
										
								
								<c:if test="${pageMaker.next}">
									<!-- next버튼도 prev와 마찬가지 -->
									<li><a href="listPaging?page=${pageMaker.endPage+1}">다음</a></li>
								</c:if>
																
							</ul>
						</div>
					
                        <div class="pull-right">
                            <button type="button" class="btn btn-success btn-flat" id="writeBtn">
                                <i class="fa fa-pencil"></i> 글쓰기
                            </button>
                        </div>
                    </div>
                 </div>
              </div>
          </section>
          </div>
          <%@ include file="include/main_footer.jsp"%>
          
          </div>
<%@ include file="include/plugin_js.jsp"%>
<script>
$("#writeBtn").click(function(){
	window.location.href = "/board/write";	
	
});
</script>          

</body>
</html>