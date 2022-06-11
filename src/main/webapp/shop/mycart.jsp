<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath}/resources/css/mycart.css"
	rel="stylesheet" type="text/css">
<title>장바구니</title>

<style>
</style>

</head>
<body>
<div class="container">
<%-- 헤더 --%>
<jsp:include page="/frame/header.jsp"></jsp:include>

<%-- title --%>
	<div class="row d-flex justify-content-between align-items-center mb-2">
		<div class="col-7 col-lg-8">
			<h3 id="title_h3">SHOPPING CART</h3>
		</div>
		<div class="col-5 col-lg-4">
			<button type="button" class="btn btn-outline-secondary " id="btnDelete">삭제</button>
		</div>
	</div>
	
<%-- title_talbe --%>
	<div class="row title-row">
		<div class="col-1 d-flex align-items-center justify-content-center">
		</div>
		<div class="col-7 d-flex align-items-center justify-content-center">
			<span>product</span>
		</div>
		<div class="col-2 d-flex align-items-center justify-content-center">
			<span>Quantity</span>
		</div>
		<div class="col-2 d-flex align-items-center justify-content-center">
			<span>Price</span>
		</div>
	</div>
	
<%-- body-list --%>
	<div class="body-list">
		<c:if test="${empty list}">
			<div class="d-flex justify-content-center p-3">
				장바구니에 담긴 상품이 없습니다.
			</div>		
		</c:if>
		<c:forEach items="${list}" var="dto">
			<c:if test="${loginSession.user_id eq dto.user_id}">
			<div class="row list-row m-2">
				<div class="col-1 d-flex align-items-center justify-content-center">
					<input class="form-check-input checkBox" type="checkbox"
							id="${dto.price}" name="checkBox" value="${dto.item_no}">
				</div>
				<div class="col-3 col-lg-2 d-flex align-items-center justify-content-start">
					<img src="/resources/images/items/${dto.item_name}.png" id="itemImg" style="width: 50%;">
				</div>
				<div class="col-4 col-lg-5 itemName d-flex align-items-center">
					<span>${dto.item_name}</span>
				</div>
				<div class="col-2 quantityBox d-flex align-items-center justify-content-center">
					<input type='button' id="btnPlus" value='+' />
					<input type="text" class="qty" id="qty" value="${dto.quantity}" readOnly>
					<input type='button' id="btnMinus" value='-' />
					<input type='hidden' class="individualPrice" value="${dto.quantity * dto.price}">
					<input type="hidden" class="price" value="${dto.price}">
				</div>
					<div class="col-2 priceName d-flex align-items-center justify-content-center">
					<span>${dto.price}</span>
					</div>				
			</div>
			</c:if>
		</c:forEach>
	</div>
	
<%-- 총가격 --%>
	<div class="row price-row ">
		<div class="col amountPart">총 가격 : <span id="totalPrice">0</span></div>
	</div>
	
<%-- 제출버튼 --%>
	<div class="row button-row">
		<div class="col btnRow">
			<button type="button" class="btn btn-outline-secondary btn-lg"
				id="btnShopping">쇼핑 계속하기</button>
			<button type="button" class="btn btn-outline-secondary btn-lg" id="btnOrder">
				주문하기</button>
		</div>
	</div>
	<jsp:include page="/frame/footer.jsp"></jsp:include>
</div>

