<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
 <section class="col-md-12">
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
            <div class="collapse navbar-collapse">
                <a class="navbar-brand" aria-current="page" id="wishpage" data-no="${loginUser.userNo }">
                    <i class="fa-solid fa-folder-heart fa-2xl ms-3 me-2"></i>
                  	  찜목록
                </a>
            </div>
            <c:if test="${empty loginUser}">
                <div class="row" id="loginForm">
                    <div class="col input-group input-group-sm">
                        <input type="text" class="form-control" name="userId" id="userId" placeholder="ID"
                            aria-label="ID">
                    </div>
                    <div class="col input-group input-group-sm">
                        <input type="password" class="form-control" name="userPw" id="userPw" placeholder="PW"
                            aria-label="PW">
                    </div>
                </div>
            </c:if>
            <a class="navbar-brand ms-3 float-end" aria-current="page" href="#" id="login">
                <c:if test="${empty loginUser }">
                    <i class="fa-solid fa-power-off fa-2xl"></i>
                </c:if>
                <c:if test="${not empty loginUser }">
                    <i class="fa-solid fa-power-off fa-2xl text-danger"></i>
                </c:if>
            </a>
            <c:if test="${empty loginUser}">
                <a class="navbar-brand ms-3 float-end" aria-current="page" href="register.do" id="signup">
                    <i class="fa-solid fa-right-to-bracket fa-2xl"></i>
                </a>
            </c:if>
        </div>
    </nav>
</section>