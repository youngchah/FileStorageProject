<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<div class="row ms-auto me-auto">
    <div class="col-md-8">
        <div class="card mt-3">
            <div class="card-header text-center fw-bold fs-4">
                <span class="badge bg-secondary w-50">업로드 파일 목록</span>
            </div>
            <div class="card-body" style="overflow-y: auto;">
                <div class="row ms-auto me-auto">
                    <div class="mt-3 shadow p-3 mb-3 bg-body">
                        <nav class="nav nav-pills flex-column flex-sm-row" id="nav">
                            <a class="flex-sm-fill text-sm-center nav-link" aria-current="page" href="#">
                                <i class="fa-solid fa-files fa-2xl"></i>
                                <p class="mt-2 mb-0">
                                    <span class="badge bg-dark" id="file_all">전체파일</span>
                                </p>
                            </a>
                            <a class="flex-sm-fill text-sm-center nav-link" href="#">
                                <i class="fa-solid fa-image fa-2xl"></i>
                                <p class="mt-2 mb-0">
                                    <span class="badge bg-dark" id="file_image">이미지</span>
                                </p>
                            </a>
                            <a class="flex-sm-fill text-sm-center nav-link" href="#">
                                <i class="fa-solid fa-file-pdf fa-2xl"></i>
                                <p class="mt-2 mb-0">
                                    <span class="badge bg-dark" id="file_pdf">PDF</span>
                                </p>
                            </a>
                            <a class="flex-sm-fill text-sm-center nav-link" href="#">
                                <i class="fa-solid fa-file-doc fa-2xl"></i>
                                <p class="mt-2 mb-0">
                                    <span class="badge bg-dark" id="file_doc">DOC</span>
                                </p>
                            </a>
                            <a class="flex-sm-fill text-sm-center nav-link" href="#">
                                <i class="fa-solid fa-file-zip fa-2xl"></i>
                                <p class="mt-2 mb-0">
                                    <span class="badge bg-dark" id="file_zip">ZIP</span>
                                </p>
                            </a>
                            <a class="flex-sm-fill text-sm-center nav-link" href="#">
                                <i class="fa-solid fa-file fa-2xl"></i>
                                <p class="mt-2 mb-0">
                                    <span class="badge bg-dark" id="file_etc">ETC</span>
                                </p>
                            </a>
                        </nav>
                    </div>

                    <div class="col-md-12 justify-content-center d-flex">
                        <input class="form-control w-100" type="search" placeholder="검색어를 입력해주세요" aria-label="Search"
                            id="search">
                    </div>

                    <div class="mt-1 shadow p-3 mt-3 bg-body rounded">
                        <div class="row" style="overflow:auto;" id="list">
                            <c:choose>
                                <c:when test="${empty storageList }">
                                    	업음
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${storageList }" var="storage">
                                        <c:set var="type" value="${fn:split(storage.fileType, '/')[0]}" />
                                        <c:set var="ext" value="${fn:split(storage.fileName, '.')}" />
                                        <c:set var="ext" value="${ext[fn:length(ext)-1]}" />
                                        <div class="col-md-3 mt-3">
                                            <div class="card">
                                                <div class="image-box">
                                                    <c:choose>
                                                        <c:when test="${type eq 'image'}">
                                                            <img src="${storage.filePath }"
                                                                class="img-thumbnail card-img-top"
                                                                style="height: 274px;" id="image_${storage.fileNo }">
                                                        </c:when>
                                                        <c:when test="${ext eq 'pdf'}">
                                                            <img src="${pageContext.request.contextPath }/resources/image/pdf.png"
                                                                class="img-thumbnail card-img-top"
                                                                style="height: 274px;" id="pdf_${storage.fileNo }">
                                                        </c:when>
                                                        <c:when test="${ext eq 'doc' or ext eq 'docx'}">
                                                            <img src="${pageContext.request.contextPath }/resources/image/doc.png"
                                                                class="img-thumbnail card-img-top"
                                                                style="height: 274px;" id="doc_${storage.fileNo }">
                                                        </c:when>
                                                        <c:when test="${ext eq 'zip'}">
                                                            <img src="${pageContext.request.contextPath }/resources/image/zip.png"
                                                                class="img-thumbnail card-img-top"
                                                                style="height: 274px;" id="zip_${storage.fileNo }">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath }/resources/image/etc.png"
                                                                class="img-thumbnail card-img-top"
                                                                style="height: 274px;" id="etc_${storage.fileNo }">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="card-body">
                                                    <h5 class="card-title">${storage.fileName }</h5>
                                                    <p class="card-text">${storage.fileContent }</p>
                                                </div>
                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item">
                                                        <i class="fa-solid fa-text"></i>
                                                        ${storage.fileType }
                                                    </li>
                                                    <li class="list-group-item">
                                                        <i class="fas fa-battery-full"></i>
                                                        ${storage.fileFancysize }
                                                    </li>
                                                    <li class="list-group-item">
                                                        <i class="fa-solid fa-calendar"></i>
                                                        ${storage.fileDate }
                                                    </li>
                                                </ul>
                                                <div class="card-footer d-flex justify-content-center">
                                                    <a href="download.do?fileNo=${storage.fileNo }" class="card-link me-1">
                                                        <i class="fa-regular fa-download fa-2xl"></i>
                                                    </a>
                                                    <a href="#" class="card-link me-2">
                                                    	<c:set var="loop" value="false" />
                                                    	<c:if test="${not empty wishList }">
															<c:forEach var="wish" items="${wishList }">
		                                                    	<c:if test="${not loop }">
			                                                    	<c:choose>
			                                                    		<c:when test="${wish.fileNo eq storage.fileNo }">
			                                                        		<c:set var="isLike" value="fa-solid" />
			                                                        		<c:set var="loop" value="true" />
			                                                    		</c:when>
			                                                    		<c:otherwise>
			                                                    			<c:set var="isLike" value="fa-regular"/>
			                                                    		</c:otherwise>
			                                                    	</c:choose>
			                                                    </c:if>
                                                    		</c:forEach>
                                                    	</c:if>
			                                            <i class="${isLike } fa-heart fa-2xl" data-file="${storage.fileNo }" data-no="${loginUser.userNo}"></i>
                                                    </a>
                                                    <a href="edit.do?fileNo=${storage.fileNo }" class="card-link me-2">
                                                        <i class="fa-regular fa-file-pen fa-2xl"></i>
                                                    </a>
                                                    <a href="#" class="card-link ms-2" data-file="${storage.fileNo }">
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
                    <c:if test="${not empty wishList }">
                        <c:forEach var="wish" items="${wishList }">
                            <div class="col-md-4">
                                <div class="card">
                                    <div class="card-header fw-bold">${wish.storage.fileName }</div>
                                    <div class="card-body">
                                        <img src="${wish.storage.filePath }" class="img-fluid img-thumbnail">
                                        <p>${wish.storage.fileFancysize }</p>
                                        <p>${wish.wishDate }</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
            <div class="card-footer bg-dark">
            	<div class="col-md-12">
            		<button type="button" class="btn fs-6 fw-bold text-white w-100" id="likePageBtn" data-no="${loginUser.userNo }">찜목록</button>
            	</div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="imageView" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="imageTitle"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <img src="" id="image" class="img-fluid img-thumbnail">
            </div>
        </div>
    </div>
