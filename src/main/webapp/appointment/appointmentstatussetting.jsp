<%@ page import="java.util.*,oscar.appt.status.model.*"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/security.tld" prefix="security"%>

<%
    if(session.getAttribute("userrole") == null )  response.sendRedirect("../logout.jsp");
    String roleName$ = (String)session.getAttribute("userrole") + "," + (String) session.getAttribute("user");
%>
<security:oscarSec roleName="<%=roleName$%>"
	objectName="_admin,_admin.userAdmin,_admin.schedule" rights="r" reverse="<%=true%>">
	<%response.sendRedirect("../logout.jsp");%>
</security:oscarSec>

<%
if(session.getAttribute("user") == null ) //|| !((String) session.getValue("userprofession")).equalsIgnoreCase("admin"))
	response.sendRedirect("../logout.jsp");
  //instatiate/configure the main bean, forward the request to the output file
%>

<html>
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<title><bean:message key="admin.appt.status.mgr.title" /></title>
</head>
<link rel="stylesheet" type="text/css" media="all" href="../share/css/extractedFromPages.css"  />
<body>
<%
        String reseturl = request.getContextPath();
        reseturl = reseturl + "/appointment/apptStatusSetting.do?dispatch=reset";
    %>
<table border=0 cellspacing=0 cellpadding=0 width="100%">
	<tr bgcolor="#486ebd">
		<th align="CENTER" NOWRAP><font face="Helvetica" color="#FFFFFF"><bean:message
			key="admin.appt.status.mgr.title" /></font></th>
		<th align="right" NOWRAP><font face="Helvetica" color="#CCCCCC"><a
			href=<%=reseturl%>>reset</a></font></th>
	</tr>
</table>


<table class="borderAll" width="100%">
	<tr>
		<th><bean:message key="admin.appt.status.mgr.label.status" /></th>
		<th><bean:message key="admin.appt.status.mgr.label.desc" /></th>
		<th><bean:message key="admin.appt.status.mgr.label.color" /></th>
		<th><bean:message key="admin.appt.status.mgr.label.enable" /></th>
		<th><bean:message key="admin.appt.status.mgr.label.active" /></th>
		<th>&nbsp;</th>
	</tr>
	<%
            List apptsList = (List) request.getAttribute("allStatus");
            AppointmentStatus apptStatus = null;
            int iStatusID = 0;
            String strStatus = "";
            String strDesc = "";
            String strColor = "";
            int iActive = 0;
            int iEditable = 0;
            for (int i = 0; i < apptsList.size(); i++) {
                apptStatus = (AppointmentStatus) apptsList.get(i);
                iStatusID = apptStatus.getId();
                strStatus = apptStatus.getStatus();
                strDesc = apptStatus.getDescription();
                strColor = apptStatus.getColor();
                iActive = apptStatus.getActive();
                iEditable = apptStatus.getEditable();
%>
	<tr class=<%=(i % 2 == 0) ? "even" : "odd"%>>
		<td class="nowrap"><%=strStatus%></td>
		<td class="nowrap"><%=strDesc%></td>
		<td class="nowrap" bgcolor="<%=strColor%>"><%=strColor%></td>
		<td class="nowrap"><%=iActive%></td>
		<td class="nowrap">
		<%
    String url = request.getContextPath();
    url = url + "/appointment/apptStatusSetting.do?dispatch=modify&statusID=";
    url = url + iStatusID;
        %> <a href=<%=url%>>Edit</a> &nbsp;&nbsp;&nbsp; <%
    int iToStatus = (iActive > 0) ? 0 : 1;
    url = request.getContextPath();
    url = url + "/appointment/apptStatusSetting.do?dispatch=changestatus&iActive=";
    url = url + iToStatus;
    url = url + "&statusID=";
    url = url + iStatusID;
    if (iEditable == 1) {
        %> <a href=<%=url%>><%=(iActive > 0) ? "Disable" : "Enable"%></a>
		<%
    }
        %>
		</td>
	</tr>
	<%
            }
%>
</table>
<br>

<%
    String strUseStatus = (String)request.getAttribute("useStatus");
    if (null!=strUseStatus && strUseStatus.length()>0)
    {
%>
The code [<%=strUseStatus%>] has been used before, please enable that
status.
<%
    }
%>
</body>
</html>