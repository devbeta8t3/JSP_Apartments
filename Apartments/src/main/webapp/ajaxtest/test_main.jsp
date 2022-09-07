<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

<title>style test</title>

<script language="JavaScript" type="text/javascript">
	
	let xhrObject;	//XMLHttpRequest 객체를 저장할 변수를 전역변수로 선언
	
	function createXHR(){	//XMLHttpRequest 객체를 생성하는 메소드
		if (window.ActiveXObject){
			xhrObject = new ActiveXObject("Microsoft.XHLHTTP");
		}
		else if (window.XMLHttpRequest){
			xhrObject = new XMLHttpRequest();	//XMLHttpRequest 객체 생성 
		}
	}
	
	function getData(){
		
		let form_name = "form_main";
		let user_id = document.forms[form_name].elements["txt_user_id"].value;
		
		createXHR();	//createXHR() 메소드 호출 : 객체 생성
		
		let url = "./testFile.jsp";	//요청 url 설정
		//let url = "./getUserInfo.jsp"; //요청 url 설정
		let reqparam = "user_id=" + user_id;
		
		xhrObject.onreadystatechange = resGetData;	//응답결과를 처리메소드인 resGetData()메소드 설정
		xhrObject.open("Post", url, "true");	//서버의 요청설정 - url 변수에 설정된 리소스를 요청할 준비
		xhrObject.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");//post방식의 경우 반드시 설정
		xhrObject.send(reqparam);	// 서버로 요청을 보냄
	}
	
	function resGetData(){
		if (xhrObject.readyState == 4){
			if (xhrObject.status == 200){
				let result = xhrObject.responseText;
				let objRes = eval("(" +result+ ")"); // JSON 텍스트 파일을 객체 구조로 생성한다.
				let num = objRes.datas.length;
				let res = "<table cellpadding='3' cellspacing='0' border='1' width='980'>";
				let resDiv = document.getElementById("div_res");
				
				if (num < 1){
					res = res+ "<tr><td width='980' height='100' align='center' style='font-size:50;'>검색 결과가 없습니다.</td></tr>";
				}
				else {
					for (let i=0; i<num; i++){
						let user_id = objRes.datas[i].ID;
						let user_name = objRes.datas[i].NAME;
						let user_phone = objRes.datas[i].PHONE;
						
						res = res+ "<tr>";
						res = res+ "<td width='980' height='100' align='center' style='font-size:50' bgcolor='#D0E6FC'>" +user_id+ "</td>";
						res = res+ "</tr>";
						
						res = res+ "<tr>";
						res = res+ "<td width='980' align='center' style='font-size:50' bgcolor='#FFFFCC'><br>" +user_name+ "<br></td>";
						res = res+ "</tr>";
						
						res = res+ "<tr>";
						res = res+ "<td width='980' align='center' style='font-size:50' bgcolor='#FFFFCC'><br>" +user_phone+ "<br></td>";
						res = res+ "</tr>";
					}
				}
				res = res+ "</table>"
				resDiv.innerHTML = res;
			}
		}
	}
	
	function searchData(){
		let form_name = "form_main";
		let user_id = document.forms[form_name].elements["txt_user_id"].value;
		
		if (user_id == ""){
			alert("user_id를 입력해주세요~^^a");
			document.forms[form_name].elements["txt_user_id"].focus();
			return;
		}
		else{
			getData();
		}
	}
	
</script>

</head>
<body>

	<div id="div_main" width="980" height="300" style="visibility:visible; position:absolute; left:0px; top:115px; z-index:1;">
		<table border="0" width="980" cellpadding="0" cellspacing="0">
			<form name="form_main" onSubmit="javascript:return false;">
				<tr>
					<td width="245"></td>
					<td width="245" align="right">
						<input type="text" name="txt_user_id" size="10" value="" maxlength="10" style="width:240px; font-size:50; text-align:left;" onkeyup="javascript:searchData();"></td>
					<td width="245">
						<button type="button" class="btn btn-primary ml-2" onClick="javascript:searchData();">검 색</button></td>
						<!-- <img src="./img/search.gif" width="80" height="40" onClick="javascript:searchData();"></td> -->
					<td width="245"></td>
				</tr>
			</form>
		</table>
	</div>
	
	<div id="div_res" width="980" style="visibility:visible; position:absolute; left:0px; top:215px; z-index:1;">
		<table border="1" width="980" cellpadding="10" cellspacing="0">
			<tr>
				<td align="center" style="width:950px; font-size:50" bgcolor="#FFFFCC">결과물</td>
			</tr>
		</table>
	</div>

</body>
</html>