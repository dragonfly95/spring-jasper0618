<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.InputStream" %>
<%@ page import="net.sf.jasperreports.engine.JREmptyDataSource" %>
<%@ page import="net.sf.jasperreports.engine.JRException" %>
<%@ page import="net.sf.jasperreports.engine.JasperCompileManager" %>
<%@ page import="net.sf.jasperreports.engine.JasperExportManager" %>
<%@ page import="net.sf.jasperreports.engine.JasperFillManager" %>
<%@ page import="net.sf.jasperreports.engine.JasperPrint" %>

<%@ page import="net.sf.jasperreports.engine.JRExporter" %>
<%@ page import="net.sf.jasperreports.engine.export.JRPdfExporter" %>
<%@ page import="net.sf.jasperreports.engine.JRExporterParameter" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.OutputStream" %>
<%

	JasperPrint jasperPrint = null;
	InputStream inputStream = null;
	
	jasperPrint = JasperFillManager.fillReport(
			JasperCompileManager.compileReport("C:\\myreport\\workspaces\\myreport001\\target\\classes\\reports\\blank.jrxml"),
			null, new JREmptyDataSource()
	);
	

	response.setContentType("application/pdf");
	response.addHeader("Content-disposition", "inline; filename=employeeReport.pdf");
	OutputStream outs = response.getOutputStream();
	JasperExportManager.exportReportToPdfStream(jasperPrint,outs);//export PDF directly

	
%>

