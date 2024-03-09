<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>파일 저장소</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/fontawesome-6-pro@6.4.0/css/all.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>

<body>
	<main class="jumbotron col-md-12 m-auto">
		<div class="row">
			<div class="col-md-12">
				<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
					<div class="container-fluid">
						<a class="navbar-brand" href="main.do"> 
							<i class="fa-solid fa-database fa-2xl ms-3 me-2"></i> 
							파일 저장소
						</a>
						<div class="collapse navbar-collapse" id="navbarNav">
							<a class="navbar-brand" aria-current="page" href="uploadForm.do"> 
								<i class="fa-solid fa-upload fa-2xl ms-3 me-2"></i> 
								업로드
							</a>
						</div>
					</div>
				</nav>
			</div>
			<div class="row ms-auto me-auto">
				<div class="col-md-8">
					<div class="card mt-3">
						<div class="card-header text-center fw-bold fs-4">
							<span class="badge bg-secondary w-50">다운로드 파일 목록</span>
						</div>
						<div class="card-body" style="overflow-y: auto;">
							<div class="row ms-auto me-auto">
								<div class="mt-3 shadow p-3 mb-3 bg-body">
									<nav class="nav nav-pills flex-column flex-sm-row">
										<a class="flex-sm-fill text-sm-center nav-link active" aria-current="page" href="#"> 
											<i class="fa-solid fa-files fa-2xl"></i>
											<p class="mt-2 mb-0">
												<span class="badge bg-dark">전체파일</span>
											</p>
										</a> 
										<a class="flex-sm-fill text-sm-center nav-link" href="#">
											<i class="fa-solid fa-image fa-2xl"></i>
											<p class="mt-2 mb-0">
												<span class="badge bg-dark">이미지</span>
											</p>
										</a>
										<a class="flex-sm-fill text-sm-center nav-link" href="#">
											<i class="fa-solid fa-file-pdf fa-2xl"></i>
											<p class="mt-2 mb-0">
												<span class="badge bg-dark">PDF</span>
											</p>
										</a>
										<a class="flex-sm-fill text-sm-center nav-link" href="#">
											<i class="fa-solid fa-file-doc fa-2xl"></i>
											<p class="mt-2 mb-0">
												<span class="badge bg-dark">DOC</span>
											</p>
										</a>
										<a class="flex-sm-fill text-sm-center nav-link" href="#">
											<i class="fa-solid fa-file-zip fa-2xl"></i>
											<p class="mt-2 mb-0">
												<span class="badge bg-dark">ZIP</span>
											</p>
										</a>
										<a class="flex-sm-fill text-sm-center nav-link" href="#">
											<i class="fa-solid fa-file fa-2xl"></i>
											<p class="mt-2 mb-0">
												<span class="badge bg-dark">ETC</span>
											</p>
										</a>
									</nav>
								</div>

								<div class="col-md-12 justify-content-center d-flex">
									<input class="form-control w-75" type="search"
										placeholder="Search" aria-label="Search">
									<button class="btn btn-outline-dark ms-3 w-25" type="button">검색</button>
								</div>

								<div class="mt-1 shadow p-3 mt-3 bg-body rounded">
									<div class="row">
										<c:choose>
											<c:when test="${empty storageList }">
												업음
											</c:when>
											<c:otherwise>
												<c:forEach items="${storageList }" var="storage">
													<div class="col-md-3">
														<div class="card">
															<div class="image-box">
																<img src="${storage.filePath }" class="img-thumbnail card-img-top" style="height: 274px;">
															</div>
															<div class="card-body">
																<h5 class="card-title">${storage.fileName }</h5>
																<p class="card-text">파일 내용</p>
															</div>
															<ul class="list-group list-group-flush">
																<li class="list-group-item">${storage.fileType }</li>
																<li class="list-group-item">${storage.fileFancySize }</li>
															</ul>
															<div class="card-footer">
																<a href="#" class="card-link float-start ms-5"> 
																	<i class="fa-regular fa-file-pen fa-2xl"></i>
																</a> 
																<a href="#" class="card-link float-end me-5">
																	<i class="fa-regular fa-trash fa-2xl"></i>
																</a>
															</div>
														</div>
													</div>
												</c:forEach>
											</c:otherwise>
										</c:choose>
										
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card mt-3">
						<div class="card-header text-center fw-bold fs-4">
							<span class="badge bg-primary w-50">찜영역</span>
						</div>
						<div class="card-body text-center">
							<div class="row">
								<div class="col-md-4">
									<div class="card">
										<div class="card-header fw-bold">찜파일</div>
										<div class="card-body">파일정보</div>
										<div class="card-footer d-flex justify-content-center">
											<button type="button" style="border: 0;">
												<i class="fa-regular fa-file-pen fa-2xl me-2"></i>
											</button>
											<button type="button" style="border: 0;">
												<i class="fa-regular fa-trash fa-2xl ms-2"></i>
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
</body>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script>
	$(function() {
		let iArray = $('.fa-2xl');

		iArray.on('mouseenter', function() {
			$(this).addClass('fa-beat');
		}).on('mouseleave', function() {
			$(this).removeClass('fa-beat');
		});

		
		
	});
	
</script>

</html>