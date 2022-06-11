<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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

<!--폰트-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap"
	rel="stylesheet">

<!-- css -->
<link
	href="${pageContext.request.contextPath}/resources/css/purchase.css"
	rel="stylesheet" type="text/css">
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<title>주문 결제 페이지</title>
</head>
<body>
	<div class="container">
		<!--헤더영역-->
		<jsp:include page="/frame/header.jsp"></jsp:include>
		
		<!-- order / payment-->
		<div class="row titleLabel">
			<h3>ORDER / PAYMENT</h3>
		</div>
		
		<%-- page-content --%>
		<div class="page-content">
			<!-- 구매 리스트 -->
			<div class="contentList">
				<div class="row">
					<div class="col"><span style="font-size: 20px">List 구매리스트</span></div>
				</div>
				<div class="row list-label">
					<div class="col-2 col-lg-1 d-flex justify-content-center">선택</div>
					<div class="col-6 col-lg-8 d-flex justify-content-center">상품명</div>
					<div class="col-2 col-lg-1 d-flex justify-content-center">수량</div>
					<div class="col-2 col-lg-2 d-flex justify-content-center">가격</div>
				</div>
				<c:forEach items="${cartList}" var="cartItem">
					<div class="row tbl_list ">
						<div
							class="col-2 col-lg-1 d-flex justify-content-center align-items-center">
							<input type="checkbox">
						</div>
						<div
							class="col-3 col-lg-3 d-flex justify-content-center align-items-center">
							<img src="/resources/images/items/${cartItem.item_name}.png"
								style="width: 50%;">
						</div>
						<div
							class="col-3 col-lg-5 d-flex justify-content-start align-items-center">
							<div style="letter-spacing: 2px;">${cartItem.item_name}</div>
						</div>
						<div
							class="col-2 col-lg-1 d-flex justify-content-center align-items-center">${cartItem.quantity}</div>
						<div
							class="col-2 col-lg-2 d-flex justify-content-center align-items-center">${cartItem.price}</div>
					</div>
				</c:forEach>
				<div class="row">
					<div class="col-9 d-flex justify-content-end">
						<span>총 가격 : </span>
					</div>
					<div class="col-2">
						<span>${totalPrice} 원</span>
					</div>
				</div>
			</div>
			
			<!-- 주문자 정보 -->
			<div class="orderInfo">
				<div class=" row titleLabel">
					<span style="font-size: 20px">주문자 정보</span>
				</div>
				<div class="content">
					<!-- 주문자명 -->
					<div class="row">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">주문자명</div>
						<div class="col-lg-3 col-9">
							<input type="text" class="form-control" id="order_name"
								name="order_name" value="${loginSession.username}">
						</div>
					</div>
					<!-- 연락처, 이메일 -->
					<div class="row">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">연락처</div>
						<div class="col-lg-3 col-9 d-flex">
							<input type="text" class="form-control" id="order_phone1"
								name="order_phone1"> &nbsp; <input type="text"
								class="form-control" id="order_phone2" name="order_phone2">
							&nbsp; <input type="text" class="form-control" id="order_phone3"
								name="order_phone3">
						</div>
					</div>
					<div class="row">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">이메일</div>
						<div class="col-lg-3 col-9 d-flex align-items-center">
							<input type="text" class="form-control" id="order_email"
								name="order_email" value="${loginSession.email}">
						</div>
					</div>
				</div>
			</div>
			<!-- 배송지 정보 -->
			<div class="deliveryInfo">
				<div class="row titleLabel">
					<div class="col-lg-2 col-3"><span style="font-size: 20px">배송지 정보</span></div>
					<div class="col-lg-10 col-9">
						<input type="checkbox" id="ckBox"> 주문하는 사람과 동일한 이름, 연락처
					</div>

				</div>
				<div class="content">
					<!-- 받는 사람 -->
					<div class="row">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">받는사람</div>
						<div class="col-lg-3 col-9">
							<input type="text" class="form-control" id="delivery_name"
								name="delivery_name">
						</div>
					</div>
					<!-- 연락처 -->
					<div class="row">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">연락처</div>
						<div class="col-lg-3 col-9 d-flex">
							<input type="text" class="form-control" id="phone1">
							&nbsp; <input type="text" class="form-control" id="phone2">
							&nbsp; <input type="text" class="form-control" id="phone3">
						</div>
					</div>
					<!-- 주소 -->
					<div class="addressBox">
						<div class="row" style="border: none;">
							<!-- 주소 -->
							<div
								class="col-lg-2 col-3 d-flex justify-content-center align-items-center">주소</div>
							<div class="col-lg-1 col-3">
								<input type="text" class="form-control text-center" id="postcode"
									name="postcode" readonly>
							</div>
							<!-- 우편번호 검색 -->
							<div class="col-lg-3 col-6">
								<button type="button" id="btnPostcode" class="btn btn-primary"
									style="width: 120px">우편번호검색</button>
							</div>
						</div>
						<div class="row mt-2 mb-2">
							<div class="col-lg-2 col-3"></div>
							<div class="col-lg-4 col-4">
								<input type="text" class="form-control" id="delivery_addr"
									name="delivery_addr" readonly>
							</div>
							<div class="col-lg-4 col-5">
								<input type="text" class="form-control" id="delivery_detail">
							</div>
						</div>
					</div>
					<!-- 주문 메세지 -->
					<div class="row">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">주문메세지</div>
						<div class="col-lg-8 col-9">
							<textarea class="form-control" placeholder="주문메세지를 입력해주세요"
								id="order_msg" name="order_msg"></textarea>
						</div>
					</div>
					<!-- 배송 메세지 -->
					<div class="row mt-2 mb-2">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">배송메세지</div>
						<div class="col-lg-8 col-9">
							<textarea class="form-control" placeholder="배송메세지를 입력해주세요"
								id="delivery_msg" name="delivery_msg"></textarea>
						</div>
					</div>
				</div>
			</div>
			<!-- 배송비 및 할인 정보 -->
			<div class="payMoneyInfo">
				<div class="row payMoneyInfo-title titleLabel">
					<span style="font-size: 20px">배송비 및 할인정보</span>
				</div>
				<div class="row">
					<div
						class="payMoneyInfo-content d-flex justify-content-between align-items-center">
						<div class="col-4 d-flex justify-content-center">상품금액</div>
						<div class="col-4 d-flex justify-content-center">배송비</div>
						<div class="col-4 d-flex justify-content-center">결제 예정금액</div>
					</div>
				</div>
				<div class="row d-flex justify-content-between align-items-center">
					<div
						class=" payMoneyInfo-content d-flex justify-content-between align-items-center ">
						<div class="col-4 d-flex justify-content-center">${totalPrice} 원</div>
						<c:choose>
              <c:when test="${totalPrice > 50000}">
                <div class="col-4 d-flex justify-content-center">배송비 무료</div>
                <div class="col-4 d-flex justify-content-center">${totalPrice}</div>
              </c:when>
              <c:otherwise>
                <div class="col-4 d-flex justify-content-center">3000 원</div>
                <div class="col-4 d-flex justify-content-center">${totalPrice + 3000} 원</div>
              </c:otherwise>
					</c:choose>
					</div>
				</div>
			</div>

			<!-- 약관 동의 -->
			<div class="payMoneyInfo">
				<div class="row payMoneyInfo-title titleLabel">
					<span style="font-size: 20px">주문자 약관동의</span>
				</div>
				<div class="payment_wrap content">
					<div class="row mt-2 mb-2">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">약관동의</div>
						<div class="col-lg-10 col-9">
							<textarea class="textarea" style="width:100%; height: 300px; resize: none;"readonly>
							
