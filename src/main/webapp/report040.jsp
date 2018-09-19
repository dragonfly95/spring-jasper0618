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
<%@ page import="java.util.Iterator "%>
<%@ page import="java.util.List "%>
<%@ page import="java.util.Map "%>


<%@ page import="com.fasterxml.jackson.core.type.TypeReference "%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper "%>
<%@ page import="com.google.gson.JsonArray "%>
<%@ page import="com.google.gson.JsonElement "%>
<%@ page import="com.google.gson.JsonParser "%>

<%@ page import="net.sf.jasperreports.engine.JRException "%>
<%@ page import="net.sf.jasperreports.engine.JasperCompileManager "%>
<%@ page import="net.sf.jasperreports.engine.JasperExportManager "%>
<%@ page import="net.sf.jasperreports.engine.JasperFillManager "%>
<%@ page import="net.sf.jasperreports.engine.JasperPrint "%>
<%@ page import="net.sf.jasperreports.engine.data.JRBeanCollectionDataSource "%>

<%@ page import="org.json.JSONException "%>
<%@ page import="org.json.XML "%>



<%!
	// hello world 가져오기
	private String getDothomeMessage() {
		StringBuffer builder = new StringBuffer();

		try {
			URL url = new URL("http://ahhoinn.dothome.co.kr/myData/myXmlData.xml");
			HttpURLConnection http = (HttpURLConnection)url.openConnection();

			http.setDefaultUseCaches(false);
			http.setDoInput(true);
			http.setDoOutput(true);
			http.setRequestMethod("GET");

			StringBuffer buffer = new StringBuffer();

			OutputStreamWriter outStream = new OutputStreamWriter(http.getOutputStream(), "utf-8");
			PrintWriter writer = new PrintWriter(outStream);
			writer.write(buffer.toString());
			writer.flush();

			// 서버에서내용받기
			InputStreamReader tmp = new InputStreamReader(http.getInputStream(),"utf-8");
			BufferedReader reader = new BufferedReader(tmp);

			String str;
			while((str = reader.readLine()) != null) {
				builder.append(str + "\n");
			}

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return builder.toString();
	}
	
	
	  
	
    //-----------------------------------------------------------//
	private List<Map<String, Object>> getResultFromXML(String json) {
		
	    System.out.println("==========================================");

        Map<String, Object> items = null;
        List<Map<String, Object>> itemList = null;
        
	    try {
			org.json.JSONObject xmlJSONObj = XML.toJSONObject(json);
			String xmlJSONObjString = xmlJSONObj.toString();
            System.out.println("### xmlJSONObjString=>"+xmlJSONObjString);
            
            ObjectMapper objectMapper = new ObjectMapper();
            Map<String, Object> map = new HashMap();
            map = objectMapper.readValue(xmlJSONObjString, new TypeReference<Map<String, Object>>() {});

            items = (Map<String, Object>) map.get("data");
            itemList = (List<Map<String, Object>>) items.get("person");
 

		} catch (IOException e) {
			e.printStackTrace();
		}

	    
	    return itemList;
	}

%>



<%
		String json = getDothomeMessage();
		Map<String,Object> parameterMap = new HashMap<String,Object>();
		parameterMap.put("param1", json);


		JasperPrint jasperPrint = null;

		jasperPrint = JasperFillManager.fillReport(
				JasperCompileManager.compileReport("C:\\myreport\\workspaces\\myreport001\\target\\classes\\reports\\report004.jrxml"),
				parameterMap, new JRBeanCollectionDataSource(getResultFromXML(json))
		);


		response.setContentType("application/pdf");
		response.addHeader("Content-disposition", "inline; filename=employeeReport.pdf");
		OutputStream outs = response.getOutputStream();
		JasperExportManager.exportReportToPdfStream(jasperPrint,outs);//export PDF directly

%>
