<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<title>공기 정화 식물</title>
<link href="${pageContext.request.contextPath}/resources/css/category.css" rel="stylesheet" type="text/css">
</head>

<body>
<div class="container">
	<div class="row header">
			<!-- 헤더부분 -->
			<jsp:include page="/frame/header.jsp"></jsp:include>
		</div>
	<div class="row" id="categoryMD">
		<div class="col-4 d-none d-md-block ">
			<a href="/category.item?category_id=p100&page=1"><img src="/resources/images/category_Air.png" style="width:100%"></a>
		</div>
		<div class="col-4 d-none d-md-block">
			<a href="/category.item?category_id=p200&page=1"><img src="/resources/images/category_In.png" style="width:100%"></a>
		</div>
		<div class="col-4 d-none d-md-block">
			<a href="/category.item?category_id=p300&page=1"><img src="/resources/images/category_Out.png" style="width:100%"></a>
		</div>
	</div>
	<div class="row" id="categorySM">
		<div class="col-4 d-block d-sm-none d-flex justify-content-center">
			<a href="/category.item?category_id=p100&page=1"><span>[ 공기정화 ]</span></a>
		</div>
		<div class="col-4 d-block d-sm-none d-flex justify-content-center">
			<a href="/category.item?category_id=p200&page=1"><span>[ 실내식물 ]</span></a>
		</div>
		<div class="col-4 d-block d-sm-none d-flex justify-content-center">
			<a href="/category.item?category_id=p300&page=1"><span>[ 실외식물 ]</span></a>
		</div>
	</div>
	<div class="row" id="links">
		<div class="col-6 countBox">
			<span id="count">총 ${count}개의 상품이 검색되었습니다.</span>
		</div>
		<div class="col-6 search justify-content-end">
                <a id="lowPrice">낮은 가격</a>
          		<span>|</span>
                <a id="highPrice">높은 가격</a>
           		<span>|</span>
                <a id="itemName">제품명</a>
            </div>
	</div>
	<div class="contentBox">
	<div class="row content-body">
		<c:forEach items="${itemList}" var="dto">
			<div class="col-6 col-lg-3 d-flex justify-content-center">
				<div class="card">
					<a href="/detail.item?item_no=${dto.item_no}"> <img
						src="/resources/images/items/${dto.sys_name}"
						class="card-img-top">
					</a>
					<div class="card-body">
						<h5 class="card-text">${dto.item_name}</h5>
						<p class="price">${dto.price}</p>
					</div>
				</div>
			</div>
			<div class="d-none" id="item_no">${dto.item_no}</div>
		</c:forEach>
	</div>
	</div>
	<div class="row" id="pacing"></div>
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<c:if test="${pageMap.isPrev eq true}">
			<li class="page-item"><a class="page-link" href="/category.item?category_id=${pageMap.category_id}&page=${pageMap.startNavi - 1}" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
			</c:if>
			<c:forEach var="pageNum" begin="${pageMap.startNavi}" end="${pageMap.endNavi}" step="1">
				<li class="page-item"><a class="page-link" href="/category.item?category_id=${pageMap.category_id}&page=${pageNum}">${pageNum}</a></li>
			</c:forEach>
			<c:if test="${pageMap.isNext eq true}">
				<li class="page-item"><a class="page-link" href="/category.item?category_id=${pageMap.category_id}&page=${pageMap.endNavi + 1}" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
			</c:if>
		</ul>
	</nav>
</div>

<script>
	let urlSearch = new URLSearchParams(location.search);
	let category_id = urlSearch.get('category_id');
	console.log(category_id);
	
	// 낮은가격순
	$("#lowPrice").on("click",function() {
		$.ajax({
			url:"/categoryOrderBy.item"
			, type:"post"
			, data: {
				orderBy: "price_asc"
				, category_id: category_id
			}
			, success: function(data) {
				selectPriceAndName(data);
			}
			, error: function(e) {
				console.log(e);
			}
	  	})
	})
	
	// 높은가격순
	$("#highPrice").on("click",function() {
		$.ajax({
			url:"/categoryOrderBy.item"
			, type:"post"
			, data: {
				orderBy: "price_desc"
				, category_id: category_id
			}
			, success:function(data) {
				selectPriceAndName(data);
			}
			, error:function(e) {
				console.log(e);
			}
  		})
	})
	
	// 이름순으로
	$("#itemName").on("click",function() {
	  $.ajax({
		url:"/categoryOrderBy.item"
	   ,type:"post"
	   ,data: {
			orderBy: "itemName"
			, category_id: category_id
	   }
	   ,success:function(data){
		   selectPriceAndName(data);
	   }
	   ,error:function(e){
		   console.log(e);
	   }
	  })
	})
	
	function selectPriceAndName(data){
	
		let list = JSON.parse(data);
		console.log(list);
		
		$(".content-body").empty();
		
		  if(list.length == 0){ //등록된 게시물이 없을때
			  console.log("dsaadaa");
			  let row2 = $("<div>").addClass('row');
			  let col = $("<div>").addClass('col d-flex justify-content-center');
			  let h2 = $("<h2>").html("등록된 제품이 없습니다.");
			  
			  col.append(h2);
			  row2.append(col);
			  $(".content-body").append(row2);
			  $(".contentBox").append($(".content-body"));
			  
			  
		  }else{ //등록된 게시물이 있을때
			  
			  for(let dto of list){
					 let col = $("<div>").addClass('col-6 col-lg-3 d-flex justify-content-center');
					 let card = $("<div>").addClass('card'); 
					 let a = $("<a>").attr("href","/detail.item?item_no="+dto.item_no);
					 let img = $("<img>").attr("src","/resources/images/items/"+dto.sys_name).addClass('card-img-top');
					 
					 let card2 = $("<div>").addClass('card-body');
					 let h5 = $("<h5>").addClass('card-text').html(dto.item_name);
					 let p = $("<p>").addClass('card-text col-12').html(dto.price);
					 
					 card2.append(h5,p);
					 a.append(img);
					 
					 card.append(a,card2);
					 col.append(card);
					 
					 $(".content-body").append(col);
					 $(".contentBox").append($(".content-body"));
					 
			}
		  }
		
	}
</script>

</body>

</html>