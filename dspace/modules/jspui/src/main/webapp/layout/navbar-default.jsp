<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Default navigation bar
--%>

<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="/WEB-INF/dspace-tags.tld" prefix="dspace" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale"%>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ page import="org.dspace.core.I18nUtil" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.content.Collection" %>
<%@ page import="org.dspace.content.Community" %>
<%@ page import="org.dspace.eperson.EPerson" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>
<%@ page import="org.dspace.browse.BrowseIndex" %>
<%@ page import="org.dspace.browse.BrowseInfo" %>
<%@ page import="java.util.Map" %>
<%
    // Is anyone logged in?
    EPerson user = (EPerson) request.getAttribute("dspace.current.user");

    // Is the logged in user an admin
    Boolean admin = (Boolean)request.getAttribute("is.admin");
    boolean isAdmin = (admin == null ? false : admin.booleanValue());

    Boolean communityAdmin = (Boolean)request.getAttribute("is.communityAdmin");
    boolean isCommunityAdmin = (communityAdmin == null ? false : communityAdmin.booleanValue());
    
    Boolean collectionAdmin = (Boolean)request.getAttribute("is.collectionAdmin");
    boolean isCollectionAdmin = (collectionAdmin == null ? false : collectionAdmin.booleanValue());

    // Get the current page, minus query string
    String currentPage = UIUtil.getOriginalURL(request);
    int c = currentPage.indexOf( '?' );
    if( c > -1 )
    {
        currentPage = currentPage.substring( 0, c );
    }

    // E-mail may have to be truncated
    String navbarEmail = null;

    if (user != null)
    {
        navbarEmail = user.getEmail();
    }
    
    // get the browse indices
    
  BrowseIndex[] bis = BrowseIndex.getBrowseIndices();
    BrowseInfo binfo = (BrowseInfo) request.getAttribute("browse.info");
    String browseCurrent = "";
    if (binfo != null)
    {
        BrowseIndex bix = binfo.getBrowseIndex();
        // Only highlight the current browse, only if it is a metadata index,
        // or the selected sort option is the default for the index
        if (bix.isMetadataIndex() || bix.getSortOption() == binfo.getSortOption())
        {
            if (bix.getName() != null)
          browseCurrent = bix.getName();
        }
    }
 // get the locale languages
    Locale[] supportedLocales = I18nUtil.getSupportedLocales();
    Locale sessionLocale = UIUtil.getSessionLocale(request);
