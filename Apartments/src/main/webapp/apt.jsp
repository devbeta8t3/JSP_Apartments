<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String sessionId = (String) session.getAttribute("sessionId");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    
	<!-- Custom styles for this template -->
    <link href="dashboard.css" rel="stylesheet">
    
    
    <!-- Javascript -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript">
		var xhrObject; // XMLhttpRequest객체를 저장할 변수, 전역변수선언
		let doValue;
		let siValue;
		let dongValue;
		let aptValue;
		
		function createXHR() {
			if(window.ActiveXObject) { // 웹브라우저가 IE5.0, 6.0인경우
				xhrObject = new ActiveXObject("Microsoft.XMLHTTP"); // XMLHttpRequest 객체 생성
			}
			else if(window.XMLHttpRequest) { // IE7.0, Firefox, safari, opera ..etc
				xhrObject = new XMLHttpRequest();
			}
		}
		
		/* 시군구 이름을 가져오는 함수 */
		function getSiData(doName) {	//json 요청
			doValue = doName;
			//const doName = document.getElementById("doSelect");	//시도명을 가져와서 저장 but, object HTMLSelectElement로 넘어옴.
			//const doName = doSelect.options[doSelect.selectedIndex].value;
			
			createXHR(); // createXHR() 메소드 호출
			
			const url = "./siDB.jsp"; //요청 url 설정(시군구 db)
			
			const reqparam = "시도명=" +doName;	// 요청 파라미터 설정: 시도명
			xhrObject.onreadystatechange = resGetSiData; // 다되면 실행할 함수 등록(호출 아님. 역호출)
			xhrObject.open("Post", url, "true"); //서버의 요청설정 -url변수에 설정된 리소스를 요청할 준비
			xhrObject.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
			xhrObject.send(reqparam);
		}
		
		/* json 형식으로 만들어진 시군구db에서 시군구명을 가져오고 html에 쓰기(select-option) */
		function resGetSiData() {
			if(xhrObject.readyState == 4) {
				if(xhrObject.status == 200) {
					//alert("2");	// 상태 확인
					
					const result = xhrObject.responseText;
	 				//alert(result);	// 결과값 확인
					
	 				const objRes = eval("("+result+")");
	 				//alert(objRes);	// 객체 확인
					
	 				const num = objRes.datas.length;	// num : 배열의 길이
	 				let res = "<option selected value=''>시/군/구를 선택하세요.</option>";
					
					if(num<1) {
						res += "<option>데이타가 없습니다.</option>";
					}
					else {
						for(let i=0; i<num; i++) {
							//const dongCode = objRes.datas[i].법정동코드;
							const siName = objRes.datas[i].시군구명;
							//const user_id = objRes.datas[i].ID;
							//const user_name = objRes.datas[i].NAME;
							//const user_phone = objRes.datas[i].PHONE;
							//const user_grade = objRes.datas[i].GRADE;
							//const user_time = objRes.datas[i].WRITE_TIME;
							res +="<option value='"+siName+"'>"+siName+"</option>";
							//res +="<tr class='table-active'>";
							//res +="<td>"+user_id+"</td>";
							//res +="<td><br>"+user_name+"<br></td>";
							//res +="<td><br>"+user_phone+"<br></td>";
							//res +="<td><br>"+user_grade+"<br></td>";
							//res +="<td><br>"+user_time+"<br></td>";
							//res +="</tr>";
						}
					}
					//res += "</table>";
					
					//alert(res);
					document.getElementById("siSelect").innerHTML = res;
					document.getElementById("selectedDo").innerHTML = doValue; 
				}
			}
		}
		
		/* 읍면동 이름을 가져오는 함수 */
		function getDongData(siName) {	//json 요청
			siValue = siName; 
			//const doName = document.getElementById("doSelect").value;	//시도명을 가져와서 저장 but, object HTMLSelectElement로 넘어옴.
			//const siName = siSelect.options[siSelect.selectedIndex].value;
			
			createXHR(); // createXHR() 메소드 호출
			
			const url = "./dongDB.jsp"; //요청 url 설정(읍면동 db)
			
			const reqparam = "시군구명=" +siName+ "&시도명=" +doValue;	// 요청 파라미터 설정: 시군구명, 시도명
			xhrObject.onreadystatechange = resGetDongData; // 다되면 실행할 함수 등록(호출 아님. 역호출)
			xhrObject.open("Post", url, "true"); //서버의 요청설정 -url변수에 설정된 리소스를 요청할 준비
			xhrObject.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
			xhrObject.send(reqparam);
		}
		
		/* json 형식으로 만들어진 시군구db에서 시군구명을 가져오고 html에 쓰기(select-option) */
		function resGetDongData() {
			if(xhrObject.readyState == 4) {
				if(xhrObject.status == 200) {
					//alert("2");	// 상태 확인
					
					const result = xhrObject.responseText;
	 				//alert(result);	// 결과값 확인
					
	 				const objRes = eval("("+result+")");
	 				//alert(objRes);	// 객체 확인
					
	 				const num = objRes.datas.length;	// num : 배열의 길이
	 				let res = "<option selected value=''>읍/면/동을 선택하세요.</option>";
					
					if(num<1) {
						res += "<option>데이타가 없습니다.</option>";
					}
					else {
						for(let i=0; i<num; i++) {
							const dongCode = objRes.datas[i].법정동코드;
							const dongName = objRes.datas[i].읍면동명;
							//const user_id = objRes.datas[i].ID;
							//const user_name = objRes.datas[i].NAME;
							//const user_phone = objRes.datas[i].PHONE;
							//const user_grade = objRes.datas[i].GRADE;
							//const user_time = objRes.datas[i].WRITE_TIME;
							res +="<option value='"+dongCode+"'>"+dongName+"</option>";
							//res +="<tr class='table-active'>";
							//res +="<td>"+user_id+"</td>";
							//res +="<td><br>"+user_name+"<br></td>";
							//res +="<td><br>"+user_phone+"<br></td>";
							//res +="<td><br>"+user_grade+"<br></td>";
							//res +="<td><br>"+user_time+"<br></td>";
							//res +="</tr>";
						}
					}
					//res += "</table>";
					
					//alert(res);
					document.getElementById("dongSelect").innerHTML = res;
					document.getElementById("selectedSi").innerHTML = "-" +siValue ;

				}
			}
		}
		
		// 동 선택시 (select option value 값으로) 아파트 리스트 출력하는 함수 - ajax 사용
		$(function() {
			$('#dongSelect').on("change", function() {
				dongValue = $('#dongSelect option:selected').text();
				// alert(dongValue); 	// 동이름 확인 (완료)
				let bjdCode = $(this).val();	// 동 선택시 value(법정동코드)를 저장
				const key = "SsuVC2eM0t4fh8sGbUPY4DPOtZDBa4o41nCmhRT6pMn2vl%2BSqtlnLsdmzCwdPBA35zxuFbhlcOy43R4X3ZffQA%3D%3D"; 
					
				$.ajax({
					url : "http://apis.data.go.kr/1613000/AptListService2/getLegaldongAptList",	// 요청 주소
					data : "bjdCode="+bjdCode+"&numOfRows=30&ServiceKey="+key,	//요청 파라미터
					type : "GET", //전송타입
					dataType : "xml", //응답타입
					success : function(result) {	//통신 성공시 호출하는 함수
						//alert("동선택 요청에 의한 응답값 : " +result);	// [object XMLDocument]로 넘어온거 확인 (완료)
						//$('#selectedDong').html("-동이름왜안붙어");	//****************************************************** todo
						//alert('동이름 붙었나?');	// 
						xmlParsing(result);	// 가독성 위해 따로 작성
					},
					error : function(xhr, status, msg) {	// 통신 실패시 호출하는 함수
						alert('Getting data from server has failed.');
						//console.log("error : ", msg);
						//console.log("status : ", status);
					}
				});
				
				/* XML 파싱(parsing) */
				function xmlParsing(data) {
					//alert("동선택->아파트리스트 파싱 함수로 넘어온 데이터 : " +data);	// [object XMLDocument]로 넘어온거 확인 (완료)	
					let aptList = "";
					
					$(data).find("item").each(function(){	// item 태그 단위로 각각 아래 내용을 실행
						//alert($(this).find('kaptName').text());	// 아파트 목록 넘어오는거 확인 (완료)
						//infoList = "<tr><td>"+$(this).find('kaptName').text()+"</td><td>"+$(this).find('kaptCode').text()+"</td><td>"+$(this).find('bjdCode').text()+"</td></tr>";
						aptList += "<a href='#' value='"+$(this).find('kaptCode').text()+"' class='list-group-item list-group-item-action border-success'>"+$(this).find('kaptName').text()+"</a>";
						//aptList += "<li value='"+$(this).find('kaptCode').text()+"'>"+$(this).find('kaptName').text()+"</li>";
						
					});
					$('#aptListShown').empty().append(aptList);	// id가 aptListShown인 영역에 aptList 내용 추가
					//$('tr:first').css('background', 'darkgray').css('color', 'white'); // 동작 확인 (완료)
					
				}
			});
		});
		
		// 아파트 선택시 상세 정보 출력하는 함수 - ajax 사용
		$(function() {
			//$('#aptListShown').on("click", 'a', function() {	// 해당 문법은 dynamically created elements에서 동작하지 않는다? https://stackoverflow.com/questions/32780644/selector-to-click-on-div-loaded-with-ajax-jquery
			$(document).on('click', '#aptListShown a', function(){	// 값 넘어옴 (완료) ************************************* toto 이거 공부하기
					
				alert('aptlist->클릭 인식'); 	// 아파트 이름 확인 (완료)
				//let kaptCode = $(this).val();	// 아파트 선택시 value(아파트코드)를 저장	// 값 안넘어옴
				let kaptCode = $(this).attr('value');	// 값 넘어옴 (완료) *********************************************** todo 이거 공부하기 val() VS attr('value')
				alert('클릭한 아파트의 value(kaptCode) : '+kaptCode)	
				const key = "SsuVC2eM0t4fh8sGbUPY4DPOtZDBa4o41nCmhRT6pMn2vl%2BSqtlnLsdmzCwdPBA35zxuFbhlcOy43R4X3ZffQA%3D%3D"; 
					
				$.ajax({
					url : "http://apis.data.go.kr/1613000/AptBasisInfoService1/getAphusDtlInfo",	// 요청 주소
					data : "kaptCode="+kaptCode+"&ServiceKey="+key,	//요청 파라미터
					type : "GET", //전송타입
					dataType : "xml", //응답타입
					success : function(result) {	//통신 성공시 호출하는 함수
						//alert("요청에 의한 응답 성공 값 : " +result);	// [object XMLDocument]로 넘어온거 확인 (완료)
						xmlInfoParsing(result);	// 가독성 위해 따로 작성
					},
					error : function(xhr, status, msg) {	// 통신 실패시 호출하는 함수
						alert('Getting data from server has failed.');
						//console.log("error : ", msg);
						//console.log("status : ", status);
					}
				});
				
				/* XML 파싱(parsing) */
				function xmlInfoParsing(data) {
					//alert("Info 파싱 함수로 넘어온 데이터 : " +data);	// [object XMLDocument]로 넘어온거 확인 (완료)	
					
					//$(data).find("item").each(function(){	// item 태그 단위로 각각 아래 내용을 실행
						//alert($(this).find('kaptName').text());	// 아파트 목록 넘어오는거 확인 (완료)
						//infoList = "<tr><td>"+$(this).find('kaptName').text()+"</td><td>"+$(this).find('kaptCode').text()+"</td><td>"+$(this).find('bjdCode').text()+"</td></tr>";
						//aptList += "<a href='#' value='"+$(this).find('kaptCode').text()+"' class='list-group-item list-group-item-action border-success'>"+$(this).find('kaptName').text()+"</a>";
						
					//});
					
					let apartName = $(data).find('kaptName').text();		// 단지명
					alert("파싱한 단지명(kaptName) 값 : " +apartName);	// 파싱되는지 확인
					aptValue = apartName; // 전역변수에 저장
					let mgr = $(data).find('codeMgr').text();				// 관리 방식
					let mgrCnt = $(data).find('kaptMgrCnt').text();			// 관리 인원
					let mgrCompany = $(data).find('kaptCcompany').text();	// 관리 계약업체
					
					let sec = $(data).find('codeSec').text();				// 경비관리 방식
					let secCnt = $(data).find('kaptdScnt').text();			// 경비관리 인원
					let secCompany = $(data).find('kaptdSecCom').text();	// 경비관리 계약업체
					
					let clean = $(data).find('codeClean').text();			// 청소관리 방식
					let cleanCnt = $(data).find('kaptdClcnt').text();		// 청소관리 인원
					
					let waterSupply = $(data).find('codeWsupply').text();	// 급수 방식
					let gabage = $(data).find('codeGarbage').text();		// 음식물 처리 방법
					
					let parkCnt = $(data).find('kaptdPcnt').text();			// 주차대수(지상)
					let parkCntu = $(data).find('kaptdPcntu').text();		// 주차대수(지하)
					let net = $(data).find('codeNet').text();				// 주차관제.홈네트워크
					let elevCnt = $(data).find('kaptdEcnt').text();			// 승강기 대수
					let cctvCnt = $(data).find('kaptdCccnt').text();		// cctv 카메라 수
					
					let walfFac = $(data).find('welfareFacility').text();	// 부대시설 및 복리시설
					let walkTimeBus = $(data).find('kaptdWtimebus').text();	// 버스정류장 도보 거리
					let subwayLine = $(data).find('subwayLine').text();			// 지하철 호선
					let subwayStation = $(data).find('subwayStation').text();	// 지하철 역명
					let walkTimeSub = $(data).find('kaptdWtimesub').text();		// 지하철 도보 거리
					
					let convFac = $(data).find('convenientFacility').text();	// 주변 편의시설
					let eduFac = $(data).find('educationFacility').text();		// 주변 교육시설
					
					/* 본문 내용 삽입 */
					$('#apartName').empty().append(apartName);	// 아파트 이름 삽입
					
					$('#mgr').empty().append(mgr);					// 관리 방식 추가
					$('#mgrCnt').empty().append(mgrCnt);			// 관리 인원 추가
					$('#mgrCompany').empty().append(mgrCompany);	// 관리 계약업체 추가
					
					$('#sec').empty().append(sec);					// 경비관리 방식 추가
					$('#secCnt').empty().append(secCnt);			// 경비관리 인원 추가
					$('#secCompany').empty().append(secCompany);	// 경비관리 계약업체 추가
					
					$('#clean').empty().append(clean);				// 청소관리 방식 추가
					$('#cleanCnt').empty().append(cleanCnt);		// 청소관리 인원 추가
					
					$('#parkCnt').empty().append(parkCnt);			// 주차대수(지상) 추가
					$('#parkCntu').empty().append(parkCntu);		// 주차대수(지하) 추가
					$('#net').empty().append(net);					// 주차관제.홈네트워크 추가
					$('#elevCnt').empty().append(elevCnt);			// 승강기 대수 추가
					$('#cctvCnt').empty().append(cctvCnt);			// cctv 카메라 수 추가
					
					$('#walfFac').empty().append(walfFac);			// 부대시설 및 복리시설 추가
					$('#waterSupply').empty().append(waterSupply);	// 급수 방식 추가
					$('#gabage').empty().append(gabage);			// 음식물 처리 방법 추가
					
					$('#walkTimeBus').empty().append(walkTimeBus);		// 버스정류장 도보 거리 추가
					$('#subwayLine').empty().append(subwayLine);		// 지하철 호선 추가
					$('#subwayStation').empty().append(subwayStation);	// 지하철 역명 추가
					$('#walkTimeSub').empty().append(walkTimeSub);		// 지하철 도보 거리 추가
					
					$('#convFac').empty().append(convFac);	// 편의시설 추가
					$('#eduFac').empty().append(eduFac);	// 교육시설 추가
					
				}
			});
		});
		
		/* 동이름+아파트이름으로 네이버 지도에 단순 검색하여 새창에 띄움 */
		function searchNaverMap() {
			//alert('새창띄우기 함수'+dongValue+' '+aptValue);	// 동이름, 아파트이름 확인 (완료)
			if (dongValue!=undefined && aptValue!=undefined)	// 예외처리(아파트 미선택시 경고창)
				window.open("https://map.naver.com/v5/search/"+dongValue+" "+aptValue, '_blank');
			else
				alert('아파트가 선택되지 않았습니다.\n ( Need to select a apartment. )');
		}
		
	</script>
        
    <title>Apartments - Find your best apartment!</title>
