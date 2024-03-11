<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css"/>

<c:set var="btn" value="업로드" />
<c:if test="${status eq 'edit'}">
	<c:set var="btn" value="수정" />
</c:if>

<main class="jumbotron">
	<div class="container container-fluid mt-3 m-auto">
		<div class="row">
			<div class="col-md-6">
				<div class="card-body text-center">
					<c:set var="type" value="${fn:split(storage.fileType, '/')[0]}" />
					<c:set var="ext" value="${fn:split(storage.fileName, '.')}" />
					<c:set var="ext" value="${ext[fn:length(ext)-1]}" />
					<c:choose>
						<c:when test="${type eq 'image'}">
							<img src="${storage.filePath }" class="img-thumbnail card-img-top" id="image_${storage.fileNo }">
						</c:when>
						<c:when test="${ext eq 'pdf'}">
							<img src="${pageContext.request.contextPath }/resources/image/pdf.png" class="img-thumbnail card-img-top" id="pdf_${storage.fileNo }">
						</c:when>
						<c:when test="${ext eq 'doc' or ext eq 'docx'}">
							<img src="${pageContext.request.contextPath }/resources/image/doc.png" class="img-thumbnail card-img-top" id="doc_${storage.fileNo }">
						</c:when>
						<c:when test="${ext eq 'zip'}">
							<img src="${pageContext.request.contextPath }/resources/image/zip.png" class="img-thumbnail card-img-top" id="zip_${storage.fileNo }">
						</c:when>
						<c:otherwise>
							<img src="${pageContext.request.contextPath }/resources/image/etc.png" class="img-thumbnail card-img-top" id="etc_${storage.fileNo }">
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="col-md-6">
				<div class="card">
					<div class="card-body">
						<form action="upload.do" class="form-group" method="post" enctype="multipart/form-data">
							<div class="form-floating">
								<input type="text" name="fileContent" id="fileContent" class="form-control" value="${storage.fileContent }" placeholder=""> 
								<label for="fileName" class="floating-label">파일 내용</label>
							</div>
							<div class="dropzone mt-3 mb-3" id="drop"></div>
							<div class="alert alert-danger" <c:if test="${empty message }">style="display:none;"</c:if> >${message }</div>
							<div class="d-flex justify-content-center">
								<input type="button" id="uploadBtn" value="${btn }" class="btn btn-primary w-25">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>
	
<script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
<script>
	
	let iArray = $('.fa-2xl');
	
	iArray.on('mouseenter', function() {
		$(this).addClass('fa-beat');
	}).on('mouseleave', function() {
		$(this).removeClass('fa-beat');
	});
	
	Dropzone.autoDiscover = false;
	const drop = new Dropzone('div#drop', {
		url: 'upload.do', // 업로드 할 서버 주소 URL
		method: 'post', // METHOD 타입
		autoProcessQueue: false, // 자동으로 보내기 (true : 파일 업로드 된 후 서버로 요청, false : 서버에는 올라가지 않은 상태)
		clickable: true, // 클릭 가능 여부
		autoQueue: true, // 드래그 드랍 후 바로 서버로 전송
		createImageThumbnails: true, // 파일 업로드 이미지 썸네일 생성
		thumbnailWidth: 300,
		thumbnailHeight: 300,
		
		maxFiles: 1, // 업로드 파일 수 
		paramName: 'file', // 서버에서 사용할 formData 이름 설정
		parallelUploads: 1, // 동시 파일 업로드 수
		uploadMultiple: false, // 다중 업로드 기능
		
		maxFilesize: 100, // MB
		dictFileTooBig: '업로드 할 수 있는 파일의 용량을 초과했습니다! ({{filesize}}MB) / ({{maxFilesize}}MB) 까지만 업로드할 수 있습니다}',
		
		addRemoveLinks: true, // 업로드 후 파일 삭제버튼 표시 여부
		dictRemoveFile: '삭제', // 삭제버튼 표시 텍스트
		
		init: function() {
			let drop = this;
			
			$('#uploadBtn').on('click', function() {
				
				console.log('동작!');
				
				if(!$('#fileContent').val()){
					alert('파일 설명을 입력해주세요!');
					$('#fileContent').focus();
					return false;
				}
				
				if(drop.getRejectedFiles().length > 0) {
					let files = drop.getRejectedFiles();
					alert('거부된 파일이 있습니다!', files);
					return false;
				}
				
				drop.processQueue();
			});
			
			drop.on('thumbnail', function(file, dataURL) {
				$('#thumbnailImg').attr('src', dataURL);
			});
			
			drop.on('addedfile', function(file) {
				if(this.files.length > 1){
					alert('하나의 파일만 업로드 가능합니다!');
					this.removeFile(file);
					return false;
				}
				
				if(this.files.length) {
					
					var hasFile = false;
					
					for(let i = 0; i < this.files.length - 1; i++) {
						if(
							this.files[i].name === file.name &&
							this.files[i].size === file.size &&
							this.files[i].lastModifiedDate.toString() === file.lastModifiedDate.toString()
						) {
							this.removeFile(file);
							alert('동일한 파일입니다!');
						}
					}
				}
			});
			
			drop.on('sending', function (file, xhr, formData) {
				let fileContent = $('#fileContent').val();
				let status = $('#uploadBtn').val();
				if(status == '수정'){
					let fileNo = $('.card-body img').attr('id').split('_')[1];
					formData.append('fileNo', fileNo);
				}
				formData.append('fileContent', fileContent);
			});

			drop.on('success', function (file, responseText) {
			   
			});
			
			drop.on("complete", function(file) {
                this.removeFile(file);
				alert('업로드 성공!');
				location.href = 'main.do';
            });

		}
	});

	
// 	let formFile = $('#formFile');
// 	let uploadBtn = $('#uploadBtn');
	
// 	uploadBtn.on('click', function() {
// 		if(formFile.val() == null && formFile.val().trim() == '') {
// 			alert('파일 업로드를 진행해주세요');
// 			return false;
// 		}
		
// 		$('#frm').submit();
// 	});
	
// 	formFile.on('change', function(e) {
// 		let file = e.target.files[0];
		
// 		if(isImageFile(file)){
// 			let reader = new FileReader();
			
// 			reader.onload = function(event) {
// 				$('#thumbnailImg').attr('src', event.target.result);
// 			}
			
// 			reader.readAsDataURL(file);
// 		}
// 	});
	
// 	function isImageFile(file) {
// 		let ext = file.name.split('.').pop().toLowerCase();
// 		return ($.inArray(ext, ['jpg','jpeg','png','gif']) === -1) ? false : true; 
// 	}
	
</script>

</html>