%>


       <div class="navbar-header">
         <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
           <span class="icon-bar"></span>
           <span class="icon-bar"></span>
           <span class="icon-bar"></span>
         </button>
         <a class="navbar-brand" href="<%= request.getContextPath() %>/"><img height="25" src="<%= request.getContextPath() %>/image/logo-only.png" alt="DSpace logo" /></a>
       </div>
       <nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
                         <!--mmmmmmmmmmmmmmmmmmmmmmmmmmenuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu-->
         <ul class="nav navbar-nav">
           
           <!--<li class="<%= currentPage.endsWith("/home.jsp")? "active" : "" %>"><a href="<%= request.getContextPath() %>/"><span class="glyphicon glyphicon-home"></span> <fmt:message key="jsp.layout.navbar-default.home"/></a></li>-->

           <li class="<%= currentPage.endsWith("/home.jsp")? "active" : "" %>"><a href="<%= request.getContextPath() %>/"><span class="glyphicon glyphicon-home"></span> <fmt:message key="jsp.layout.navbar-default.home"/></a></li>
           <!--incio-->
                
           <li class="dropdown">
             <!--<a href="#" class="dropdown-toggle" data-toggle="dropdown"><fmt:message key="jsp.layout.navbar-default.browse"/> <b class="caret"></b></a>-->

            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><fmt:message key="jsp.layout.navbar-default.browse"/> <b class="caret"></b></a> <!--busqueda-->

             <ul class="dropdown-menu">
               <!--<li><a href="<%= request.getContextPath() %>/community-list"><fmt:message key="jsp.layout.navbar-default.communities-collections"/></a></li>-->
               <li><a href="<%= request.getContextPath() %>/community-list"><fmt:message key="jsp.layout.navbar-default.communities-collections"/></a></li> <!--comunidades y colecciones-->

              <li class="divider"></li>
              <!--<li class="dropdown-header"><fmt:message key="jsp.layout.navbar-default.browseitemsby"/></li>-->
              <li class="dropdown-header"><fmt:message key="jsp.layout.navbar-default.browseitemsby"/> </li> <!--buscar por-->
              <%-- Insert the dynamic browse indices here --%>
              
              <%
                for (int i = 0; i < bis.length; i++)
                {
                  BrowseIndex bix = bis[i];
                  String key = "browse.menu." + bix.getName();

                  String menu[] = {"Fecha de publicación", "Autor", "Título", "Tema", "Fecha de envío"};
                  
                %>
                          <li><a href="<%= request.getContextPath() %>/browse?type=<%= bix.getName() %>"><fmt:message key="<%= key %>"/></a></li>
                         <!-- <li><a href="<%= request.getContextPath() %>/browse?type=<%= bix.getName() %>"><%=menu[i] %></a></li>-->
                <%  
                 }
              %>
                  
              <%-- End of dynamic browse indices --%>

                  </ul>
          </li>       
          

         <!-- <li class="<%= ( currentPage.endsWith( "/help" ) ? "active" : "" ) %>"><a>Estadísticas</a></li>-->
       </ul>

 <% if (supportedLocales != null && supportedLocales.length > 1)
     {
 %>
    <div class="nav navbar-nav navbar-right">
   <ul class="nav navbar-nav navbar-right">
      <li class="dropdown">
       <a href="#" class="glyphicon glyphicon-globe" data-toggle="dropdown"><!-- <fmt:message key="jsp.layout.navbar-default.language"/> --><b class="caret"></b></a>
        <ul class="dropdown-menu">
 <%
    for (int i = supportedLocales.length-1; i >= 0; i--)
     {
 %>
      <li>
        <a onclick="javascript:document.repost.locale.value='<%=supportedLocales[i].toString()%>';
                  document.repost.submit();" href="<%= currentPage %>?locale=<%=supportedLocales[i].toString()%>">
         <%= supportedLocales[i].getDisplayLanguage(supportedLocales[i])%>
       </a>
      </li>
 <%
     }
 %>
     </ul>
    </li>
    </ul>
  </div>
 <%
   }
 %>
 
       <div class="nav navbar-nav navbar-right">
    <ul class="nav navbar-nav navbar-right">
          <!--manuales-->

          <li class="dropdown">
            <a href="" class="dropdown-toggle" data-toggle="dropdown">
              <span class="glyphicon glyphicon-question-sign"></span> Más información <b class="caret"></b></a>

              <ul class="dropdown-menu">
                <li><button type="button" class="btn btn-outline-light" data-toggle="modal" data-target="#depositariosModal" style="color: black; ">
            Información para los depositarios
          </button>
                  </li>
                <li><a href="Files/example.pdf" download="manual RI UTM">Manual de uso del RI</a></li>
                <li><a href="#">Video-tutoriales</a></li>
                <li><a href="Files/example.pdf" download="creative commons">Licencia Creative Commons</a></li>
              </ul>
          </li>


          <!--admin-->
         <li class="dropdown" >
         <%
    if (user != null)
    {
    %>
    <a href="#" class="dropdown-toggle" style="color: #fff" data-toggle="dropdown"><span class="glyphicon glyphicon-user"></span> 
         <!--<fmt:message key="jsp.layout.navbar-default.loggedin">
          <fmt:param><%= StringUtils.abbreviate(navbarEmail, 13) %></fmt:param>
      </fmt:message> -->
      <%= StringUtils.abbreviate(navbarEmail, 20) %>
      <b class="caret"></b></a>
    <%
    } else {
    %>
             <!--<a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-user"></span> <fmt:message key="jsp.layout.navbar-default.sign"/> <b class="caret"></b></a>-->
             <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-user"></span> Admin <b class="caret"></b></a>

             <!--<a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-user"></span> Admin<b class="caret"></b></a>-->
  <% } %>             
             <ul class="dropdown-menu">
               <li><a href="<%= request.getContextPath() %>/mydspace"><fmt:message key="jsp.layout.navbar-default.users"/></a></li>
               <li><a href="<%= request.getContextPath() %>/subscribe"><fmt:message key="jsp.layout.navbar-default.receive"/></a></li>
               <li><a href="<%= request.getContextPath() %>/profile"><fmt:message key="jsp.layout.navbar-default.edit"/></a></li>

    <%
                if (isAdmin || isCommunityAdmin || isCollectionAdmin) {
                %>
         <li class="divider"></li>
                           <% if (isAdmin) {%>
                    
                                <li><a href="<%= request.getContextPath()%>/dspace-admin">
                           <% } else if (isCommunityAdmin || isCollectionAdmin) {%>
                        
                                <li><a href="<%= request.getContextPath()%>/tools">
                <% } %>
                <fmt:message key="jsp.administer"/></a></li>
                <%
                    }
      if (user != null) {
    %>
    <li ><a  href="<%= request.getContextPath() %>/logout"><span class="glyphicon glyphicon-log-out"></span> <fmt:message key="jsp.layout.navbar-default.logout"/></a></li>
    <% } %>
             </ul>
                    
           </li>           
          </ul>
          
  <%-- Search Box --%>
  <form method="get" action="<%= request.getContextPath() %>/simple-search" class="navbar-form navbar-right">
      <div class="form-group">
          <!--<input type="text" class="form-control" placeholder="<fmt:message key="jsp.layout.navbar-default.search"/>" name="query" id="tequery" size="25"/>-->
          <input type="text" class="form-control" placeholder="<fmt:message key="jsp.layout.navbar-default.search"/>" name="query" id="tequery" size="25"/>
        </div>
        <button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span></button>


