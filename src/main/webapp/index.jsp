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

<%@page import="oscar.OscarProperties, oscar.util.BuildInfo, javax.servlet.http.Cookie, oscar.oscarSecurity.CookieSecurity, oscar.login.UAgentInfo" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/caisi-tag.tld" prefix="caisi" %>
<caisi:isModuleLoad moduleName="ticklerplus"><%
    if(session.getValue("user") != null) {
        response.sendRedirect("provider/providercontrol.jsp");
    }
%></caisi:isModuleLoad><%
OscarProperties props = OscarProperties.getInstance();

// clear old cookies
Cookie rcpCookie = new Cookie(CookieSecurity.receptionistCookie, "");
Cookie prvCookie = new Cookie(CookieSecurity.providerCookie, "");
Cookie admCookie = new Cookie(CookieSecurity.adminCookie, "");
rcpCookie.setPath("/");
prvCookie.setPath("/");
admCookie.setPath("/");
response.addCookie(rcpCookie);
response.addCookie(prvCookie);
response.addCookie(admCookie);

// Initialize browser info variables
String userAgent = request.getHeader("User-Agent");
String httpAccept = request.getHeader("Accept");
UAgentInfo detector = new UAgentInfo(userAgent, httpAccept);

// This parameter exists only if the user clicks the "Full Site" link on a mobile device
if (request.getParameter("full") != null) {
    session.setAttribute("fullSite","true");
}

// If a user is accessing through a smartphone (currently only supports mobile browsers with webkit),
// and if they haven't already clicked to see the full site, then we set a property which is
// used to bring up iPhone-optimized stylesheets, and add or remove functionality in certain pages.
if (detector.detectSmartphone() && detector.detectWebkit()  && session.getAttribute("fullSite") == null) {
    session.setAttribute("mobileOptimized", "true");
} else {
    session.removeAttribute("mobileOptimized");
}
Boolean isMobileOptimized = session.getAttribute("mobileOptimized") != null;
%>

