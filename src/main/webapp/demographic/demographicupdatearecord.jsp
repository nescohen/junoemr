<%@ page
	import="java.sql.*, java.util.*, oscar.MyDateFormat,oscar.oscarWaitingList.WaitingList, oscar.oscarWaitingList.util.WLWaitingListUtil, oscar.oscarDemographic.data.*, oscar.log.*, org.oscarehr.common.OtherIdManager"
	errorPage="errorpage.jsp"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<jsp:useBean id="apptMainBean" class="oscar.AppointmentMainBean"
	scope="session" />
<jsp:useBean id="oscarVariables" class="java.util.Properties"
	scope="session" />

<!--  
/*
 * 
 * Copyright (c) 2001-2002. Department of Family Medicine, McMaster University. All Rights Reserved. *
 * This software is published under the GPL GNU General Public License. 
 * This program is free software; you can redistribute it and/or 
 * modify it under the terms of the GNU General Public License 
 * as published by the Free Software Foundation; either version 2 
 * of the License, or (at your option) any later version. * 
 * This program is distributed in the hope that it will be useful, 
 * but WITHOUT ANY WARRANTY; without even the implied warranty of 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
 * GNU General Public License for more details. * * You should have received a copy of the GNU General Public License 
 * along with this program; if not, write to the Free Software 
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. * 
 * 
 * <OSCAR TEAM>
 * 
 * This software was written for the 
 * Department of Family Medicine 
 * McMaster University 
 * Hamilton 
 * Ontario, Canada 
 */
-->
<%
    if(session.getValue("user") == null) response.sendRedirect("../../logout.jsp");
%>

<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.oscarehr.util.MiscUtils"%><html:html locale="true">
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script></head>

<body>
<center>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr bgcolor="#486ebd">
		<th align="CENTER"><font face="Helvetica" color="#FFFFFF">
		UPDATE demographic RECORD</font></th>
	</tr>
