<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.BufferedReader" %>
<%@page import="java.io.IOException" %>
<%@page import="java.io.InputStream" %>
<%@page import="java.io.InputStreamReader" %>
<%@page import="java.io.OutputStreamWriter" %>
<%@page import="java.io.PrintWriter" %>
<%@page import="java.net.HttpURLConnection" %>
<%@page import="java.net.MalformedURLException" %>
<%@page import="java.net.URL" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.util.Map" %>
<%@ page import="java.io.OutputStream" %>

<%@page import="com.google.gson.Gson" %>
<%@page import="com.google.gson.JsonArray" %>
<%@page import="com.google.gson.JsonElement" %>
<%@page import="com.google.gson.JsonParser" %>

<%@page import="net.sf.jasperreports.engine.JREmptyDataSource" %>
<%@page import="net.sf.jasperreports.engine.JRException" %>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager" %>
<%@page import="net.sf.jasperreports.engine.JasperExportManager" %>
<%@page import="net.sf.jasperreports.engine.JasperFillManager" %>
<%@page import="net.sf.jasperreports.engine.JasperPrint" %>
<%@page import="net.sf.jasperreports.engine.data.JRBeanCollectionDataSource" %>
<%!

	// hello world 가져오기
	private String getDothomeMessage() {
		StringBuffer builder = new StringBuffer();

		try {
			URL url = new URL("http://ahhoinn.dothome.co.kr/myData/myJsonData01.json");
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
	
	
	
	private ArrayList<Map<String, Object>> getResultToHashMap(String json) {

		ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		JsonParser parser = new JsonParser();
        JsonElement element = parser.parse(json);
        JsonArray arr = element.getAsJsonObject().get("myJsonData").getAsJsonArray();
        Iterator<JsonElement> it = arr.iterator();
        while(it.hasNext()) {
        	JsonElement j1 = (JsonElement) it.next();
        	
        	Gson gson = new Gson();
        	list.add((Map<String, Object>) gson.fromJson(j1, HashMap.class));
        }
        return list;
	}
%>


<%

		String json = getDothomeMessage();
		Map<String,Object> parameterMap = new HashMap<String,Object>();
		parameterMap.put("param1", json);

		JasperPrint jasperPrint = null;

		jasperPrint = JasperFillManager.fillReport(
				JasperCompileManager.compileReport("C:\\myreport\\workspaces\\myreport001\\target\\classes\\reports\\report003.jrxml"),
				parameterMap, new JRBeanCollectionDataSource(getResultToHashMap(json))
		);

		response.setContentType("application/pdf");
		response.addHeader("Content-disposition", "inline; filename=employeeReport.pdf");
		OutputStream outs = response.getOutputStream();
		JasperExportManager.exportReportToPdfStream(jasperPrint,outs);//export PDF directly


	
%>

