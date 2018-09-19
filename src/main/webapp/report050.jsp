<%@page import="java.io.PrintWriter"%>
<%@ page import="java.io.OutputStream" %>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ page import="java.io.BufferedReader "%>
<%@ page import="java.io.IOException "%>
<%@ page import="java.io.InputStream "%>
<%@ page import="java.io.InputStreamReader "%>
<%@ page import="java.io.OutputStreamWriter "%>
<%@ page import="java.io.PrintWriter "%>
<%@ page import="java.net.HttpURLConnection "%>
<%@ page import="java.net.MalformedURLException "%>
<%@ page import="java.net.URL "%>
<%@ page import="java.util.ArrayList "%>
<%@ page import="java.util.HashMap "%>
<%@ page import="java.util.List "%>
<%@ page import="java.util.Map "%>

<%@ page import="org.json.JSONException "%>
<%@ page import="org.json.XML "%>
<%@ page import="org.slf4j.Logger "%>
<%@ page import="org.slf4j.LoggerFactory "%>
<%@ page import="org.springframework.http.HttpEntity "%>
<%@ page import="org.springframework.http.HttpHeaders "%>
<%@ page import="org.springframework.http.MediaType "%>
<%@ page import="org.springframework.stereotype.Controller "%>
<%@ page import="org.springframework.web.bind.annotation.RequestMapping "%>
<%@ page import="org.springframework.web.bind.annotation.RequestMethod "%>
<%@ page import="org.springframework.web.servlet.ModelAndView "%>


<%@ page import="net.sf.jasperreports.engine.JRException "%>
<%@ page import="net.sf.jasperreports.engine.JasperCompileManager "%>
<%@ page import="net.sf.jasperreports.engine.JasperExportManager "%>
<%@ page import="net.sf.jasperreports.engine.JasperFillManager "%>
<%@ page import="net.sf.jasperreports.engine.JasperPrint "%>
<%@ page import="net.sf.jasperreports.engine.data.JRBeanCollectionDataSource "%>


<%


/**
 * 1. CSV파일을 읽어 문자열에 저장합니다. 그리고 콤마로 분리하여 ArrayList에 담습니다.
 * 2. Jasper Report파일에 ArrayList 데이터를 담아 리포트를 출력합니다.
 */

		Map<String,Object> parameterMap = new HashMap<String,Object>();

		JasperPrint jasperPrint = null;
		jasperPrint = JasperFillManager.fillReport(
				JasperCompileManager.compileReport("C:\\myreport\\workspaces\\myreport001\\target\\classes\\reports\\report005.jrxml"),
				parameterMap, new JRBeanCollectionDataSource(getDothomeMessage())
		);

		response.setContentType("application/pdf");
		response.addHeader("Content-disposition", "inline; filename=employeeReport.pdf");
		OutputStream outs = response.getOutputStream();
		JasperExportManager.exportReportToPdfStream(jasperPrint,outs);//export PDF directly
%>

<%!

	// hello world 가져오기
	private ArrayList<Map<String, Object>> getDothomeMessage() {
		
		ArrayList<Map<String, Object>> arr = new ArrayList<Map<String, Object>>();
		
		try {
			URL url = new URL("http://ahhoinn.dothome.co.kr/myData/myCsvData01.csv");
			HttpURLConnection http = (HttpURLConnection)url.openConnection();

			http.setDefaultUseCaches(false);
			http.setDoInput(true);
			http.setDoOutput(true);
			http.setRequestMethod("GET");

			// 서버에서내용받기
			InputStreamReader tmp = new InputStreamReader(http.getInputStream(),"utf-8");
			BufferedReader reader = new BufferedReader(tmp);

			String [] meta = {"name","postNumber","address01","address02"};
			int idx = 0;
			String str;
			while((str = reader.readLine()) != null) {
			
				if (++idx == 1) {
					meta = str.split(",");
				}
				else 
				{
					String[] field = str.split(",");
					
					HashMap item = new HashMap();
					item.put(meta[0],       field[0]);   // name
					item.put(meta[1], field[1]);   // postNumber
					item.put(meta[2],  field[2]);   // address01  
					item.put(meta[3],  field[3]);   // address02
					
					arr.add(item);
				}
				
			}

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return arr;
	}

	
%>

