<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Footer for home page
  --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.net.URLEncoder" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>

<%
    String sidebar = (String) request.getAttribute("dspace.layout.sidebar");
%>

            <%-- Right-hand side bar if appropriate --%>
<%
    if (sidebar != null)
    {
%>
	</div>
	<div class="col-md-3">
                    <%= sidebar %>
    </div>
    </div>       
<%
    }
%>
</div>
</main>
            <%-- Page footer --%>
    <footer class="navbar navbar-inverse2 navbar-bottom">
             <div id="designedby" class="container text-muted">
                <!-- <fmt:message key="jsp.layout.footer-default.theme-by"/> <a href="http://www.cineca.it"><img
                                        src="<%= request.getContextPath() %>/image/logo-cineca-small.png"
                                        alt="Logo CINECA" /></a>-->
    			<div id="footer_feedback" align="center" > <!--class="pull-right"-->                                   
                    <p class="text-muted" style="color: #FFF; font-size: small;">
                        <!--<fmt:message key="jsp.layout.footer-default.text"/>&nbsp;-
                        <a target="_blank" href="<%= request.getContextPath() %>/feedback"><fmt:message key="jsp.layout.footer-default.feedback"/></a>
                        <a href="<%= request.getContextPath() %>/htmlmap"></a>-->
                        El Repositorio UTM utiliza DSpace V.6.0. Hecho en México, 2019. Universidad Tecnológica de la Mixteca. Bajo la licencia <a  href="#" ><img src="../../../jspui/image/creative.png" alt="CreativeCommons"/></a> Atribución- No Comercial 4.0 Internacional (CC BY-NC 4.0)
                    </p>
                </div>
			</div>
    </footer>
    </body>
</html>