</head>

<body>

<!-- Upper Navbar -->
<div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-dark border-bottom shadow-sm sticky-top">
	<h3 class="my-0 mr-md-auto font-weight-bold text-light">Apartments</h3>
	<h6 class="my-0 mr-md-auto text-light font-italic"> Find your best apartment!</h6>
	<nav class="my-2 my-md-0 mr-md-3">
		<a class="p-2 text-light" href="apt.jsp">아파트 찾기</a>
		<a class="p-2 text-light mr-3" href="board.jsp">질문 게시판</a>
		<c:choose>
			<c:when test="${empty sessionId}">
				<!-- 로그인 아닐때 보여지는 메뉴 -->
 				<a class="btn btn-primary mr-2" href="memberLogin.jsp">Log in</a>
 				<a class="btn btn-danger" href="memberSignup.jsp">Sign up</a>
			</c:when>
			<c:otherwise>
				<!-- 로그인 시 보여지는 메뉴 : if sessionId != null 로 처리하자 -->
				<a class="p-2 text-light" href="#">[<%= sessionId %>]님 접속중!</a>
				<a class="p-2 text-light mr-2" href="memberUpdate.jsp">회원정보</a>
				<a class="btn btn-warning" href="memberLogout.jsp">Log out</a>
			</c:otherwise>
		</c:choose>
	</nav>