<%--               <br/><a href="<%= request.getContextPath() %>/advanced-search"><fmt:message key="jsp.layout.navbar-default.advanced"/></a>
<%
      if (ConfigurationManager.getBooleanProperty("webui.controlledvocabulary.enable"))
      {
%>        
              <br/><a href="<%= request.getContextPath() %>/subject-search"><fmt:message key="jsp.layout.navbar-default.subjectsearch"/></a>
<%
            }
%> --%>
  </form>
</div>
  <div class="modal fade" id="depositariosModal" tabindex="-1" role="dialog" aria-labelledby="depositariosModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document" style="
    overflow-y: initial !important
">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
          <h4 class="modal-title" id="depositariosModalLabel" style="text-align: center; color: #4c000e;">Información para los Depositarios</h4>
        </div>
        <div class="modal-body" style="
    height: 40vw;
    overflow-y: auto;">      
          <p style="color: #6b6b6b;">
                  ¿Qué es el RI-UTM?
Es una plataforma que emplea estándares internacionales y mecanismos de acceso abierto para albergar publicaciones e información académica, científica y tecnológica generada en nuestra institución. La visibilidad de esta producción se logra a través de la conexión con el Repositorio Nacional (RN) de CONACYT.
El RI-UTM funcionará como una memoria institucional, difundiendo y preservando la producción científica evaluada por pares de la comunidad de manera libre, inmediata, gratuita y protegida. Gracias a esta difusión se fomentarán las discusiones académicas, se crearán comunidades de colaboración y se acelerará el desarrollo del conocimiento.
¿Por qué publicar en el RI-UTM?
    • Acelerar el proceso de comunicación y difusión de la ciencia. 
    • Permitir elevar la visibilidad de las investigaciones realizadas en la UTM. 
    • Aumentar la proyección del perfil de los investigadores a una escala nacional e internacional, así como el impacto de sus investigaciones.
    • Mostrar la producción científica de la institución y dar seguimiento al impacto de las investigaciones de los estudiantes y  profesores.
    • Desarrollar y fortalecer una cultura de aprendizaje permanente.
    • Ahorrar costos al tener acceso a los contenidos del repositorio sin pagar suscripciones.
    • Fomentar la creación de publicaciones electrónicas.

          </p>
          
     
        </div>
      </div>
    </div>
  </div>
    </nav>
