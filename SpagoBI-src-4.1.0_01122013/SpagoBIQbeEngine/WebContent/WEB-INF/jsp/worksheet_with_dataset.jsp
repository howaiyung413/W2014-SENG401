<%-- SpagoBI, the Open Source Business Intelligence suite

 Copyright (C) 2012 Engineering Ingegneria Informatica S.p.A. - SpagoBI Competency Center
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0, without the "Incompatible With Secondary Licenses" notice.  If a copy of the MPL was not distributed with this file,
 You can obtain one at http://mozilla.org/MPL/2.0/. --%>

<%@ page language="java" 
	     contentType="text/html; charset=ISO-8859-1" 
	     pageEncoding="ISO-8859-1"%>

<%-- ---------------------------------------------------------------------- --%>
<%-- JAVA IMPORTS															--%>
<%-- ---------------------------------------------------------------------- --%>
<%@page import="it.eng.spago.configuration.*"%>
<%@page import="it.eng.spago.base.*"%>
<%@page import="it.eng.spagobi.engines.qbe.QbeEngineConfig"%>
<%@page import="it.eng.spagobi.engines.qbe.QbeEngineInstance"%>
<%@page import="it.eng.spagobi.utilities.engines.EngineConstants"%>
<%@page import="it.eng.spagobi.commons.bo.UserProfile"%>
<%@page import="it.eng.spago.security.IEngUserProfile"%>
<%@page import="it.eng.spagobi.commons.constants.SpagoBIConstants"%>
<%@page import="java.util.Locale"%>
<%@page import="it.eng.spagobi.services.common.EnginConf"%>
<%@page import="it.eng.spagobi.engines.worksheet.bo.WorkSheetDefinition"%>
<%@page import="it.eng.spagobi.engines.worksheet.WorksheetEngineInstance"%>

<%-- ---------------------------------------------------------------------- --%>
<%-- JAVA CODE 																--%>
<%-- ---------------------------------------------------------------------- --%>
<%
	WorksheetEngineInstance worksheetEngineInstance;
	UserProfile profile;
	Locale locale;
	String isFromCross;
	boolean isPowerUser;
	Integer resultLimit = 10;
	boolean isMaxResultLimitBlocking = false;
	boolean isQueryValidationEnabled = false;
	boolean isQueryValidationBlocking = false;
	int crosstabCellLimit = 0;
	int crosstabCalculatedFieldsDecimalePrecison = 2;
	
	ResponseContainer responseContainer = ResponseContainerAccess.getResponseContainer(request);
	SourceBean serviceResponse = responseContainer.getServiceResponse();
	worksheetEngineInstance = (WorksheetEngineInstance) serviceResponse.getAttribute(WorksheetEngineInstance.class.getName());
	profile = (UserProfile)worksheetEngineInstance.getEnv().get(EngineConstants.ENV_USER_PROFILE);
	locale = (Locale) worksheetEngineInstance.getEnv().get(EngineConstants.ENV_LOCALE);
	
	QbeEngineConfig qbeEngineConfig = QbeEngineConfig.getInstance();
	if ( qbeEngineConfig != null ) {
		// settings for max records number limit
		resultLimit = qbeEngineConfig.getResultLimit();
		isMaxResultLimitBlocking = qbeEngineConfig.isMaxResultLimitBlocking();
		isQueryValidationEnabled = qbeEngineConfig.isQueryValidationEnabled();
		isQueryValidationBlocking = qbeEngineConfig.isQueryValidationBlocking();
		crosstabCellLimit = qbeEngineConfig.getCrosstabCellLimit();
		crosstabCalculatedFieldsDecimalePrecison = qbeEngineConfig.getCrosstabCFDecimalPrecision();
	}
	

%>

<%-- ---------------------------------------------------------------------- --%>
<%-- HTML	 																--%>
<%-- ---------------------------------------------------------------------- --%>

<%-- DOCTYPE declaration: it is required in order to fix some side effects, in particular in IE --%>
<%-- 21-01-2010: the xhtml1-strict DOCTYPE causes this problem in IE8:
	Open the Document Browser, execute a FORM document, when the form appears close the folders tree panel on the left,
	expand a grouping variables combobox, then the iframe containing the form is RESIZED in width!!!
	And it returns to the right width with a onmouseover event on certain elements....  
	Therefore this DOCTYPE must be commented!!!
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
end DOCTYPE declaration --%>
    
<html>

	<head>
		<%@include file="commons/includeExtJS.jspf" %>
		<%@include file="commons/includeSbiQbeJS.jspf"%>
	</head>
	
	<body>
   
    	<script type="text/javascript"> 

    	Sbi.config = {}; 
    	Sbi.config.worksheetVersion = <%= WorkSheetDefinition.CURRENT_VERSION %>;
    	Sbi.config.crosstabCellLimit = <%= crosstabCellLimit %>;
    	Sbi.config.crosstabCalculatedFieldsDecimalePrecison = <%= crosstabCalculatedFieldsDecimalePrecison %>;
    	
    	var url = {
		    	host: '<%= request.getServerName()%>'
		    	, port: '<%= request.getServerPort()%>'
		    	, contextPath: '<%= request.getContextPath().startsWith("/")||request.getContextPath().startsWith("\\")?
		    	   				  request.getContextPath().substring(1):
		    	   				  request.getContextPath()%>'
		    	    
		};

	    var params = {
		    	SBI_EXECUTION_ID: <%= request.getParameter("SBI_EXECUTION_ID")!=null?"'" + request.getParameter("SBI_EXECUTION_ID") +"'": "null" %>
		};
	
	    Sbi.config.serviceRegistry = new Sbi.service.ServiceRegistry({
	    	baseUrl: url
	        , baseParams: params
		});
	    
	    var workSheetPanel = null;
	    
        Ext.onReady(function() {
        	Ext.QuickTips.init();

			var worksheet = <%= ((WorkSheetDefinition)(worksheetEngineInstance.getAnalysisState())).getConf(null).toString() %>;
        	workSheetPanel = new Sbi.worksheet.designer.WorksheetDefinitionPanel(worksheet, {
        		header: false
        	});
           	var viewport = new Ext.Viewport({layout: 'fit', items: [workSheetPanel]}); 
           	
      	});
      	
	    </script>
	
	</body>

</html>