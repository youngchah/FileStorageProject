<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Document</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/fontawesome-6-pro@6.4.0/css/all.min.css"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>

<body>
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
	<main class="jumbotron">
		<div class="container container-fluid mt-3 m-auto">
			<div class="row">
				<div class="col-md-6">
					<div class="card-body text-center">
						<img src="${pageContext.request.contextPath }/resources/image/image.png" class="img-fluid img-thumbnail" id="thumbnailImg">
					</div>
				</div>
				<div class="col-md-6">
					<div class="card">
						<div class="card-body">
							<form action="" class="form-group" method="post" enctype="multipart/form-data" id="frm">
								<div class="form-floating">
									<input type="text" name="fileContent" id="fileName" class="form-control" placeholder=""> 
										<label for="fileName" class="floating-label">파일 내용</label>
								</div>
								<div class="mb-3">
									<label for="formFile" class="form-label"></label> 
									<input class="form-control" type="file" name="formFile" id="formFile">
								</div>
								<div class="d-flex justify-content-center">
									<input type="button" id="uploadBtn" value="업로드" class="btn btn-primary w-25">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script>
	let formFile = $('#formFile');
	let uploadBtn = $('#uploadBtn');
	
	uploadBtn.on('click', function() {
		if(formFile.val() == null && formFile.val().trim() == '') {
			alert('파일 업로드를 진행해주세요');
			return false;
		}
		
		$('#frm').submit();
	});
	
	formFile.on('change', function(e) {
		let file = e.target.files[0];
		
		if(isImageFile(file)){
			let reader = new FileReader();
			
			reader.onload = function(event) {
				$('#thumbnailImg').attr('src', event.target.result);
			}
			
			reader.readAsDataURL(file);
		}
	});
	
	function isImageFile(file) {
		let ext = file.name.split('.').pop().toLowerCase();
		return ($.inArray(ext, ['jpg','jpeg','png','gif']) === -1) ? false : true; 
	}
	
</script>

</html>