[개인정보 수집항목]

회사는 회원가입, 쇼핑몰 이용, 서비스 신청 및 제공 등을 위해 다음과 같은 개인정보를 수집하고 있습니다. 회사는 개인의 주민등록번호 및 아이핀 정보를 받지 않습니다.
가. 개인정보 항목
회원 필수항목: 전자우편주소, 페이스북 ID 및 페이스북에서 제공하는 정보, 트위터 ID 및 트위터에서 제공하는 정보, 구글+ ID 및 구글에서 제공하는 정보
비회원 필수항목: 주문자 이름, 주문 결제자 주소, 수취인 이름, 배송지 정보, 연락처, 고객메모
부가항목: 주문자 이름, 주문 결제자 주소, 수취인 이름, 배송지 정보, 연락처, 환불요청 시 환불계좌번호
다만, 서비스 이용과정에서 서비스 이용기록, 접속 로그, 쿠키, 접속 IP 정보, 결제기록 등이 생성되어 수집될 수 있습니다.
나. 수집방법: 쇼핑몰 회원가입 시의 회원가입 정보 및 고객센터를 통한 전화 및 온라인 상담

 

[개인정보 수집이용 목적]

회사의 개인정보 수집 목적은 최적화된 맞춤화 서비스를 제공하기 위함이며, 회사는 서비스 제공을 원활하게 하기 위해 필요한 최소한의 정보만을 수집하고 있습니다.
서비스 이용에 따른 대금결제, 물품배송 및 환불 등에 필요한 정보를 추가로 수집할 수 있습니다.
회사는 개인정보를 수집, 이용목적 이외에 다른 용도로 이용하거나 회원의 동의 없이 제3자에게 이를 제공하지 않습니다.

 