<html:html locale="true">
    <head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
        <html:base/>
        <% if (isMobileOptimized) { %><meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, width=device-width"/><% } %>
        <title>
            <% if (props.getProperty("logintitle", "").equals("")) { %>
            <bean:message key="loginApplication.title"/>
            <% } else { %>
            <%= props.getProperty("logintitle", "")%>
            <% } %>
        </title>
        <!--LINK REL="StyleSheet" HREF="web.css" TYPE="text/css"-->

        <script language="JavaScript">
  <!-- hide
  function setfocus() {
    document.loginForm.username.focus();
    document.loginForm.username.select();
  }
  function popupPage(vheight,vwidth,varpage) {
    var page = "" + varpage;
    windowprops = "height="+vheight+",width="+vwidth+",location=no,scrollbars=yes,menubars=no,toolbars=no,resizable=yes";
    var popup=window.open(page, "gpl", windowprops);
  }
  -->
        </script>
        
        <style type="text/css">
            body { 
               font-family: Verdana, helvetica, sans-serif;
               margin: 0px;
               padding:0px;
            }
            
            td.topbar{
               background-color: gold;
            }
            td.leftbar{
                background-color: #009966;
                color: white;
            }
            td.leftinput{
                background-color: #f5fffa;
            }
            td#loginText{
                width:200px;
                font-size: small;
                }
            span#buildInfo{
                float: right; color:#FFFFFF; font-size: xx-small; text-align: right;
            }
                span.extrasmall{
                    font-size: x-small;
                }
            #mobileMsg { display: none; }
        </style>
        <% if (isMobileOptimized) { %>
        <!-- Small adjustments are made to the mobile stylesheet -->
        <style type="text/css">
            html { -webkit-text-size-adjust: none; }
            td.topbar{ width: 75%; }
            td.leftbar{ width: 25%; }
            span.extrasmall{ font-size: small; }
            #browserInfo, #logoImg, #buildInfo { display: none; }
            #mobileMsg { display: inline; }
        </style>
        <% } %>
    </head>
    
    <body onLoad="setfocus()" bgcolor="#ffffff">
        
        <table border=0 width="100%">
            <tr>
                <td align="center" class="leftbar" height="20px" width="200px"><%
                    String key = "loginApplication.formLabel" ;
                    if(request.getParameter("login")!=null && request.getParameter("login").equals("failed") )
                    key = "loginApplication.formFailedLabel" ;
                    %><bean:message key="<%=key%>"/>        
                </td>
                <td  class="topbar" align="center" >
                    <span id="buildInfo">build date: <%= BuildInfo.getBuildDate() %> <br/> build tag: <%=BuildInfo.getBuildTag()%> </span>
                    <%=props.getProperty("logintitle", "")%>
                    <% if (props.getProperty("logintitle", "").equals("")) { %>
                    <bean:message key="loginApplication.alert"/>
                    <% } %>                    
                </td>
            </tr>
        </table>
        <table class="leftinput" border="0" width="100%">
            <tr>
                <td id="loginText" valign="top">
                    <!--- left side -->
                        
                            <html:form action="login" >
                            <bean:message key="loginApplication.formUserName"/><%
                            if(oscar.oscarSecurity.CRHelper.isCRFrameworkEnabled() && !net.sf.cookierevolver.CRFactory.getManager().isMachineIdentified(request)){
                            %><img src="gatekeeper/appid/?act=image&/empty<%=System.currentTimeMillis() %>.gif" width='1' height='1'><%
                            }
                            %>
                        
                        <br/>            
                        <input type="text" name="username" value="" size="15" maxlength="15" autocomplete="off"/>
                        <br/>                
                        <bean:message key="loginApplication.formPwd"/><br/>
                        <input type="password" name="password" value="" size="15" maxlength="15" autocomplete="off"/><br/>
                                <input type="submit" value="<bean:message key="index.btnSignIn"/>" />
                        <br/>
                        <bean:message key="index.formPIN"/>: 
                        <br/>
                        <input type="password" name="pin" value="" size="15" maxlength="15" autocomplete="off"/><br/>
                       
                        <span class="extrasmall">
                            <bean:message key="loginApplication.formCmt"/>
                        </span>
                        <input type=hidden name='propname' value='<bean:message key="loginApplication.propertyFile"/>' />
                        </html:form>
                        <hr width="100%" color="navy">
                        
                        <span class="extrasmall">
                            <div id="mobileMsg"><bean:message key="loginApplication.mobileMsg"/>
                                <a href="index.jsp?full=true"><bean:message key="loginApplication.fullSite"/></a>
                                <br/><br/>
                            </div>
                            <div id="browserInfo"><bean:message key="loginApplication.leftRmk1"/></div>
                            <bean:message key="loginApplication.leftRmk2" />
                            <a href=# onClick='popupPage(500,700,"<bean:message key="loginApplication.gpltext"/>")'><bean:message key="loginApplication.gplLink"/></a>
                            <br/>
                            <img style="width: 26px; height: 18px;" alt="<bean:message key="loginApplication.image.i18nAlt"/>"
                            title="<bean:message key="loginApplication.image.i18nTitle"/>"
                            src="<bean:message key="loginApplication.image.i18n"/>">
                            <bean:message key="loginApplication.i18nText"/>

                        </span>
                    <!-- left side end-->
                </td>
                <td id="logoImg" align="center" valign="top">
                    <div style="margin-top:25px;"><% if (props.getProperty("loginlogo", "").equals("")) { %>
                            <html:img srcKey="loginApplication.image.logo" width="450" height="274"/>
                            <% } else { %>
                            <img src="<%=props.getProperty("loginlogo", "")%>">
                            <% } %>
                            <p>
                            <font face="Verdana, Arial, Helvetica, sans-serif" size="-1">
                                <% if (props.getProperty("logintext", "").equals("")) { %>
                                <bean:message key="loginApplication.image.logoText"/>
                                <% } else { %>
                                <%=props.getProperty("logintext", "")%>
                                <% } %>
                            </font>
                    </div>
                    
                </td>
            </tr>     
        </table>
        
    </body>
</html:html>