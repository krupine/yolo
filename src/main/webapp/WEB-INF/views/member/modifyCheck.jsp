<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<script type="text/javascript">

	if(${status == 0}) {
		
		alert("비밀번호 확인이 기존 비밀번호와 일치하지 않습니다.");
		location.href = "infoModify.yolo";
		
	} else if(${status == 1}) {
		
		alert("바꾸시려는 비밀번호가 기존 비밀번호와 동일합니다.");
		location.href = "infoModify.yolo";
		
	}

</script>