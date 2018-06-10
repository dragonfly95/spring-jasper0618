<%@ page contentType="text/html;charset=utf-8" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.10.1/xlsx.core.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.10.1/cpexcel.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">


<style>
  .mother {
    page-break-after: always;
    margin-top: 60px;
  }
  .block {  
    height: 127px;
    margin: 0;  
    padding: 0; 
    border: 0;
    line-height: 22px;
  }
  .left {
    left: 20px;
    position: absolute; 
  }
  .right {
    left: 400px;
    position: absolute;
  }
  .dear{
    font-size: 12px;
    padding-left: 5px;
  }
  .name{
    width: 320px;
    text-align: right;
    font-size: 18px;
  }
  .post{
	width: 330px;
    font-size: 18px;
    text-align: right;
    letter-spacing:10px;
    margin-right: -10px;  
  } 

  

  @media print {
    input,
    button, #exampleModalLong, .form-group {
        display: none;
    }
  }

</style>
</head>
<body>
  <p></p>
  <p></p>
 
  <div class="form-group">
    <h5> 엑셀 주소라벨 (8행2열:16),(크롬용)</h5>
   <input type="file" id="fileInput" class="btn " /> 
   
   <p></p>
   <input type="text"  id="search" value="" placeholder="이름검색..." maxlength="20" />
   <input type="text"  id="dear" placeholder="호칭: 귀하, 귀중" value="" />
   <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalLong">
     샘플데이터
   </button>
 </div>
 <div id="loading">
   <h2>잠시만 기다려 주세요..</h2>
 </div>
 <button id="printBtn">프린트</button>
 <br/>
 <button id="printBtn2">spring</button>
 <script>
 
 </script>
 <!-- Button trigger modal --> 

 <!-- Modal -->
 <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
   <div class="modal-dialog" role="document">
     <div class="modal-content">
       <div class="modal-header">
         <h5 class="modal-title" id="exampleModalLongTitle">크롬에서 실행하세요</h5>
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
           <span aria-hidden="true">&times;</span>
         </button>
       </div>
       <div class="modal-body">
         배치순서 : 
         1. 이름
         2. 우편번호
         3. 도로명주소
         4. 상세주소<br>
         <a href="resources/myExcelData.xlsx" data-ajax="false">샘플데이터다운로드</a>
       </div>
       <div class="modal-footer">
         <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
       </div>
     </div>
   </div>
 </div>
 <div id="output">
 </div>

   <script src="resources/print.js"></script>
</body>


</html>