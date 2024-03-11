<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<div class="container d-flex flex-column justify-content-center min-vh-100">
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    <h4 class="card-title text-center mt-2">회원가입</h4>
                </div>
                <div class="card-body d-flex justify-content-center">
                    <form method="post" id="frm">
                        <div class="row g-5 align-items-center mb-3">
                            <div class="col-auto">
                                <label for="userId" class="col-form-label">아이디</label>
                            </div>
                            <div class="col-auto">
                                <input type="text" id="userId" name="userId" value="${user.userId }" class="form-control">
                           </div>
                           <span style="color:red;">${errors.userId }</span>
                       </div>
                       <div class="row g-4 align-items-center mb-3">
                           <div class="col-auto">
                               <label for="userPw" class="col-form-label">비밀번호</label>
                           </div>
                           <div class="col-auto ms-2">
                               <input type="password" id="userPw" name="userPw" class="form-control">
                           </div>
                           <span style="color:red;">${errors.userPw }</span>
                       </div>
                       <div class="row g-5 align-items-center mb-3">
                           <div class="col-auto">
                               <label for="nickname" class="col-form-label">닉네임</label>
                           </div>
                           <div class="col-auto">
                               <input type="text" id="nickname" name="nickname" value="${user.nickName }"
                                   class="form-control">
                           </div>
                           <span style="color:red;">${errors.nickname }</span>
                       </div>
                       <span style="color:red;">${message }</span>
                        <button type="button" id="btn"
                            class="btn btn-outline-success d-grid gap-2 col-6 mx-auto">회원가입</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
	let btn = document.getElementById('btn');
	let frm = document.getElementById('frm');
	let inputs = frm.querySelectorAll('input');
	
	inputs.forEach(input => {
	    input.addEventListener('change', function (e) {
	        e.target.classList.remove('is-invalid');
	        e.target.classList.add('is-valid');
	    })
	})
	
	btn.addEventListener('click', function (e) {
	    if (!frm.userId.value) {
	        e.target.classList.remove('is-valid');
	        frm.userId.classList.add('is-invalid');
	        return false;
	    }
	
	    if (!frm.userPw.value) {
	        e.target.classList.remove('is-valid');
	        frm.userPw.classList.add('is-invalid');
	        return false;
	    }
	
	    if (!frm.nickname.value) {
	        e.target.classList.remove('is-valid');
	        frm.nickname.classList.add('is-invalid');
	        return false;
	    }
	
	    frm.submit();
	});
</script>