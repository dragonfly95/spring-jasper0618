<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.OutputStreamWriter" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.MalformedURLException" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%@ page import="net.sf.jasperreports.engine.JREmptyDataSource" %>
<%@ page import="net.sf.jasperreports.engine.JRException" %>
<%@ page import="net.sf.jasperreports.engine.JasperCompileManager" %>
<%@ page import="net.sf.jasperreports.engine.JasperExportManager" %>
<%@ page import="net.sf.jasperreports.engine.JasperFillManager" %>
<%@ page import="net.sf.jasperreports.engine.JasperPrint" %>
<%@ page import="java.io.OutputStream" %>
<%!

	public String getDothomeMessage() {
		StringBuffer builder = new StringBuffer();

		try {
			URL url = new URL("http://ahhoinn.dothome.co.kr/myData/hello.txt");
			HttpURLConnection http = (HttpURLConnection)url.openConnection();

			http.setDefaultUseCaches(false);
			http.setDoInput(true);
			http.setDoOutput(true);
			http.setRequestMethod("GET");

			StringBuffer buffer = new StringBuffer();

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
%>

<%

// getClass().getResourceAsStream("C:\\myreport\\workspaces\\myreport001\\target\\classes\\reports\\hello.jrxml")),
				
		Map<String,Object> parameterMap = new HashMap<String,Object>();
		parameterMap.put("param1", getDothomeMessage());

		JasperPrint jasperPrint = null;


		jasperPrint = JasperFillManager.fillReport(
				JasperCompileManager.compileReport("C:\\myreport\\workspaces\\myreport001\\target\\classes\\reports\\hello.jrxml"),
				parameterMap, new JREmptyDataSource()
		);

		response.setContentType("application/pdf");
		response.addHeader("Content-disposition", "inline; filename=employeeReport.pdf");
		OutputStream outs = response.getOutputStream();
		JasperExportManager.exportReportToPdfStream(jasperPrint,outs);//export PDF directly

%>