</div>

<!-- Middle Section -->
<div class="container-fluid">
	<div class="row">
		<!-- Location selectBar -->
		<div class="col-sm-12 col-md-6 col-lg-2 bg-light px-1">
			<form>
				<div class="form-group">
					<button type="button" class="btn btn-warning btn-lg btn-block mt-1 mb-1 font-weight-bold">Select Location</button>
					<div class="card border-warning mb-3" style="max-width: 20rem;">
						<div class="card-header text-center">지역을 선택하세요.</div>
						  <div class="card-body">
						  	<p>
						   	<label for="doSelect" class="form-label mt-4"><span class="badge badge-pill badge-warning">광역지자체</span></label><br/>
							<select class="form-select" id="doSelect" onchange="getSiData(this.value)">
								<option value="">특별시/광역시/자치시/도</option>
								<optgroup label="특별시/광역시/자치시">
									<option value="서울특별시">서울특별시</option>
									<option value="부산광역시">부산광역시</option>
									<option value="대구광역시">대구광역시</option>
									<option value="인천광역시">인천광역시</option>
									<option value="광주광역시">광주광역시</option>
									<option value="대전광역시">대전광역시</option>
									<option value="울산광역시">울산광역시</option>
									<option value="세종특별자치시">세종특별자치시</option>
								</optgroup>
								<optgroup label="도/자치도">
									<option value="경기도">경기도</option>
									<option value="강원도">강원도</option>
									<option value="충청북도">충청북도</option>
									<option value="충청남도">충청남도</option>
									<option value="전라북도">전라북도</option>
									<option value="전라남도">전라남도</option>
									<option value="경상북도">경상북도</option>
									<option value="경상남도">경상남도</option>
									<option value="제주특별자치도">제주특별자치도</option>
								</optgroup>
							</select>
							<!-- 시군구 선택(자동) -->
							<p>
							<label for="siSelect" class="form-label mt-4"><span class="badge badge-pill badge-warning">시/군/구</span></label><br/>
							<select class="form-select" id="siSelect" onchange="getDongData(this.value)"></select>
							<!-- 읍면동 선택(자동) -->
							<p>
							<label for="dongSelect" class="form-label mt-4"><span class="badge badge-pill badge-warning">읍면동</span></label><br/>
							<select class="form-select" id="dongSelect" ></select>
						  </div>
					</div>
				</div> 
			</form>		
		
		</div>
		
		<!-- Apt List Bar -->
		<div class="col-sm-12 col-md-6 col-lg-2 bg-light px-1">
			<button type="button" class="btn btn-success btn-lg btn-block mt-1 mb-1 font-weight-bold">Apartment List</button>
			<!-- 아파트 리스트 삽입 (AJAX) -->
			<div class="list-group" id="aptListShown">
				<img src="apartment1.png" class="mt-5" />
			</div>
		</div>
		
		<!-- Apt Contents -->
		<div class="col-sm-12 col-md-12 col-lg-8 bg-light px-1">
			<button type="button" class="btn btn-secondary btn-lg mt-1 mb-1 font-weight-bold active">Apartment Infomation</button>
			<div class="card border-secondary">
			  <div class="card-body">
			    <h4 class="card-title">
			    	<span id="apartName" class="font-weight-bold mr-3">아파트명</span>
			    	<button class="btn btn-sm btn-success" onclick="searchNaverMap();"><span class="h6 font-weight-bold">N</span> 네이버 지도 검색 <img src="openNewWindowWhite.png" style="width:17px"></button>
			    </h4><hr/>
			    <!-- <h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6> -->
			    
			    <div class="row justify-content-around">
			    	<div class="col-sm-6 col-md-4 col-lg-3">
			    		<div class="card bg-light mb-3 mx-auto" style="max-width: 15rem;">
						  <div class="card-header font-weight-bold">아파트 일반관리</div>
						  <div class="card-body">
						    <!-- <h4 class="card-title">Light card title</h4> -->
						    <p class="card-text"><span class="badge bg-primary text-white mr-2">관리 방식</span><span id="mgr"></span></p>
							<p class="card-text"><span class="badge bg-primary text-white mr-2">관리 인원</span><span id="mgrCnt"></span></p>
							<p class="card-text"><span class="badge bg-primary text-white mr-2">관리 업체</span><span id="mgrCompany"></span></p>
						  </div>
						</div>
			    	</div>
			    	<div class="col-sm-6 col-md-4 col-lg-3">
			    		<div class="card bg-light mb-3 mx-auto" style="max-width: 15rem;">
						  <div class="card-header font-weight-bold">아파트 경비관리</div>
						  <div class="card-body">
						    <!-- <h4 class="card-title">Light card title</h4> -->
						    <p class="card-text"><span class="badge bg-dark text-white mr-2">경비 방식</span><span id="sec"></span></p>
							<p class="card-text"><span class="badge bg-dark text-white mr-2">경비 인원</span><span id="secCnt"></span></p>
							<p class="card-text"><span class="badge bg-dark text-white mr-2">경비 업체</span><span id="secCompany"></span></p>
						  </div>
						</div>
			    	</div>
			    	<div class="col-sm-6 col-md-4 col-lg-3">
						<div class="card bg-light mb-3 mx-auto" style="max-width: 15rem;">
						  <div class="card-header font-weight-bold">아파트 청소관리</div>
						  <div class="card-body">
						    <p class="card-text"><span class="badge bg-success text-white mr-2">청소 방식</span><span id="clean"></span></p>
							<p class="card-text"><span class="badge bg-success text-white mr-2">청소 인원</span><span id="cleanCnt"></span></p>
						  </div>
						</div>
					</div>
			    	<div class="col-sm-6 col-md-4 col-lg-3">
						<div class="card bg-light mb-3 mx-auto" style="max-width: 15rem;">
						  <div class="card-header font-weight-bold">주차/승강기/CCTV</div>
						  <div class="card-body">
						    <p class="card-text"><span class="badge bg-warning mr-2">주차 대수(지상)</span><span id="parkCnt"></span></p>
							<p class="card-text"><span class="badge bg-warning mr-2">주차 대수(지하)</span><span id="parkCntu"></span></p>
							<p class="card-text"><span class="badge bg-warning mr-2">주차관제/홈네트워크</span><span id="net"></span></p>
							<p class="card-text"><span class="badge bg-warning mr-2">승강기 대수</span><span id="elevCnt"></span></p>
							<p class="card-text"><span class="badge bg-warning mr-2">CCTV 카메라 대수</span><span id="cctvCnt"></span></p>
						  </div>
						</div>
					</div>
			    	<div class="col-sm-6 col-md-4 col-lg-4">
						<div class="card bg-light mb-3" style="max-width: 20rem;">
						  <div class="card-header font-weight-bold">부대복리시설/기타</div>
						  <div class="card-body">
						    <p class="card-text"><span class="badge bg-info text-white mr-2">부대/복리시설</span><span id="walfFac"></span></p>
							<p class="card-text"><span class="badge bg-info text-white mr-2">급수 방식</span><span id="waterSupply"></span></p>
							<p class="card-text"><span class="badge bg-info text-white mr-2">음식물 처리</span><span id="gabage"></span></p>
						  </div>
						</div>
					</div>
			    	<div class="col-sm-6 col-md-4 col-lg-4">
						<div class="card border-danger mb-3 mx-auto" style="max-width: 20rem;">
						  <div class="card-header font-weight-bold">대중교통</div>
						  <div class="card-body">
						    <p class="card-text"><span class="badge bg-danger text-white mr-2">버스정류장 도보거리</span><span id="walkTimeBus"></span></p>
							<p class="card-text"><span class="badge bg-danger text-white mr-2">지하철 호선</span><span id="subwayLine"></span></p>
							<p class="card-text"><span class="badge bg-danger text-white mr-2">지하철 역명</span><span id="subwayStation"></span></p>
							<p class="card-text"><span class="badge bg-danger text-white mr-2">지하철 도보거리</span><span id="walkTimeSub"></span></p>
						  </div>
						</div>
					</div>
			    	<div class="col-sm-6 col-md-4 col-lg-4">
						<div class="card border-primary mb-3 mx-auto" style="max-width: 20rem;">
						  <div class="card-header font-weight-bold">주변 환경</div>
						  <div class="card-body">
						    <p class="card-text"><span class="badge bg-primary text-white mr-2">편의시설</span><span id="convFac"></span></p>
							<p class="card-text"><span class="badge bg-primary text-white mr-2">교육시설</span><span id="eduFac"></span></p>
						  </div>
						</div>
					</div>
			    </div>
			  </div>
			</div>
		</div>
	</div>
</div>

	<!-- Footer -->
    <footer>

    </footer>
   
</body>
</html>