[개인정보 보유 및 이용기간]

회사는 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 개인정보를 지체 없이 파기합니다.
단, 관계법령의 규정에 의하여 보존할 필요가 있는 경우 회사는 아래와 같이 관계법령에서 정한 일정한 기간 동안 회원 개인정보를 보관합니다.

가. 상법 등 법령에 따라 보존할 필요성이 있는 경우

① 표시 • 광고에 관한 기록
보존근거: 전자상거래 등에서의 소비자보호에 관한 법률
보존기간: 6개월

② 계약 또는 청약철회 등에 관한 기록
보존근거: 전자상거래 등에서의 소비자보호에 관한 법률
보존기간: 5년

③ 대금결제 및 재화 등의 공급에 관한 기록
보존근거: 전자상거래 등에서의 소비자보호에 관한 법률
보존기간: 5년

④ 소비자의 불만 또는 분쟁처리에 관한 기록
보존근거: 전자상거래 등에서의 소비자보호에 관한 법률
보존기간: 3년

⑤ 신용정보의 수집, 처리 및 이용 등에 관한 기록
보존근거: 신용정보의 이용 및 보호에 관한 법률
보존기간: 3년

⑥ 본인확인에 관한 기록보존
보존근거: 정보통신망 이용촉진 및 정보보호에 관한 법률 제44조의5 및 시행령 제29조
보존기간: 6개월

⑦ 접속에 관한 기록보존
보존근거: 통신비밀보호법 제15조의2 및 시행령 제41조
보존기간: 3개월

나. 기타, 회원의 개별적인 동의가 있는 경우에는 개별 동의에 따른 기간까지 보관합니다.

 

[개인정보 제3자 제공]

가. 회사는 회원들의 개인정보를 개인정보의 수집이용 목적에서 고지한 범위 내에서 사용하며, 회원의 사전 동의 없이 동 범위를 초과하여 이용하거나 원칙적으로 회원의 개인정보를 제 3자에게 제공하지 않습니다. 단, 아래의 경우에는 예외로 합니다.
① 회원들이 사전에 공개 또는 제3자 제공에 동의한 경우
② 법령의 규정에 의거하나, 수사, 조사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관 및 감독 당국의 요구가 있는 경우