<script>

	// 처음 로드 될 때 나오는 총 가격 계산
	let listSize = parseInt("${listSize}");
	getTotalPrice();
	
	// 수량 추가와 감소시 프론트에서만 수량을 변경
	$(".quantityBox").on("click", "#btnPlus", function() {
		let qty = $(this).next().val();
		if(qty > 4) {
  			alert("5개 이상 담을 수 없습니다.");
  			return;
		}
		qty = parseInt(qty) + 1;
		$(this).next().val(qty);
		getTotalPrice();

	})
	
	$(".quantityBox").on("click", "#btnMinus", function() {
		
		let qty = $(this).prev().val();
		if(qty < 2) {
  			return;
		}
		qty = parseInt(qty) - 1;
		console.log(qty);
		$(this).prev().val(qty);
		getTotalPrice();

	})
	
	// 변경된 수량에 맞게 총 금액 계산
	function getTotalPrice() {
		let total = 0;
		for(let i = 0; i < listSize; i++) {
			let price = $(".price").eq(i).val();
			let quantity = parseInt($(".qty").eq(i).val());
			let itemPrice = parseInt(price) * parseInt(quantity);
		
			total = total + (price * quantity);
		}
		$("#totalPrice").html(total);
	}
	
	// 쇼핑 계속하기 눌렀을 때
	$("#btnShopping").on("click", function(){
		location.href = "/toSearchPage.item?curPage=1";
	})
	
	
	// 장바구니 주문 버튼 눌렀을 때
	$("#btnOrder").on("click", function() {
		let ans = confirm("장바구니에 담긴 상품을 주문하시겠습니까?");
		if(ans) {
		
			let qty_arr = [];
			let no_arr = [];
			// 각 상품들의 최종 수량 배열에 담기 
			$(".qty").each(function(){
				//console.log("수량 : " + $(this).val() );
				qty_arr.push($(this).val());
				console.log(qty_arr);
			}); 
			
			// 장바구니에 담긴 아이템들 배열에 담기
			$(".checkBox").each(function(){
				//console.log("item_no : " + $(this).val() );
				no_arr.push($(this).val());
				console.log(no_arr);
			});
							
			
		 $.ajax({
				   
			url: "/changeQty.cart"
		,	method: "post"
		,	traditional: true
		,	data: {"item_no": no_arr, "quantity":  qty_arr }
		,	dataType: "json"
		,	success: function(data){
				console.log(data);
				location.href = "/purchase.order";
			}
		,	 error: function(e){
	    	 console.log(e);
	    	}		      		    
				     
		 });
		}
	});


   // 삭제 요청 ajax
	$("#btnDelete").on("click", function() {
		let con = confirm("이 물품들을 장바구니에서 삭제하시겠습니까?");
		// 배열로 체크한 항목 담기
		if(con){
    		let checkval = "";
    		let checkVals = [];
        	$("input:checkbox:checked").each(function() {
        		checkVals.push($(this).val());
        		console.log(checkVals);
        	});
			
        	// ajax 요청으로 처리
        	$.ajax({
        		url: "/delete.cart"
                , type:"post"
                , traditional :true
                , data: {
                	checkVals
                }
        		, success: function(data) {
        			let list = JSON.parse(data);
        			console.log(list);
        			console.log("list 길이 : " + list.length);
        			
        			printCartList(data);
      			  			
	        	// 물품 삭제 후 남은 물품들에 대한 수량부분, 총금액 계산
				let total = 0;
	   		    for(let i = 0; i < list.length; i++){
	    		
		    		let price = parseInt($(".price").eq(i).val());
		    		let quantity = parseInt($(".qty").eq(i).val());
		    		let individualPrice = parseInt(price * quantity);  
		   
		    		total = total + (price * quantity);
		    		
		    		$("#totalPrice").html(total);
		    		
		    		// 삭제 후 수량 +
		    		$(".btnPlus").eq(i).on("click",function(){
		    			
		    			if(quantity > 4) {
		    	  			alert("5개 이상 담을 수 없습니다.");
		    	  			return;
		    			}
		
						total = parseInt($("#totalPrice").html());
						quantity = quantity + 1;
						console.log(quantity);
						$(".qty").eq(i).val(quantity);
						
						total = total + parseInt(price);
						$("#totalPrice").html(total);
						console.log(total);	
						console.log("total after : " + total);
						
					});					
			
					// 삭제 후 수량 -
					$(".btnMinus").eq(i).on("click",function(){
								
					if(quantity <= 1){
						quantity = 1;
						return false;
					}
			     		total = parseInt($("#totalPrice").html());			
						quantity = quantity - 1;
						console.log(quantity);
						$(".qty").eq(i).val(quantity);
					
						total = total - parseInt(price);
						$("#totalPrice").html(total);
		
					});	
			
    			}	    
    	
    				alert("총 "+ checkVals.length + "개의 물품이 삭제되었습니다.");
	
        		}, error:function(e) {
        				console.log(e);
               	}
			})
		}
	})

	
	// ajax 성공 시 리스트 출력해주는 함수
	
	function printCartList(data) {
		let list = JSON.parse(data);
		console.log(list);
		console.log("list 길이 : " + list.length);
		
		$(".body-list").empty();
		
		for(let dto of list) {

				let list = $("<div>").addClass("row list-row m-2");
				
				let col_1 =  $("<div>").addClass("col-1 d-flex align-items-center justify-content-center");
				let checkBox = $("<input>").attr({class:"form-check-input checkBox", type:"checkbox"}).val(dto.item_no);
				col_1.append(checkBox);
				
				let col_2 = $("<div>").addClass("col-2");
 				let img = $("<img>").attr({ src:"/resources/images/items/"+ dto.item_name +".png"});
 				img.css("width","50%")
 				col_2.append(img);
 			
				
				let itemName = $("<div>").addClass("col-5 itemName d-flex align-items-center");
				let nameSpan = $("<span>").html(dto.item_name);
				itemName.append(nameSpan);

				let quantityBox = $("<div>").addClass("col-2 quantityBox d-flex align-items-center justify-content-center");
				let plus = $("<input>").attr({class:"btnPlus" , id:"btnPlus",type:"button"}).val('+');
				let quantity = $("<input>").attr({ class:"qty",id:"qty", type:"text" , "readonly":true}).val(dto.quantity);
				let minus = $("<input>").attr({class:"btnMinus" , id:"btnMinus", type:"button"}).val('-');
				let individualPrice = $("<input>").attr({class:"individualPrice", type:"hidden"}).val(dto.quantity * dto.price);
				let price = $("<input>").attr({class:"price", type:"hidden"}).val(dto.price);				
				
				quantityBox.append(plus, quantity, minus, individualPrice, price);
				
				let priceName = $("<div>").addClass("col-2 d-flex align-items-center justify-content-center");
				let priceSpan = $("<span>").html(dto.price);
				priceName.append(priceSpan);
				
				list.append(col_1,col_2, itemName, quantityBox, priceName);
				
				$(".body-list").append(list);           				
	
			}
	}

</script>
    

</body>
</html>