</div>

<script>
$(function() {
	var oldText = '';
	
	let list = $('#list');
	let nav = $('#nav');
	let imageBox = $('.image-box');
	let search = $('#search');
	let likePageBtn = $('#likePageBtn');
	
	likePageBtn.on('click', function() {
		let userNo = $(this).data('no');
		
		if(!userNo) {
			alert('로그인 후 이용가능합니다!');
			return false;
		}
		
		location.href='wishlist.do?userNo='+userNo;
	});
	
	search.on('propertychange change keyup paste input', function() {
		let searchText = $(this).val();
		
		if(searchText == oldText) {
			return;
		}
		
		oldText = searchText;
		
		let obj = {searchText : searchText};
		if($('#nav a').hasClass('active')) {
			let activedNav = $('#nav a.active');
			let id = activedNav.children().find('span').attr('id').split('_')[1];
			obj.type = id;
		}
		
		$.get('search.do', obj)
		.done(function(res) {
			createHTML(res);
		});
	});
	
	list.on('click', '.fa-heart', function(e) {
		e.preventDefault();
		
		let url = '';
		let fileNo = $(this).data('file');
		let userNo = $(this).data('no');
		
		console.log(userNo);
		
		if(!userNo) {
			alert('찜하기는 로그인 후 진행해주세요!');
			return false;
		}
		
		if(!fileNo) {
			alert('파일을 찾을 수 없습니다!');
			return false;
		}
		
		let obj = {
			fileNo : fileNo,
			userNo : userNo
		};
		
		if($(this).hasClass('fa-regular')){
			$(this).removeClass('fa-regular');
			$(this).addClass('fa-solid');
			
			url = '/storage/like.do';
		}else{
			$(this).removeClass('fa-solid');
			$(this).addClass('fa-regular');
			
			url = '/storage/dislike.do';
		}
		
		$.post(url, obj)
		.done(function(res) {
			console.log(res);
		})
	});
	
	list.on('click', '.fa-trash', function(e) {
		
		if(confirm('삭제하면 돌이킬 수 없습니다! 삭제하시겠습니까?')){
			
			e.preventDefault();
			
			let fileNo = $(this).parent().eq(0).data('file');
			let obj = {fileNo : fileNo};
			
			console.log(fileNo);
			
			$.post('fileRemove.do', obj, function(res) {
				if(res == 'SUCCESS'){
					
					if($('#nav a').hasClass('active')) {
						let activedNav = $('#nav a.active');
						let id = activedNav.children().find('span').attr('id').split('_')[1];
						
						$.get('main.do/'+id)
						.done(function(res){
							createHTML(res);
						});
					}else{
						$.get('main.do/all')
						.done(function(res){
							createHTML(res);
						});
					}
				}
			});
		}
	});
	
	nav.on('click', 'a', function(e) {
		e.preventDefault();
		
		if($('#nav a').hasClass('active')){
			$('#nav a').removeClass('active');
		}
		
		$(this).addClass('active');
		
		let id = $(this).children().find('span').attr('id').split('_')[1];
		
		$.get('main.do/'+id)
		.done(function(res){
			createHTML(res);
		});
		
	});
	
	imageBox.on('click', 'img', function() {
		let id = $(this).attr('id').split('_')[1];
		
		fetch('display.do?fileNo='+id)
		.then(res => res.blob())
		.then(data => {
			let imageViewModal = new bootstrap.Modal($('#imageView'));
			let title = $(this).closest('.card').find('.card-title').text();
			$('#imageTitle').text(title);
			let type = $(this).closest('.card').find('.list-group-item').eq(0).text().trim().split('/')[0];
			
			if(type === 'image'){
				let src = window.URL.createObjectURL(data);
				$('#image').attr('src', src);
			}else{
				let src = $(this).attr('src');
				$('#image').attr('src', src);
			}
			
			imageViewModal.show();
		});
	});
});
	
	function createHTML(res) {
	
		let list = $('#list');
		list.html('');
		
		for(let storage of res) {
			let html = '';
			let type = storage.fileType.split('/')[0];
			let ext = storage.fileName.split('.')[1];
			
			html += '<div class="col-md-3 mt-2">';
			html += '	<div class="card">';
			html += '		<div class="image-box">';
			
			if(type == 'image')	{
				html += '					<img src="'+storage.filePath+'" class="img-thumbnail card-img-top" style="height: 274px;" id="image_'+storage.fileNo+'">';
			}else if(ext == 'pdf'){
				html += '					<img src="${pageContext.request.contextPath }/resources/image/pdf.png" class="img-thumbnail card-img-top" style="height: 274px;" id="pdf_'+storage.fileNo+'">';
			}else if(ext == 'doc' || ext == 'docx'){
				html += '					<img src="${pageContext.request.contextPath }/resources/image/doc.png" class="img-thumbnail card-img-top" style="height: 274px;" id="doc_'+storage.fileNo+'">';
			}else if(ext == 'zip'){
				html += '					<img src="${pageContext.request.contextPath }/resources/image/zip.png" class="img-thumbnail card-img-top" style="height: 274px;" id="zip_'+storage.fileNo+'">';
			}else{
				html += '					<img src="${pageContext.request.contextPath }/resources/image/etc.png" class="img-thumbnail card-img-top" style="height: 274px;" id="etc_'+storage.fileNo+'">';
			}
			
			html += '		</div>';
			html += '		<div class="card-body">';
			html += '			<h5 class="card-title">'+storage.fileName+'</h5>';
			html += '			<p class="card-text">'+storage.fileContent+'</p>';
			html += '		</div>';
			html += '		<ul class="list-group list-group-flush">';
			html += '			<li class="list-group-item">';
			html += '				<i class="fa-solid fa-text"></i>';
			html += '				'+storage.fileType+'';
			html += '			</li>';
			html += '			<li class="list-group-item">';
			html += '				<i class="fas fa-battery-full"></i>';
			html += '				'+storage.fileFancysize+'';
			html += '			</li>';
			html += '			<li class="list-group-item">';
			html += '				<i class="fa-solid fa-calendar"></i>';
			html += '				'+storage.fileDate+'';
			html += '			</li>';
			html += '		</ul>';
			html += '		<div class="card-footer d-flex justify-content-center">';
			html += '			<a href="download.do?fileNo='+storage.fileNo+'" class="card-link me-1"> ';
			html += '				<i class="fa-regular fa-download fa-2xl"></i>';
			html += '			</a> ';
			html += '			<a href="#" class="card-link me-2"> ';
			html += '				<i class="fa-regular fa-heart fa-2xl"></i>';
			html += '			</a> ';
			html += '			<a href="edit.do?fileNo='+storage.fileNo+'" class="card-link me-2"> ';
			html += '				<i class="fa-regular fa-file-pen fa-2xl"></i>';
			html += '			</a> ';
			html += '			<a href="#" class="card-link ms-2" data-file="'+storage.fileNo+'">';
			html += '				<i class="fa-regular fa-trash fa-2xl"></i>';
			html += '			</a>';
			html += '		</div>';
			html += '	</div>';
			html += '</div>';
			
			list.append(html);
		}
	}
</script>