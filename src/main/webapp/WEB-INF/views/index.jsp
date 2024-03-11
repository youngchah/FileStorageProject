<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
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
<c:set scope="session" var="loginUser" value="${LOGIN_USER }" />

<body style="overflow-x: hidden;">
	<main>
      	<!-- HEADER -->
      	<tiles:insertAttribute name="header" />
      	
     		<!-- CONTENT -->
     		<tiles:insertAttribute name="content" />
     		
     	<!-- FOOTER -->
     	<tiles:insertAttribute name="footer" />
	</main>		
</body>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script>
	$(function() {
		
		let wishPage = $('#wishpage');
		wishPage.on('click', function(e) {
			e.preventDefault();
			
			let userNo = $(this).data('no');
			
			if(!userNo) {
				alert('로그인 후 이용가능합니다!');
				return false;
			}
			
			location.href='wishlist.do?userNo='+userNo;
		});
		
		var message = '${message}';
		
		if(message != null && message != '') {
			alert(message);
		}
		
		let iArray = $('.fa-2xl');
		
		iArray.on('mouseenter', function() {
			$(this).addClass('fa-beat');
		}).on('mouseleave', function() {
			$(this).removeClass('fa-beat');
		});
		
		let login = $('#login');
		
		login.on('click', function(e) {
			e.preventDefault();
			let icon = login.find('i');
			if(!icon.hasClass('text-danger')){
					
				let userId = $('#userId').val();
				let userPw = $('#userPw').val();
				
				let obj = {
					userId : userId,
					userPw : userPw
				};
				
				$.ajax({
					url: 'login.do',
					type: 'post',
					data: JSON.stringify(obj),
					dataType: 'text',
					contentType: 'application/json; charset=UTF-8',
					success: function(res) {
						console.log(res);
						
						if(res === 'SUCCESS') {
							$('#loginForm').remove();
							$('#signup').remove();
							icon.addClass('text-danger');
							location.reload();
						}else{
							alert('로그인 실패!');
						}
					}
				});
				
			}else{
				location.href = 'logout.do';
			}
		});
	});
</script>

</html>