

$(function() {
  var jsonData;
  // 파일 입력 엘리먼트 가져오기 
   var jsonData;
  // 파일 입력 엘리먼트 가져오기 
  var fileInput = document.getElementById('fileInput');

  // 파일 입력 엘리먼트를 감지하여 변경이 되면 콜백 함수 수행
  fileInput.addEventListener('change', function(e) {
    $("#loading").show();
    handleDrop(e);
  });
  $("#loading").hide();


  $("#dear").on('keyup', function(k){
    $(".dear").text($(this).val());
  });
  

  $("#search").on('keyup', function(){
    var search = $(this).val();
    var layout = makeList(search);
    $("#output").html(layout);
    //$("#labels").html(li);
  });


  $("#printBtn").on('click', function() {
    //window.print();
    var browser = navigator.userAgent.toLowerCase();
      if ( -1 != browser.indexOf('chrome') ){
           window.print();
      }else if ( -1 != browser.indexOf('trident') ){
           try{
                //참고로 IE 5.5 이상에서만 동작함
                //웹 브라우저 컨트롤 생성
                var webBrowser = '<OBJECT ID="previewWeb" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
                //웹 페이지에 객체 삽입
                document.body.insertAdjacentHTML('beforeEnd', webBrowser);
                //ExexWB 메쏘드 실행 (7 : 미리보기 , 8 : 페이지 설정 , 6 : 인쇄하기(대화상자))
                previewWeb.ExecWB(7, 1);
                //객체 해제
                previewWeb.outerHTML = "";
           }catch (e) {
                alert("- 11도구 > 인터넷 옵션 > 보안 탭 > 신뢰할 수 있는 사이트 선택\n   1. 사이트 버튼 클릭 > 사이트 추가\n   2. 사용자 지정 수준 클릭 > 스크립팅하기 안전하지 않은 것으로 표시된 ActiveX 컨트롤 (사용)으로 체크\n\n※ 위 설정은 프린트 기능을 사용하기 위함임");
           }
      }
  });

  //------------------------------
  var data = {"list": [
    {"name": "홍길동1", "postNo": "01234", "address01": "서울 중랑구 신내", "address02": "1동"}]}

  $('#printBtn2').on('click',function(){

    // 파일 객체 가져오기 
    var files = fileInput.files;
    var i, f;
    for (i = 0; i != files.length; ++i) {
      f = files[i];
      var reader = new FileReader();
      var name = f.name;

      
      try {
        reader.onload = function(e) 
        {
          var workbook = XLSX.read(e.target.result, {
            type: 'binary'
          });
      

          
          var sheet_name_list = workbook.SheetNames;
          var sheetName = sheet_name_list[0];

          // workbook.SheetNames.forEach(function(sheetName) {
          // var roa = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName]);
            data = to_json(workbook, sheetName);
          // });
        }
        reader.readAsBinaryString(f);  // works in Firefox and Chrome, but does NOT work in IE
      } catch (err) {    // this code will be executed by IE
      }
    }


    
    $.ajax({
      type: "post",
      // url: "print.do",
      url: "jasper.do",
      data: JSON.stringify({"list": data.Sheet1}),
      contentType: "application/json",
      success: function (response) {
        debugger;
      }
    });
  });
  //-----------------------


});


  function handleDrop(e) {
    //   e.stopPropagation();
    //     e.preventDefault();
    // 파일 객체 가져오기 
    var files = fileInput.files;
    var i, f;
    for (i = 0; i != files.length; ++i) {
      f = files[i];
      var reader = new FileReader();
      var name = f.name;

      
      try {
        reader.onload = function(e) {
          readFile(e.target.result);
        }
        reader.readAsBinaryString(f);  // works in Firefox and Chrome, but does NOT work in IE
      } catch (err) {    // this code will be executed by IE
        reader.onload = function(e) {
          var binaryContents = "";
          var bytes = new Uint8Array(reader.result);
          for (var i = 0; i < bytes.byteLength; i++) {
            binaryContents += String.fromCharCode(bytes[i]);
          }
          readFile(binaryContents);
        }
        reader.readAsArrayBuffer(f);
      }
    }
  }

  // 바이너리로 데이터를 읽어드림 
  function readFile(data) {
    var workbook = XLSX.read(data, {
      type: 'binary'
    });

    //console.log(workbook);
    var sheet_name_list = workbook.SheetNames;
    var sheetName = sheet_name_list[0];

    // workbook.SheetNames.forEach(function(sheetName) {
    var roa = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName]);
      json = to_json(workbook, sheetName);
      jsonData = json[sheetName];
      var layout = makeList('');
      
      //var li = makeList('');
      setTimeout(function() {
        $("#loading").hide();
        $("#output").html(layout);
      }, 1000);
  }

  //fileInput.addEventListener('drop', handleDrop, false);

  // 시트 데이터를 json 으로 변환시켜줌
  function to_json(workbook, sheetName) {
    var result = {};
    // workbook.SheetNames.forEach(function(sheetName) {
    var roa = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName]);
    if (roa.length > 0) {
      result[sheetName] = roa;
    }
    //   });
    return result;
  }

  function makeList(search){
    var itemMargin = 135; // 각 아이템별로 마진
    var marginTop = 0; // 맨 위 마진
    var layout = "";
    var myArray = [];
    // list 배열을 순회하면서 data 정보를 가져옴 
    var i = 0;
    $.each(jsonData, function(k, item) {
      var arr = [];
      for (var prop in item) {
        arr.push(item[prop]);
      }

      if(arr[0].indexOf(search) <= -1){
        return;
      }
      myArray.push(arr);
      //console.log(arr);
      //console.log('-----');
    });
    console.log(myArray);

    var layout = '';
      for (var i = 0; i < myArray.length; i++) {
    
        var num = Math.floor((i%16)/2);

        if(i % 16 == 0) layout += '<div class="mother">';
        var block = '';
        if (i % 2 == 0) {
          block = '<div class="block"><div class="left">';
        } else {
          block = '<div class="right">';
        }
        
        block += '<div>' + (myArray[i][2] ? myArray[i][2] : '&nbsp') + '</div>';
        block += '<div>' + (myArray[i][3] ? myArray[i][3] : '&nbsp') + '</div>';
        block += '<div class="name">' + (myArray[i][0] ? myArray[i][0] : '&nbsp') + '<span class="dear">귀하</span></div>';
        block += '<div class="post">' + (myArray[i][1] ? myArray[i][1] : '&nbsp') + '</div>';
        
        if (i % 2 == 0) {
          block += '</div>';
        } else {
          block += '</div></div>';
        }
        
        layout += block;
        if(i % 16 == 15) layout += '</div>';
      
      }

    return layout;
  }