</table>
<%  

  ResultSet rs = null;
  java.util.Locale vLocale =(java.util.Locale)session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);

  //if action is good, then give me the result
    String[] param =new String[30];
	  param[0]=request.getParameter("last_name");
	  param[1]=request.getParameter("first_name");
	  param[2]=request.getParameter("address");
	  param[3]=request.getParameter("city");
	  param[4]=request.getParameter("province");
	  param[5]=request.getParameter("postal");
	  param[6]=request.getParameter("phone");
	  param[7]=request.getParameter("phone2");
	  param[8]=request.getParameter("email");
	  param[9]=request.getParameter("pin");
	  param[10]=request.getParameter("year_of_birth");
	  param[11]=request.getParameter("month_of_birth")!=null && request.getParameter("month_of_birth").length()==1 ? "0"+request.getParameter("month_of_birth") : request.getParameter("month_of_birth");
	  param[12]=request.getParameter("date_of_birth")!=null && request.getParameter("date_of_birth").length()==1 ? "0"+request.getParameter("date_of_birth") : request.getParameter("date_of_birth");
	  param[13]=request.getParameter("hin");
	  param[14]=request.getParameter("ver");
	  param[15]=request.getParameter("roster_status");
	  param[16]=request.getParameter("patient_status");
	  param[17]=request.getParameter("chart_no");
	  param[18]=request.getParameter("provider_no");
	  param[19]=request.getParameter("sex");
	  param[20]=request.getParameter("pcn_indicator");
	  param[21]=request.getParameter("hc_type");
	  param[22]="<rdohip>" + request.getParameter("r_doctor_ohip") + "</rdohip><rd>" + request.getParameter("r_doctor") + "</rd>" + (request.getParameter("family_doc")!=null? ("<family_doc>" + request.getParameter("family_doc") + "</family_doc>") : "") ;  
          param[23] =request.getParameter("countryOfOrigin");
          param[24]=request.getParameter("newsletter");
          param[25]=request.getParameter("sin");
	  param[26]=request.getParameter("title");
	  param[27]=request.getParameter("official_lang");
	  param[28]=request.getParameter("spoken_lang");
          param[29]=(String)session.getAttribute("user");
	
		java.sql.Date [] dtparam = new java.sql.Date[5];

		String yearTmp=StringUtils.trimToNull(request.getParameter("date_joined_year"));
		String monthTmp=StringUtils.trimToNull(request.getParameter("date_joined_month"));
		String dayTmp=StringUtils.trimToNull(request.getParameter("date_joined_date"));
		if( yearTmp != null && monthTmp!=null && dayTmp!=null )
		{
			dtparam[0]=MyDateFormat.getSysDate(yearTmp+'-'+monthTmp+'-'+dayTmp);
		}
		else
		{
			dtparam[0]=null;
		}
		
		yearTmp=StringUtils.trimToNull(request.getParameter("end_date_year"));
		monthTmp=StringUtils.trimToNull(request.getParameter("end_date_month"));
		dayTmp=StringUtils.trimToNull(request.getParameter("end_date_date"));
		if( yearTmp != null && monthTmp!=null && dayTmp!=null )
		{
			dtparam[1]=MyDateFormat.getSysDate(yearTmp+'-'+monthTmp+'-'+dayTmp);
		}
		else
		{
			dtparam[1]=null;
		}
          
		yearTmp=StringUtils.trimToNull(request.getParameter("eff_date_year"));
		monthTmp=StringUtils.trimToNull(request.getParameter("eff_date_month"));
		dayTmp=StringUtils.trimToNull(request.getParameter("eff_date_date"));
		if( yearTmp != null && monthTmp!=null && dayTmp!=null )
		{
			dtparam[2]=MyDateFormat.getSysDate(yearTmp+'-'+monthTmp+'-'+dayTmp);
		}
		else
		{
			dtparam[2]=null;
		}

		yearTmp=StringUtils.trimToNull(request.getParameter("hc_renew_date_year"));
		monthTmp=StringUtils.trimToNull(request.getParameter("hc_renew_date_month"));
		dayTmp=StringUtils.trimToNull(request.getParameter("hc_renew_date_date"));
		if( yearTmp != null && monthTmp!=null && dayTmp!=null )
		{
			dtparam[3]=MyDateFormat.getSysDate(yearTmp+'-'+monthTmp+'-'+dayTmp);
		}
		else
		{
			dtparam[3]=null;
		}

                yearTmp=StringUtils.trimToNull(request.getParameter("roster_date_year"));
		monthTmp=StringUtils.trimToNull(request.getParameter("roster_date_month"));
		dayTmp=StringUtils.trimToNull(request.getParameter("roster_date_day"));

		if( yearTmp != null && monthTmp!=null && dayTmp!=null )
		{
			dtparam[4]=MyDateFormat.getSysDate(yearTmp+'-'+monthTmp+'-'+dayTmp);
		}
		else
		{
			dtparam[4]=null;
		}
         
          
	  int []intparam=new int[] {Integer.parseInt(request.getParameter("demographic_no"))};
     
  //DemographicExt
     DemographicExt dExt = new DemographicExt();
     String proNo = (String) session.getValue("user");
	 String demoNo = request.getParameter("demographic_no");
     dExt.addKey(proNo, demoNo, "demo_cell", request.getParameter("demo_cell"), request.getParameter("demo_cellOrig"));
     dExt.addKey(proNo, demoNo, "hPhoneExt", request.getParameter("hPhoneExt"), request.getParameter("hPhoneExtOrig"));
     dExt.addKey(proNo, demoNo, "wPhoneExt", request.getParameter("wPhoneExt"), request.getParameter("wPhoneExtOrig"));
     dExt.addKey(proNo, demoNo, "cytolNum",  request.getParameter("cytolNum"),  request.getParameter("cytolNumOrig"));
     
     dExt.addKey(proNo, demoNo, "ethnicity",  request.getParameter("ethnicity"),  request.getParameter("ethnicityOrig"));
     dExt.addKey(proNo, demoNo, "area",		  request.getParameter("area"),		  request.getParameter("areaOrig"));
     dExt.addKey(proNo, demoNo, "statusNum",  request.getParameter("statusNum"),  request.getParameter("statusNumOrig"));
     dExt.addKey(proNo, demoNo, "fNationCom", request.getParameter("fNationCom"), request.getParameter("fNationComOrig"));

     dExt.addKey(proNo, demoNo, "given_consent", request.getParameter("given_consent"), request.getParameter("given_consentOrig"));
     
     // for the IBD clinic
	 OtherIdManager.saveIdDemographic(demoNo, "meditech_id", request.getParameter("meditech_id"));
    
     // customized key
     if(oscarVariables.getProperty("demographicExt") != null) {
	       String [] propDemoExt = oscarVariables.getProperty("demographicExt","").split("\\|");
	       for(int k=0; k<propDemoExt.length; k++) {
	           dExt.addKey(proNo,request.getParameter("demographic_no"),propDemoExt[k].replace(' ','_'),request.getParameter(propDemoExt[k].replace(' ','_')),request.getParameter(propDemoExt[k].replace(' ','_')+"Orig"));
	       }
     }
     // customized key
  //DemographicExt


     
     // added check to see if patient has a bc health card and has a version code of 66, in this case you are aloud to have dup hin
     boolean hinDupCheckException = false;
     String hcType = request.getParameter("hc_type");
     String ver  = request.getParameter("ver");
     if (hcType != null && ver != null && hcType.equals("BC") && ver.equals("66")){
        hinDupCheckException = true;    
     }
     
     if(request.getParameter("hin")!=null && request.getParameter("hin").length()>5 && !hinDupCheckException) {
            //oscar.oscarBilling.ca.on.data.BillingONDataHelp dbObj = new oscar.oscarBilling.ca.on.data.BillingONDataHelp();
            //String sql = "select demographic_no from demographic where hin=? and year_of_birth=? and month_of_birth=? and date_of_birth=?";
            String paramNameHin =new String();
            paramNameHin=request.getParameter("hin").trim();
        ResultSet rsHin = apptMainBean.queryResults(paramNameHin, "search_hin");
        while (rsHin.next()) { 
           
            if (!(rsHin.getString("demographic_no").equals(request.getParameter("demographic_no")))) { 
                if (rsHin.getString("ver") != null && !rsHin.getString("ver").equals("66")){%>
***<font color='red'><bean:message
	key="demographic.demographicaddarecord.msgDuplicatedHIN" /></font>***<br>
<br>
<a href=# onClick="history.go(-1);return false;"><b>&lt;-<bean:message
	key="global.btnBack" /></b></a> <% return;
                }
            }
        }
    }

    int[] paramArch =new int[] {Integer.parseInt(request.getParameter("demographic_no"))};
    apptMainBean.queryExecuteUpdate(paramArch, "archive_record");

  int rowsAffected = apptMainBean.queryExecuteUpdate(param, dtparam, intparam, request.getParameter("dboperation"));
  if (rowsAffected ==1) {      
    //find the democust record for update
    try{  
    DemographicNameAgeString nameAgeString  = DemographicNameAgeString.getInstance();
    nameAgeString.resetDemographic(request.getParameter("demographic_no"));   
    }catch(Exception nameAgeEx){
    	MiscUtils.getLogger().error("ERROR RESETTING NAME AGE", nameAgeEx);
    }
    rs = apptMainBean.queryResults(request.getParameter("demographic_no"), "search_custrecordno");
    if(rs.next() ) { //update
      String[] param1 =new String[6];
	    param1[0]=request.getParameter("resident");
	    param1[1]=request.getParameter("nurse");
	    param1[2]=request.getParameter("alert");
            param1[3]=request.getParameter("midwife");
	    param1[4]="<unotes>"+ request.getParameter("notes")+"</unotes>";
	    param1[5]=request.getParameter("demographic_no");
        rowsAffected = apptMainBean.queryExecuteUpdate(param1, "update_custrecord");
        
    } else { //add
	    String[] param2 =new String[6];
	    param2[0]=request.getParameter("demographic_no");
	    param2[1]=request.getParameter("resident");
	    param2[2]=request.getParameter("nurse");
	    param2[3]=request.getParameter("alert");
	    param2[4]=request.getParameter("midwife");
	    param2[5]="<unotes>"+ request.getParameter("notes")+"</unotes>";
        rowsAffected = apptMainBean.queryExecuteUpdate(param2, "add_custrecord");
    }    
    
    if (vLocale.getCountry().equals("BR")) {
	    //find the demographic_ptbr record for update
	    rs = apptMainBean.queryResults(request.getParameter("demographic_no"),"search_demographic_ptbr");
	    if(rs.next() ) { //update
	  	 	String[] parametros = new String[13];
  	  	
	  	  	parametros[0]=request.getParameter("cpf");
	  	  	parametros[1]=request.getParameter("rg");
	  	  	parametros[2]=request.getParameter("chart_address");
	  	  	parametros[3]=request.getParameter("marriage_certificate");
	  	  	parametros[4]=request.getParameter("birth_certificate");
	  	  	parametros[5]=request.getParameter("marital_state");
	  	  	parametros[6]=request.getParameter("partner_name");
	  	  	parametros[7]=request.getParameter("father_name");
	  	  	parametros[8]=request.getParameter("mother_name");
	  	  	parametros[9]=request.getParameter("district");
	  	  	parametros[10]=request.getParameter("address_no")==null || request.getParameter("address_no").trim().equals("")?"0":request.getParameter("address_no");
	  	  	parametros[11]=request.getParameter("complementary_address");
	  	  	parametros[12]=request.getParameter("demographic_no");
  	
	  		rowsAffected = apptMainBean.queryExecuteUpdate(parametros,"update_record_ptbr");
    
	    }else{//add
	 	 	String[] parametros = new String[13];
	  	  	
	  	  	parametros[0]=request.getParameter("demographic_no");
	  	  	parametros[1]=request.getParameter("cpf");
	  	  	parametros[2]=request.getParameter("rg");
	  	  	parametros[3]=request.getParameter("chart_address");
	  	  	parametros[4]=request.getParameter("marriage_certificate");
	  	  	parametros[5]=request.getParameter("birth_certificate");
	  	  	parametros[6]=request.getParameter("marital_state");
	  	  	parametros[7]=request.getParameter("partner_name");
	  	  	parametros[8]=request.getParameter("father_name");
	  	  	parametros[9]=request.getParameter("mother_name");
	  	  	parametros[10]=request.getParameter("district");
	  	  	parametros[11]=request.getParameter("address_no")==null || request.getParameter("address_no").trim().equals("")?"0":request.getParameter("address_no");
	  	  	parametros[12]=request.getParameter("complementary_address");
  	
  	
	  		rowsAffected = apptMainBean.queryExecuteUpdate(parametros,"add_record_ptbr");
	    }
	}
    //add to waiting list if the waiting_list parameter in the property file is set to true
   
    WaitingList wL = WaitingList.getInstance();
    if(wL.getFound()){
        //Use  WLWaitingListUtil.updateWaitingListRecord()  instead of the original approach  
 	 
 	  WLWaitingListUtil.updateWaitingListRecord( 
 	  request.getParameter("list_id"), request.getParameter("waiting_list_note"),  
 	  request.getParameter("demographic_no"), request.getParameter("waiting_list_referral_date")); 
 	 
        %>
<form name="add2WLFrm" action="../oscarWaitingList/Add2WaitingList.jsp">
<input type="hidden" name="listId"
	value="<%=request.getParameter("list_id")%>" /> <input type="hidden"
	name="demographicNo"
	value="<%=request.getParameter("demographic_no")%>" /> <input
	type="hidden" name="demographic_no"
	value="<%=request.getParameter("demographic_no")%>" /> <input
	type="hidden" name="waitingListNote"
	value="<%=request.getParameter("waiting_list_note")%>" /> <input
	type="hidden" name="onListSince"
	value="<%=request.getParameter("waiting_list_referral_date")%>" /> <input
	type="hidden" name="displaymode" value="edit" /> <input type="hidden"
	name="dboperation" value="search_detail" /> <%
        if(!request.getParameter("list_id").equalsIgnoreCase("0")){
            String[] paramWLChk = new String[2];
            paramWLChk[0] = request.getParameter("demographic_no");
            paramWLChk[1] = request.getParameter("list_id");    
            //check if patient has already added to the waiting list and check if the patient already has an appointment in the future
            rs = apptMainBean.queryResults(paramWLChk, "search_demo_waiting_list");

            if(!rs.next()){
                ResultSet rsAppt = apptMainBean.queryResults(paramWLChk[0], "search_future_appt");
                if(rsAppt.next()){                
            %> <script language="JavaScript">                    
                    var add2List = confirm("The patient already has an appointment, do you still want to add him/her to the waiting list?");                
                    if(add2List){                       
                        document.add2WLFrm.action = "../oscarWaitingList/Add2WaitingList.jsp?demographicNo=<%=request.getParameter("demographic_no")%>&listId=<%=request.getParameter("list_id")%>&waitingListNote=<%=request.getParameter("waiting_list_note")==null?"":request.getParameter("waiting_list_note")%>&onListSince=<%=request.getParameter("waiting_list_referral_date")==null?"":request.getParameter("waiting_list_referral_date")%>"; 
                    }
                    else{
                        document.add2WLFrm.action ="demographiccontrol.jsp?demographic_no=<%=request.getParameter("demographic_no")%>&displaymode=edit&dboperation=search_detail";
                    }                    
                    document.add2WLFrm.submit();  
                    </script> <%}            
                else{%> <script language="JavaScript">
                   document.add2WLFrm.action = "../oscarWaitingList/Add2WaitingList.jsp?demographicNo=<%=request.getParameter("demographic_no")%>&listId=<%=request.getParameter("list_id")%>&waitingListNote=<%=request.getParameter("waiting_list_note")==null?"":request.getParameter("waiting_list_note")%>&onListSince=<%=request.getParameter("waiting_list_referral_date")==null?"":request.getParameter("waiting_list_referral_date")%>";                         
                    document.add2WLFrm.submit();  
                </script> <%}
            }
            else{
                response.sendRedirect("demographiccontrol.jsp?demographic_no=" + request.getParameter("demographic_no") + "&displaymode=edit&dboperation=search_detail");
            }
        }
        else{
            response.sendRedirect("demographiccontrol.jsp?demographic_no=" + request.getParameter("demographic_no") + "&displaymode=edit&dboperation=search_detail");
        }
        %>
</form>
<%
    }
    else{
        response.sendRedirect("demographiccontrol.jsp?demographic_no=" + request.getParameter("demographic_no") + "&displaymode=edit&dboperation=search_detail");
    }
%>
<h2>Update a Provider Record Successfully !
<p><a
	href="demographiccontrol.jsp?demographic_no=<%=request.getParameter("demographic_no")%>&displaymode=edit&dboperation=search_detail"><%= request.getParameter("demographic_no") %></a></p>
</h2>
<%--
<script LANGUAGE="JavaScript">
     	self.opener.refresh();
      //self.close();
</script>
--%> <%  
    //response.sendRedirect("demographiccontrol.jsp?demographic_no=" + request.getParameter("demographic_no") + "&displaymode=edit&dboperation=search_detail");
    //response.sendRedirect("search.jsp");
    String ip = request.getRemoteAddr();
    String user = (String)session.getAttribute("user");
    LogAction.addLog((String) session.getAttribute("user"), LogConst.UPDATE, LogConst.CON_DEMOGRAPHIC,  request.getParameter("demographic_no") , request.getRemoteAddr(),request.getParameter("demographic_no"));
     
  } else {
%>
<h1>Sorry, fail to update !!! <%= request.getParameter("demographic_no") %>.</h1>
<%  
  } 
%>
<p></p>

</center>
</body>
</html:html>