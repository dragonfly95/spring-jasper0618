<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.io.PrintWriter"%>
<%@ page import="java.io.OutputStream" %>

<%@ page import="java.io.File"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.FileNotFoundException"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.MalformedURLException"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.ZoneId"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>

<%@ page import="org.apache.poi.xssf.usermodel.XSSFCell"%>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFRow"%>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@ page import="org.slf4j.Logger"%>
<%@ page import="org.slf4j.LoggerFactory"%>

<%@ page import="net.sf.jasperreports.engine.JRException"%>
<%@ page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@ page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@ page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@ page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@ page import="net.sf.jasperreports.engine.data.JRBeanCollectionDataSource"%>


<%


/**
 * 1. 서버에서 엑셀 파일을 읽어서 c:\temp 폴더에 파일로 저장합니다.
 * 2. 엑셀파일을 poi library를 이용하여 읽어 ArrayList에 담습니다.
 * 3. 읽은 파일은 삭제합니다.
 * 4. Jasper Report파일에 ArrayList 데이터를 담아 리포트를 출력합니다.
 */


	
	
		String fileURL =
		  "http://ahhoinn.dothome.co.kr/myData/myExcelData.xlsx";
		String saveDir = "c:/temp";
		
		String filePath = getDothomeMessage(fileURL, saveDir);
		Map<String,Object> parameterMap = new HashMap<String,Object>();


		JasperPrint jasperPrint = null;

		jasperPrint = JasperFillManager.fillReport(
				JasperCompileManager.compileReport("C:\\myreport\\workspaces\\myreport001\\target\\classes\\reports\\report006.jrxml"),
				parameterMap, new JRBeanCollectionDataSource(getResultFromExcel(new File(filePath)) )
		);

		response.setContentType("application/pdf");
		response.addHeader("Content-disposition", "inline; filename=employeeReport.pdf");
		OutputStream outs = response.getOutputStream();
		JasperExportManager.exportReportToPdfStream(jasperPrint,outs);//export PDF directly

%>

<%!

    private static final int BUFFER_SIZE = 4096;


	// hello world 가져오기
	private String getDothomeMessage(String fileURL, String saveDir) {
		StringBuffer builder = new StringBuffer();

		try {
			URL url = new URL(fileURL);
			HttpURLConnection http = (HttpURLConnection)url.openConnection();

			int responseCode = http.getResponseCode();
			if(responseCode == HttpURLConnection.HTTP_OK) {
				
				String fileName = "";
	            String disposition = http.getHeaderField("Content-Disposition");
	            String contentType = http.getContentType();
	            int contentLength = http.getContentLength();
	 
	            if (disposition != null) {
	                // extracts file name from header field
	                int index = disposition.indexOf("filename=");
	                if (index > 0) {
	                    fileName = disposition.substring(index + 10,
	                            disposition.length() - 1);
	                }
	            } else {
	                // extracts file name from URL
	                fileName = fileURL.substring(fileURL.lastIndexOf("/") + 1,
	                        fileURL.length());
	            }
	 

	 
	            java.util.Date date = new Date();
	            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");
	            LocalDateTime localDateTime = LocalDateTime.ofInstant(date.toInstant(), ZoneId.systemDefault());
	            String formatted = dateTimeFormatter.format(localDateTime);
	            
	            // opens input stream from the HTTP connection
	            InputStream inputStream = http.getInputStream();
	            String saveFilePath = saveDir + File.separator + formatted+".xlsx";
	            builder.append(saveFilePath);
	            
	            // opens an output stream to save into file
	            FileOutputStream outputStream = new FileOutputStream(saveFilePath);
	 
	            int bytesRead = -1;
	            byte[] buffer = new byte[BUFFER_SIZE];
	            while ((bytesRead = inputStream.read(buffer)) != -1) {
	                outputStream.write(buffer, 0, bytesRead);
	            }
	 
	            outputStream.close();
	            inputStream.close();
	 
				
			}

			http.disconnect();
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return builder.toString();
	}
	
	
	  
	
    //-----------------------------------------------------------//
	private List<Map<String, Object>> getResultFromExcel(File file) {


        Map<String, Object> item = null;
        List<Map<String, Object>> itemList = new ArrayList<Map<String, Object>>();
        

        FileInputStream fis;
		try {
			fis = new FileInputStream(file);
			XSSFWorkbook workbook=new XSSFWorkbook(fis);
	        int rowindex=0;
	        int columnindex=0;
	        //시트 수 (첫번째에만 존재하므로 0을 준다)
	        //만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
	        XSSFSheet sheet=workbook.getSheetAt(0);
	        String [] meta = {"name","postNumber","address01","address02"};
	        //행의 수
	        int rows=sheet.getPhysicalNumberOfRows();
	        for(rowindex=1;rowindex<rows;rowindex++){
	        	item = new HashMap<String, Object>();
	            //행을읽는다
	            XSSFRow row=sheet.getRow(rowindex);
	            if(row !=null){
	            	//셀의 수
	                int cells=row.getPhysicalNumberOfCells();
	                for(columnindex=0;columnindex<=cells;columnindex++){
	                    //셀값을 읽는다
	                    XSSFCell cell=row.getCell(columnindex);
	                    String value="";
	                    //셀이 빈값일경우를 위한 널체크
	                    if(cell==null){
	                        continue;
	                    }else{
	                        //타입별로 내용 읽기
	                        switch (cell.getCellType()){
	                        case XSSFCell.CELL_TYPE_FORMULA:
	                            value=cell.getCellFormula();
	                            break;
	                        case XSSFCell.CELL_TYPE_NUMERIC:
	                            value=cell.getNumericCellValue()+"";
	                            break;
	                        case XSSFCell.CELL_TYPE_STRING:
	                            value=cell.getStringCellValue()+"";
	                            break;
	                        case XSSFCell.CELL_TYPE_BLANK:
	                            value=cell.getBooleanCellValue()+"";
	                            break;
	                        case XSSFCell.CELL_TYPE_ERROR:
	                            value=cell.getErrorCellValue()+"";
	                            break;
	                        }
	                    }

	                    item.put(meta[columnindex], value);
	                }
	            }
	            itemList.add(item);
	        }

	        fis.close();
	        
	        if(file.exists()) {
	        	if(file.delete()) {
	        		System.out.println("파일삭제 하였음");
	        	}
	        }
	        
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	    
	    return itemList;
	}
	
%>

