<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div class="row ms-auto me-auto">
    <div class="col-md-12">
        <div class="card mt-3">
            <div class="card-header text-center fw-bold fs-4">
                <span class="badge bg-secondary w-50">찜한 파일 목록</span>
            </div>
            <div class="card-body" style="overflow-y: auto;">
                <div class="row ms-auto me-auto">
                    <div class="mt-1 shadow p-3 mt-3 bg-body rounded">
                        <div class="row" style="overflow:auto;" id="list">
                            <c:choose>
                                <c:when test="${empty wishList }">
                                   	 업음
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${wishList }" var="wish">
                                        <c:set var="type" value="${fn:split(wish.storage.fileType, '/')[0]}" />
                                        <c:set var="ext" value="${fn:split(wish.storage.fileName, '.')}" />
                                        <c:set var="ext" value="${ext[fn:length(ext)-1]}" />
                                        <div class="col-md-3 mt-3">
                                            <div class="card">
                                                <div class="image-box">
                                                    <c:choose>
                                                        <c:when test="${type eq 'image'}">
                                                            <img src="${wish.storage.filePath }"
                                                                class="img-thumbnail card-img-top"
                                                                style="height: 274px;"
                                                                id="image_${wish.storage.fileNo }">
                                                        </c:when>
                                                        <c:when test="${ext eq 'pdf'}">
                                                            <img src="${pageContext.request.contextPath }/resources/image/pdf.png"
                                                                class="img-thumbnail card-img-top"
                                                                style="height: 274px;" id="pdf_${wish.storage.fileNo }">
                                                        </c:when>
                                                        <c:when test="${ext eq 'doc' or ext eq 'docx'}">
                                                            <img src="${pageContext.request.contextPath }/resources/image/doc.png"
                                                                class="img-thumbnail card-img-top"
                                                                style="height: 274px;" id="doc_${wish.storage.fileNo }">
                                                        </c:when>
                                                        <c:when test="${ext eq 'zip'}">
                                                            <img src="${pageContext.request.contextPath }/resources/image/zip.png"
                                                                class="img-thumbnail card-img-top"
                                                                style="height: 274px;" id="zip_${wish.storage.fileNo }">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath }/resources/image/etc.png"
                                                                class="img-thumbnail card-img-top"
                                                                style="height: 274px;" id="etc_${wish.storage.fileNo }">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="card-body">
                                                    <h5 class="card-title">${wish.storage.fileName }</h5>
                                                    <p class="card-text">${wish.storage.fileContent }</p>
                                                </div>
                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item">
                                                        <i class="fa-solid fa-text"></i>
                                                        ${wish.storage.fileType }
                                                    </li>
                                                    <li class="list-group-item">
                                                        <i class="fas fa-battery-full"></i>
                                                        ${wish.storage.fileFancysize }
                                                    </li>
                                                    <li class="list-group-item">
                                                        <i class="fa-solid fa-calendar"></i>
                                                        ${wish.wishDate }
                                                    </li>
                                                </ul>
                                                <div class="card-footer d-flex justify-content-center">
                                                    <a href="download.do?fileNo=${wish.storage.fileNo }"
                                                        class="card-link me-1">
                                                        <i class="fa-regular fa-download fa-2xl"></i>
                                                    </a>
                                                    <a href="#" class="card-link me-2">
                                                        <i class="fa-regular fa-heart fa-2xl"
                                                            data-file="${wish.storage.fileNo }"
                                                            data-no=${loginUser.userNo }></i>
                                                    </a>
                                                    <a href="edit.do?fileNo=${wish.storage.fileNo }"
                                                        class="card-link me-2">
                                                        <i class="fa-regular fa-file-pen fa-2xl"></i>
                                                    </a>
                                                    <a href="#" class="card-link ms-2"
                                                        data-no="${wish.storage.fileNo }">
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