나. 회사가 제공하는 서비스를 통하여 주문 및 결제가 이루어진 경우, 상담 등 거래 당사자간 원활한 의사소통 및 배송 등 거래이행을 위하여 관련된 정보를 필요한 범위 내에서 거래 당사자에게 제공합니다.
① CJ대한통운 택배사: 주문자 이름, 수취인 이름 배송지 정보, 연락처
그 밖에 개인정보 제3자 제공이 필요한 경우에는 합당한 절차를 통한 회원의 동의를 얻어 제3자에게 개인정보를 제공할 수 있습니다.
							</textarea>


						</div>
					</div>
					<div class="row mt-2 mb-2">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">
							주문동의</div>
						<div class="col-lg-10 col-9">
							<input type="checkbox" id="TermsAccept">상기 결제정보를 확인하였으며,
							구매 진행에 동의합니다.
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 최종 결제 금액 -->
        <div class="finalAmount p-4 d-flex">
            <div class="col-lg-2 col-3 d-flex justify-content-center align-items-center">
                <span>최종결제 금액</span>
            </div>
            <div class="col-lg-10 col-3 d-flex justify-content-start align-items-center">
            	<c:choose>
	            	<c:when test="${totalPrice > 50000}">
	            		<span>${totalPrice} 원</span>
					</c:when>
					<c:otherwise>
						<span>${totalPrice + 3000} 원</span>
					</c:otherwise>
				</c:choose>
            </div>
        </div>
		<!-- 버튼 -->
		<div class="btnBox d-flex justify-content-center">
			<button type="button" class="btn btn-outline-dark" id="btnCancel">취소하기</button>
			<button type="button" class="btn btn-outline-success" id="btnOrder">주문하기</button>
		</div>
		<%--풋터영역 --%>
		<jsp:include page="/frame/footer.jsp"></jsp:include>
	</div>



	<script>
		// 휴대폰 번호 셋팅
		let phone = "${loginSession.phone}";
		let phone1 = phone.slice(0, 3);
		let phone2 = phone.slice(3, 7);
		let phone3 = phone.slice(7);

		// 셀렉트 박스에 default selected값 주기
		$("#order_phone1").val(phone1);
		$("#order_phone2").val(phone2);
		$("#order_phone3").val(phone3);

		// ckBox활성화시 정보 가져오기
		let name = "${loginSession.username}";

		$("#ckBox").click(function() {
			if ($("#ckBox").is(":checked") == true) {

				$("#delivery_name").val(name);
				$("#phone1").val(phone1);
				$("#phone2").val(phone2);
				$("#phone3").val(phone3);
				return;
			}

			if ($("#ckBox").is(":checked") == false) {

				$("#delivery_name").val("");
				$("#phone1").val("");
				$("#phone2").val("");
				$("#phone3").val("");
				return;
			}

		});
		
	// 주문 취소하기
	$("#btnCancel").on("click", function() {
		let ans = confirm("구매를 취소하시겠습니까?")
		if(ans) {
			location.href = "/main";
		}
	})
		
	// 주문하기 버튼 - 주문서 유효성 검사
	$("#btnOrder").on("click", function() {
		if($("#order_name").val() == ""){
			alert("주문자명을 적어주세요");
			$("#order_name").focus();
			return;
		} else if($("#order_phone").val() == "") {
			alert("주문자 연락처를 적어주세요");
			$("#order_phone").focus();
			return;
		} else if($("#order_email").val() == "") {
			alert("주문자 이메일을 적어주세요");
			$("#order_email").focus();
			return;
		} else if($("#delivery_name").val() == "") {
			alert("배송자명을 적어주세요");
			$("#delivery_name").focus();
			return;
		} else if($("#delivery_phone").val() == "") {
			alert("배송 연락처를 적어주세요");
			$("#phone").focus();
			return;
		} else if($("#postcode").val() == "") {
			alert("검색된 배송지가 없습니다. 배송지를 등록하세요");
			$("#postcode").focus();
			return;
		} else if($("#TermsAccept").is(":checked") == false) {
			alert("구매 약관에 동의해주세요");
			$("#TermsAccept").focus();
			return;
		}
		
		IMP.init("imp86984194");
		
		// 금액에 따라 배송비를 더하는 로직
	/* 	let totalPrice = 0;
		if(${totalPrice > 50000}) {
			totalPrice = ${totalPrice}
		} else {
			totalPrice = ${totalPrice + 3000}
		} */
		
		// 실제 결제를 진행하기 전에 금액 검증
		let totalPrice = parseInt(payValidation("${loginSession.user_id}", ${totalPrice}));
		
		// 실제 결제와 주문서 생성을 검증
		IMP.init("imp86984194");
		requestPay(orderNO(), $("#itemName").html() + "외 " + ${fn:length(cartList)} + "개", 100, $("#order_email").val(), $("#delivery_name").val(), $("#delivery_phone").val(), $("#delivery_addr").val(), $("#postcode").val());

	});

		// 아임포트 결제 모듈 실행
		function requestPay(order_no, name, amount, buyer_email, buyer_name,
				buyer_tel, buyer_addr, buyer_postcode) {
			buyer_addr = $("#delivery_addr").val()
					+ $("#delivery_detail").val();
			buyer_phone = $("#phone1").val() + $("#phone2").val()
					+ $("#phone3").val();

			console.log($("#order_email").val());
			console.log($("#delivery_name").val());
			console.log(buyer_phone);
			console.log($("#delivery_addr").val());
			console.log($("#postcode").val())

			// IMP.request_pay(param, callback) 결제창 호출
			IMP.request_pay({ // param
				pg : "html5_inicis",
				pay_method : "card",
				merchant_uid : order_no,
				name : name,
				amount : amount,
				buyer_email : buyer_email,
				buyer_name : buyer_name,
				buyer_tel : buyer_phone,
				buyer_addr : buyer_addr,
				buyer_postcode : buyer_postcode
			}, function(rsp) { // callback
				console.log(rsp);

				if (rsp.success) {
					// 결제 성공 시 로직,
					console.log("success");
					requestOrder(order_no);
				} else {
					// 결제 실패 시 로직,
					alert("결제 과정에서 오류가 발생했습니다. 다시 시도해주세요.")
					console.log("fail!");
				}
			});
		}

		// 주문번호 생성하는 함수
		function orderNO() {
			let today = new Date();
			let year = (today.getFullYear()).toString();
			let date = today.getDate();
			let month = today.getMonth() + 1;
			if (month < 10) {
				month = "0" + month;
	      	}
			if (date < 10) {
				date = "0" + (date + 1);
			}
			let orderNo = year + month + date + Math.floor(Math.random()*(9000)) + 1;
			
			return orderNo;
		}
	
	// 주문서 정보 ajax로 전달하기
	function requestOrder(order_no) {
		let buyer_addr = "(" + $("#postcode").val() + ") " + $("#delivery_addr").val() + ", " + $("#delivery_detail").val()
		let order_phone = $("#order_phone1").val() + $("#order_phone2").val() + $("#order_phone3").val();
		let buyer_phone = $("#phone1").val() + $("#phone2").val() + $("#phone3").val();
		
		$.ajax({
			url:"/complete.order"
			, type:"post"
			, data: {
				order_no: order_no.toString()
				, order_name: $("#order_name").val()
				, order_email: $("#order_email").val()
				, order_phone: order_phone
				, delivery_name: $("#delivery_name").val()
				, delivery_phone: buyer_phone
				, delivery_addr: buyer_addr
				, order_msg: $("#order_msg").val()
				, delivery_msg: $("#delivery_msg").val()
			}
			, success: function(data) {
				location.href = "/success.order?order_no=" + order_no;
			}
			, error: function(e) {
				console.log(e);
			}
		});
		return orderNo;
	}
	
	// 최종금액과 실제 DB에 있는 금액을 비교해서 검증하는 작업
	function payValidation(user_id, totalPrice) {
		let resultPrice;
		$.ajax({
			url:"/orderValidation.order"
			, type:"post"
			, data: {
				user_id : user_id
				, totalPrice: totalPrice
			}
			, async: false
			, success: function(data) {
				if(data == "-1") {
					alert("결제 검증과정에서 문제가 생겼습니다. 결제를 다시 시도하세요");
					return;
				}
				resultPrice = data;
			}
			, error: function(e) {
				console.log(e);
			}
		});
		return resultPrice;
	}
	
	// 우편번호 API
	$("#btnPostcode").on("click", function () {
		new daum.Postcode({
	  	theme: {
	          searchBgColor: "#7CC09C", //검색창 배경색
	          queryTextColor: "#FFFFFF" //검색창 글자색
	      }
	      , oncomplete: function(data) {
	
	          // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	          // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	          // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	          var roadAddr = data.roadAddress; // 도로명 주소 변수
	          var extraRoadAddr = ''; // 참고 항목 변수
	
	          // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	          // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	          if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	              extraRoadAddr += data.bname;
	          }
	          // 건물명이 있고, 공동주택일 경우 추가한다.
	          if(data.buildingName !== '' && data.apartment === 'Y'){
	             extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	          }
	          // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	          if(extraRoadAddr !== ''){
	              extraRoadAddr = ' (' + extraRoadAddr + ')';
	          }
	
	          // 우편번호와 주소 정보를 해당 필드에 넣는다.
	          document.getElementById('postcode').value = data.zonecode;
	          document.getElementById('delivery_addr').value = roadAddr;
	      }
	  }).open();
	});
	</script>
</body>
</html>